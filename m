Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C8DC77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 12:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB6910E5D0;
	Fri, 19 May 2023 12:03:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B06510E5DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 12:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgQQ7VkBOiKbMyhP/V9rh3qe71wGhpTVFC+Lc7+1AuCvwFyTOdHJmm8L9J5B/+5EaNITWiMd71DgDfJsVgIIG2QXoJ/z7+ZEIIK0W1ctXd/uTLG6mJ/buq1RdsB3WiKanyu+qmjhph6smyLQO2SKds1jsUD+yBt2JQe0VrMzCQTP/N+e9P+A+g/cC/992k9jwQR2ecSmx+uMnNgW+PEZECXZUyakOFMBt17pGYToX6/lNzjV0DTbTD8AnLxPkka/ObFU8S3qQws2gCTQoIrirdYzyeY9JR1hxOZNqhcw8kw42pYQ1xbxERq+QyQZb4HG2mSJMEt/5arKKnouZYUzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEmBC/RZgKchuwckhQeFmSxuue7eeQWqHrETOKHpdy4=;
 b=GXQLcKzBfM/nF2y6E+QPM3KGp1R8xezEhaej50HqSdSNojFSZA2fJhUCKCxaxG7Sa+fWHsl8jDinjZijp7XXDtoBg3rEn04FnHC9HQeSo5FvHBd5JIv8DpaflEUKnNUPFe6GvqwRACFDd7eVPMzGVCNKS07MkKBSYmHtZivlU26oKAmXcevqGf81qYem2kU9YSgxoz+SbLiMI+9L5YQhlz0TDQIbO/cOcPP9gGdSbemjVmggqvYIGauv36b+jdfwq31fEDI/09pp8L59h+KaBO9nFcJwM7FB/g/3qXPZScoepzbPc9iLTUPQlR2khqVgvtCQP7ADv3YUUDv2vXUwWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEmBC/RZgKchuwckhQeFmSxuue7eeQWqHrETOKHpdy4=;
 b=A9dlnRu9g5TSfz3vFZYeRd5JgxDPJbjTK7RnZGESSyaCHhe0Z2mq128kc/egvVuqg1BKL+/eUazrqOUcWuZzMmGg2hpvHQTLK5wMej9+fXblTQ35+/axWjz3ViMPsoGrGnTZHUC6P5O7dXXeRSj5HuR9uAz+i3Gca+biKLyOKyE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 12:03:50 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374%3]) with mapi id 15.20.6411.020; Fri, 19 May 2023
 12:03:50 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add missing NotifyPowerSource message mapping
 for SMU13.0.7
Thread-Topic: [PATCH] drm/amd/pm: add missing NotifyPowerSource message
 mapping for SMU13.0.7
