Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF79C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 11:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2CC10E472;
	Tue, 31 Oct 2023 11:02:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA8610E472
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 11:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaJAdqdvvjbLrtAJQqDWbdHvko+cHk31etu9UcoxB0HD6mlKBMCnsyV98aCSf/OlmXwJr/MB3yeAx23VpCMzxbXOFtlDId9t9Km4+AcelgHcM1wbICDX5vEZZ8S2Amcs41vZJM3PkRlLlPLZeOgPh+g+XtezpYsfjq6rPVYRDmvSjROmDim7TKqPdbkRI5prLKWaEeLfLENIl7dbvyJP8jQ4nLiFQzNHPFMblM94bFpXVL6yO+xmHOuxEkvhXjR2Z3eYyLLz6f2t99d/sRqrGoBk9WuF8p5hac+CxOd+V+lBDkuZ2zXE75Mj1rLKlNP1z2WFl45jS+cwlC5gou03lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzQPL912gjop6nZtdHYSn6iGQpKW6VyiKkr6RHFrWQ4=;
 b=fnfjB9eIjaHJXKXgac9XE8VwQYtyzXklj7Qpl3MzGhvbXzk6JAH6NELPn2ez/EUNDAOTE8mcIcOpc+OISQcnjV3/uo/G+prloFyDvCQOr+XP2AcSQdpeIy/8+3mfYEp8fILw/eTkhrAMfZnMweI7RMlvsR8OWvUDFAj8VabBjBDX+ww0Ad36d4loH3+yAvXw5cyVzeCF/jp7mo9BJFJYNk+3j5jxND4EwfynF5XV9gjpaEBK3hfBZU4V+YBxOqXwJx4l8onxa7kq5i/ZrW+xtsh71gmNftnhe73hD7YrXRtNSwPZa6Xfwk5X4DUYwoIK0mluFxBxl+B6jIeFhav1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzQPL912gjop6nZtdHYSn6iGQpKW6VyiKkr6RHFrWQ4=;
 b=3Pja4yOJLnMhRyUAk3aEgWbQGKjoeBn6+7i4VdDJ4RrYFTR36EADgTiCrVzWRSIi+31nL6QKKQYfc2bmS9200VvO+x4ZmPUcxjPn3dPWLLz0Vltksmy0VtLCyOS4/UGc2XhGdbI+GI28MzbE/don32tY7HZXwR6PUtKB4BDOE8g=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Tue, 31 Oct
 2023 11:02:16 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::a6f6:4f5f:f381:bb7f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::a6f6:4f5f:f381:bb7f%5]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 11:02:16 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: handle extra UE register entries for gfx
 v9_4_3
Thread-Topic: [PATCH] drm/amdgpu: handle extra UE register entries for gfx
 v9_4_3