Thread-Index: AQHZiicJb+r/ONhyVUq4NGzuTqjGya9hf2Gw
Date: Fri, 19 May 2023 12:03:50 +0000
Message-ID: <DM5PR12MB2469A856FF470A1C68AF1D9DF17C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230519075259.1650630-1-evan.quan@amd.com>
In-Reply-To: <20230519075259.1650630-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2babc0d7-3abf-43ea-bf0d-ec7540bc2d5b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-19T12:03:41Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|IA1PR12MB6579:EE_
x-ms-office365-filtering-correlation-id: 6372ceaf-1bc7-4757-9ed3-08db58611b9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irGmpqEfbuQ1lE3+1Qv6WDGul0hutX878Z3l+mkvQO2vpF+R8VTvFrTsyuzj2h9erVmL39fxK0l65o6UBVNliTIGVHrkZIG01K/90T0D82IFHhfVhvRGBJhbA0CBzLiaXDLMdwEc00uoTJjG3/4UTdl3JCG/csSeaLVZAf0ei94BWkVU3HrAXXmO9+SycpGP11ZZB5QOFg0Kp8ipY3zGBWOor68pi6F75vnTuRSISRD2aSVih5gn70HrbJyQ6lFR1yD+Ylckuo5fMS/UPK3KGguyEwjxHl6Meg9ObLRE0PrrSll0wmhd4xG672C/x0TiweT7+ImycO1Z9PLmS0lKrKfXlij2YMVQLCUJc7ueUFwqq51YkMQfx89b8E/JnHRs+E0bp2cOzqBDq3zRB0NsfiQxDhtPRJKrR1K8po2dLi2GIDK+llp3+Xo2d/AjEDLgwi30+EBXgfgrV7hdoRJxlEm6nXmpWlYTh14/jRi1gxX+zAERN+e7hlzsahM6QzVqo7wOs7hkbeOh+AQY/Lc8xNg7AP8k8/TWsLX42JDZScueUDcss88jvXjjJmVARXfkATU09DVLx0X1sjjN6Utw8gR0MbUojjHtE0QiOE9GIKbMk+aYryybAliHYYe03ogJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(9686003)(26005)(186003)(6506007)(83380400001)(66476007)(53546011)(66556008)(66446008)(5660300002)(52536014)(316002)(76116006)(4326008)(66946007)(64756008)(8936002)(8676002)(41300700001)(7696005)(71200400001)(54906003)(110136005)(15650500001)(2906002)(55016003)(86362001)(33656002)(478600001)(38070700005)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RNVwCnPtMBC4CoU7twEHdpuearL1k9/3G6wVUFCRBiuShaF1C6EaiWp13sh4?=
 =?us-ascii?Q?H9Oal6kgFXNxLV/Ka6IGD0Uu7amPrXoH666Zqh6uq9ElDYEHx07V1JCHzycl?=
 =?us-ascii?Q?aThIHjScgrE1DXJO61+NkYOkZuxlOSEBMPi5QFMCtBjk/wKjFH+WecfN7SBH?=
 =?us-ascii?Q?4AMX28tbeE3UotD1h+a9RPI1a3LKus5F8bH9qs/iaXzHYPvOQofnLWHXmINr?=
 =?us-ascii?Q?4WAltKKGeWr6PJg85tEhIQe2eZNjxiysEdEYBnC8sQ5Sz5z+pIOQj4cFbrfa?=
 =?us-ascii?Q?+hEldiF+Y+ueio0+hlrUJdbvqKqh59antx7nwEYiEEMW/QzJ2BtjWjRn1cs9?=
 =?us-ascii?Q?8FJRfrFXSU0vvmHYT/i758A+6LMsOdltN81kipVT61G+3QmXRb1ZA0AsqNpX?=
 =?us-ascii?Q?uzhKOuithXpSHpLCLuYKbObeG48BB5JWLyB+owjJOPNjlW6V+hFKKftWWfM6?=
 =?us-ascii?Q?SbpQqWiWV5KZM37VDMozzWe/Ylf2v6ydTW6Jsz61Dm5kN8Oihj4pCBCZIf6O?=
 =?us-ascii?Q?Rq4LVn+nbFspImRJUWqfuVaPw5sCjpHF2g6zYxgpxU/q0JjWzRxmkDtXbDQH?=
 =?us-ascii?Q?H/qdRjM28FaSw8c4l5gwzJXJDBM+TtIjXOBELuqEaZIys4na+o715+1sDna0?=
 =?us-ascii?Q?AWuHuZ3ylcoKQP/9GDyAUm8yPIvoeuZp8GE3r0k2K+k00gPGemJ20fAQk6eB?=
 =?us-ascii?Q?OF/8pxW//pofAjW5gst55pP9FmxE3WaiimrNBYufnPImTf8sZitno5TC6rOO?=
 =?us-ascii?Q?ueV7Brn49oIk4FSVjxyFJuJU2w9op2s5csqKRaW750y7T0ftWpab4Rlp0nUe?=
 =?us-ascii?Q?LqheQSN7fiurwUZVCbTDXA+QN6Lrk0PWslY+kzhIS/Eptjy2rHU9XmZWHXed?=
 =?us-ascii?Q?BualnuELDUtUHxRtY0Z78QfP9HAsSlWdD0pMzCJESl9YwlhJ4tXx5mxYrXFC?=
 =?us-ascii?Q?jcUrck/YpCwLI4LB/THglZiOiKwNLyrdo8YIDg5DUSGzePLmFrqWZQ1wkOmI?=
 =?us-ascii?Q?hwFrZHqPKgw8Hm84q3PquSwQmi8QOe3OEU4RzRjhuR1N/xQJX6DgKNDUSKc1?=
 =?us-ascii?Q?hG/DTeJw1bEfaBMewvJb5NhO/bSlS6+WH+P2z2QyXoYyeOOn/S9lfTZ99Y+c?=
 =?us-ascii?Q?62D95n+qLdJ0PiU/D9t6mFWIMT2zEtQljppFNYTQeFG4+0mEZ9M8yEUFFO5r?=
 =?us-ascii?Q?8u/QS9IKechjVGZmYr6S6OAv1xLZr+Idf4lo1cusIs4bZggymuxu4dbrrVT6?=
 =?us-ascii?Q?di7WuTg9Hm0BuZLcgZLJS33pEMdaxDApRLeLBAkyIGb9eEP26D2LCnPie3MV?=
 =?us-ascii?Q?xeP27rromGyJIrMeDZXmLeVEhXggLZ5K8fbJYZy5O2Nr58nOGxNaWiuxRTes?=
 =?us-ascii?Q?x0EJ4VW3WV7NZi3ry5/syMLjTSO8gEOMbCPwo5HTxl4IAD9wuMRq2stlgpK/?=
 =?us-ascii?Q?jHHMo4nuK19xOmfER4P/wZ04g/++HAQGIzYlb7irbQqtiXgUyOnW252xKPli?=
 =?us-ascii?Q?yWL58GgR7iaf6taPk/1P2ZcgC2mfhsYsNw1wTaUxSQBxQgWfEXMsVgDCVhSY?=
 =?us-ascii?Q?VWkZx5bLTIZuMT45xhQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6372ceaf-1bc7-4757-9ed3-08db58611b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 12:03:50.0922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNRBikiWVlA7MI6KHREq6Nkzu+b8madhEBz5hzfWv8eMLQuTOvCy3Bh+PK7yqW3Vow3ZytKqoMpqveuITk+a2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Looks it's better to add a Fixes tag like Fixes: 4dd9b5392c57 ("drm/amd/pm:=
 fix possible power mode mismatch between driver and PMFW"), if I understan=
d it correctly.

Regards,
Guchun

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan
> Quan
> Sent: Friday, May 19, 2023 3:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: add missing NotifyPowerSource message
> mapping for SMU13.0.7
>
> Otherwise, the power source switching will fail due to message unavailabl=
e.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 1b6116cf8b4c..cf6827179fd1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -125,6 +125,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =3D
>       MSG_MAP(ArmD3,                          PPSMC_MSG_ArmD3,
> 0),
>       MSG_MAP(AllowGpo,                       PPSMC_MSG_SetGpoAllow,
> 0),
>       MSG_MAP(GetPptLimit,
>       PPSMC_MSG_GetPptLimit,                 0),
> +     MSG_MAP(NotifyPowerSource,
>       PPSMC_MSG_NotifyPowerSource,           0),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] =3D
> {
> --
> 2.34.1