Thread-Index: AQHaC8kkb5Ev8QLq8EysPapxR8JtpbBju1/w
Date: Tue, 31 Oct 2023 11:02:16 +0000
Message-ID: <PH7PR12MB7988ADEFB5BC31503519DD609AA0A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231031070843.16461-1-tao.zhou1@amd.com>
In-Reply-To: <20231031070843.16461-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5ad06575-70ce-4e12-851d-13b02d3ad229;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-31T11:00:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|SA1PR12MB9248:EE_
x-ms-office365-filtering-correlation-id: e47a6e72-ecb4-4b89-f033-08dbda00d833
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ykIm7t2vTw2P7v7aJ1BmguggJ4gdFaigb9Jg4Vhzsw7ibWgA02Uam0F89Lw13/13mdIayPAYP8RnZTfrgeaUSvJKGJVWIkmNq3P9NlxD3ZThrCsfQN4TmVKtkP1WOQDTzX7lPnm4O6AcU2zHWL2w8wou1cP32qxL+DCOoAq6PJtfWrOg+zGLBg5guiCIKrBqTmCBBlghQqAhbmbBNtNoG1DZ1Q9UmQNcAmy02eWtV37tlIHeONetLVCuu+cJU2mjhO4jNQLXOhS9VXx3uOS2wascyBQ+jm6UUaOd9o5fkNsQ5H2Gu9P2MgYNW8DreZeu/g5QU79mjTEmt8S2B8bUu7YHML5M4sRa7Kf0l275RkbqggmQVVSQ6S3xNfxh5raqvgOieum5xJ7u3G8h2ocsIW/44gE1iKvGifa0QmQNItH+LBdpUik7VrVYbvpYHbQzI3j/0vNup4HMWsPrBegeTOPWaglcV/7X0CsdeJchRX7dXGZj5ZdTXyJWzTcU0lVhzBC9sBOWt9SkYwIEmYUvMR+V5evJyyRF6Yy+vbqjufcM83DDAjcPw8mRqkEgiJ1fpRj4GxwSKlyDbmpdsm4yAD6jqMgKexz7h5bnEdwn9tB8H3F3Q/VVDVxiZNw8dQv9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(55016003)(9686003)(71200400001)(7696005)(122000001)(6506007)(38100700002)(478600001)(76116006)(66946007)(26005)(110136005)(83380400001)(53546011)(64756008)(66446008)(66556008)(66476007)(316002)(54906003)(8936002)(52536014)(8676002)(4326008)(5660300002)(33656002)(86362001)(2906002)(41300700001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uUWGv5V/o4mjBWym0aSmcZEl3I0Liv3+C3rp7JDesRV0UZdPIYH4c4FtEMeA?=
 =?us-ascii?Q?hIg/1ydQwu1xvI50Xfm7kCBWYYen4C1eVQ6a/2dJ6NLOo6DbdhDj9KEHeMqc?=
 =?us-ascii?Q?BUNgpUyit1kkp9t0RQNz4x8YRZCdglvWHoyjYu56E3l91owO3/siLtaulDt4?=
 =?us-ascii?Q?MoMqHKGg5APrA43O7rcs9JYhPBSz6pTqXZWUUZ1DueB9RkCZshMPX3f0QdaB?=
 =?us-ascii?Q?hszBYy4QBFqifEH32Do8eN7wPHv07ripW3XEwEOcTCeDk6aL4g3E/yehcFeL?=
 =?us-ascii?Q?03cyzM9MZzBs9gtfmyCzDH7ym7ArRZjn+5OaKCvkr4mTDo+EISzsSHWpKtE1?=
 =?us-ascii?Q?EYJ0JWbADq7TjiC8bxvmxzDqKSw+26VzBDACE+GdkiCUOFI5ISAYCZ+GjDzZ?=
 =?us-ascii?Q?JHkMMclj05Gs1XIJ8rmVlq2fdoKQLnnDIx0m+4Ws9BCEINxq32p/1BDsmVdP?=
 =?us-ascii?Q?Dx4wZ0INIcpZJ5902hzGMeJb/UGcdr95M5DZPJefZSJRooND2ODo1Ic8Uo8I?=
 =?us-ascii?Q?5PMECkCjmtW9/6hf176RY6E9ubCag4qOG+79hIHUnO0orvlSyGFgo3KrgsY4?=
 =?us-ascii?Q?/eveNn65SK7bDEOB4QTFIimaYJLA0rPWAKizZQ3AY2W8Yrzp3K9InR4eRwMv?=
 =?us-ascii?Q?usC36VvqafraO8zi35XblUtflEyi2zocNCEniIPBjIwZUjKCFO/tsPDN43jh?=
 =?us-ascii?Q?EH5+WY8ODBKpb3wbhfCcHxnpIsEh3//IXBDxU5dEwFidwrY0ejEHhWMA0aLe?=
 =?us-ascii?Q?e59qenvfTya4j3vEt93WIh6YsUtpezetJhz9+gbQ3X6MVdvUjarDj1YPvGmu?=
 =?us-ascii?Q?vx0ijL7LvrWmS2SYCIuEv5bAWqA6+BkpiUO2hMZEs6qTFuDo9OTknqyoLmCk?=
 =?us-ascii?Q?F3L4SfI3r4hakHPdLeBApzeTkCQk8hilvEQelD6iKLhftFD6s6x/Wkzdm/5a?=
 =?us-ascii?Q?tXEJYKoydmNVRV1XCfiAvmzjITqiMOXhMKhM7ZrymbRZaseVC6pFSFA0b52n?=
 =?us-ascii?Q?e4FNwPH3LahwmhZ/NrPt62NkT6HZ6wfN3LVQEbRScz1S9GHcV636RpfkdPJ2?=
 =?us-ascii?Q?gBsMSs22Ymu9X9uj7wtronbGRlKQt45VUHxU4STmoeOgAB6O7p0f80GWG2cy?=
 =?us-ascii?Q?BquyHB2TC/5PSdchfPMgBNF7x6omFn0IaJGCJDL4jLCOCUCicyHEUamv//IM?=
 =?us-ascii?Q?Ftby2hlXc51D5LPse84idsTVfSFp47L0+87BYQI9j7sBRF6g82Od2KM3Z9BE?=
 =?us-ascii?Q?hFvJWZwaKnDoCqn+Eiu0ivENQh7i7WaN1AKtWj0qGa/J1FiXJnXNY7KxFL9v?=
 =?us-ascii?Q?shl7jdV+bmAorqwx8Jcqt5OtC8j8iJwJBsER+KB4wy18MAn45GSYCYFbkP78?=
 =?us-ascii?Q?Jl3cakM7whWKaTTPa6Zr+imf+WvlGVmRnL5sOikqVDcaaUb63/xRW07ziMNs?=
 =?us-ascii?Q?vYOy9YCufiB3hIwAS1fS/Y1URW/ldq8RhPV6tJQdkbrdGhEuqcO/TARe2wpq?=
 =?us-ascii?Q?BJbuH3vXTLYx6NY4J+cwGlzcIFqBfCQaLaZkPA3/OSKXqkbvBZg7p+NTnnAt?=
 =?us-ascii?Q?OnJR5Oq0FKN5NRWLWME=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47a6e72-ecb4-4b89-f033-08dbda00d833
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 11:02:16.4618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJ8w7gaYO78Yw3A5pCve29DgsdNQceIRGhWEDZrqf2KFrDeuWvzEYWxaddHQ8Xa2db8dGDLZvubvzF5Gluy1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Is it better to handle CE and UE list separately?
Anyway Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Tuesday, October 31, 2023 3:09 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: handle extra UE register entries for gfx v9_=
4_3
>
> The UE registe list is larger than CE list.
>
> Reported-by: yipeng.chai@amd.com
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 38
> +++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 41bbabd9ad4d..046ae95b366a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3799,6 +3799,27 @@ static void
> gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
>               }
>       }
>
> +     /* handle extra register entries of UE */
> +     for (; i < ARRAY_SIZE(gfx_v9_4_3_ue_reg_list); i++) {
> +             for (j =3D 0; j < gfx_v9_4_3_ue_reg_list[i].se_num; j++) {
> +                     for (k =3D 0; k <
> gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst; k++) {
> +                             /* no need to select if instance number is =
1 */
> +                             if (gfx_v9_4_3_ue_reg_list[i].se_num > 1 ||
> +
>       gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst > 1)
> +                                     gfx_v9_4_3_xcc_select_se_sh(adev, j=
,
> 0, k, xcc_id);
> +
> +
>       amdgpu_ras_inst_query_ras_error_count(adev,
> +
>       &(gfx_v9_4_3_ue_reg_list[i].reg_entry),
> +                                     1,
> +
>       gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ue_reg_list[i].mem_id_t
> ype].mem_id_ent,
> +
>       gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ue_reg_list[i].mem_id_t
> ype].size,
> +                                     GET_INST(GC, xcc_id),
> +
>       AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
> +                                     &ue_count);
> +                     }
> +             }
> +     }
> +
>       gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfffffff=
f,
>                       xcc_id);
>       mutex_unlock(&adev->grbm_idx_mutex);
> @@ -3838,6 +3859,23 @@ static void
> gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev,
>               }
>       }
>
> +     /* handle extra register entries of UE */
> +     for (; i < ARRAY_SIZE(gfx_v9_4_3_ue_reg_list); i++) {
> +             for (j =3D 0; j < gfx_v9_4_3_ue_reg_list[i].se_num; j++) {
> +                     for (k =3D 0; k <
> gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst; k++) {
> +                             /* no need to select if instance number is =
1 */
> +                             if (gfx_v9_4_3_ue_reg_list[i].se_num > 1 ||
> +
>       gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst > 1)
> +                                     gfx_v9_4_3_xcc_select_se_sh(adev, j=
,
> 0, k, xcc_id);
> +
> +
>       amdgpu_ras_inst_reset_ras_error_count(adev,
> +
>       &(gfx_v9_4_3_ue_reg_list[i].reg_entry),
> +                                     1,
> +                                     GET_INST(GC, xcc_id));
> +                     }
> +             }
> +     }
> +
>       gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfffffff=
f,
>                       xcc_id);
>       mutex_unlock(&adev->grbm_idx_mutex);
> --
> 2.35.1

