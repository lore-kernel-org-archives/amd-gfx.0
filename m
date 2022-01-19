Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77218C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 06:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0821C10F0B8;
	Wed, 19 Jan 2022 06:26:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476C310F0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 06:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3t7NObyfA5PXcHzK+J7WWLdAyO6dDNmbzBur346XU8OFhUqeCkf63JLfiuukO0BDkNqMSDClXYBNO9OsMXFX+RQYjQuQDm/taaNKud3cKh5r47/a1JqboVPXTshiOcCjWjzjF9WDwzD0gkU/M6zdozycmzLW1KiU4RXG0dfL0Rhwvulolcnn1R6VOLdVETlYc8s3vA4E5c/h6cfnKPQTt4guHgX74Xn5i93ues6l1PScodIzZ4QIWQtjhqg5gdISaVWwkg/lcGqyhlQFaBh8yjZcXZ0TPGf4ie1TgkFxAzMNJ4eNYPV9eqBr5oLeSMky1yoJxMAQSLplUJbWr2TUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbmKJQJZpjmNMs8PdRyEZdnkVO7lF+QzVTPM3yF+nW8=;
 b=a39GICP7Kbcp9ffV9W5hrAgrrJXQFppVw3CtpiIota2ahrRiR2WJewRdldGZJGFq7tHtReLKQ1LLakVZvFy6WJqhu5LPAkFsegwDXVA5l8HnYjqEReV7OCHGmz5uKbDLJ/KMV7rkbf9FBJYI5YYUTW8lTmOT7nDPb+EgP0+MW+XCjaLq0Wfh2530RE76nID1SmsmTlbdrZ6xh6ZFdxTXUbYoBSfUCbmeNHiUTXcVc8XYd8o/BzXCYAgPbtoYclA9lmSmfcpL0+cRHCJcSPaTJ3BWkdvBg4a+j+YkNMOvQ2L5VQr4R2Zs0iJskIa+AeTKPfLOHKKSwte9NoE5wiyMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbmKJQJZpjmNMs8PdRyEZdnkVO7lF+QzVTPM3yF+nW8=;
 b=IETdJEvA+d3ohVIPjA0dP5b8QhjRYkJsA6d8baN2xfZdtKOF3M0CTTNbdIi91sKktZ07T6H6USqEAGtHqnTsLkYsmoOQ3aiIwLcJ2YTjxqYi3C7vWpUqyNSCSjvM1kEPzROzxUiMx4F9MrE1lUUtIHCp7w5bJmS2mmGsN6J6P/o=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 06:26:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 06:26:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove unused variable
Thread-Topic: [PATCH] drm/amdgpu: remove unused variable
Thread-Index: AQHYDP0IfYRu2VIWAUO2mCcPQo8ZfKxp4PVQ
Date: Wed, 19 Jan 2022 06:26:37 +0000
Message-ID: <BN9PR12MB5257ECEA4F6561EC10E105A5FC599@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220119062251.2788108-1-Mohammadzafar.ziya@amd.com>
In-Reply-To: <20220119062251.2788108-1-Mohammadzafar.ziya@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T06:26:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1d8a5c5b-85aa-4477-a921-1e82bfcc63a6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b80621d3-e28f-48d7-d0d5-08d9db14a591
x-ms-traffictypediagnostic: MN2PR12MB3053:EE_
x-microsoft-antispam-prvs: <MN2PR12MB30539477AFB8B00632BCBD24FC599@MN2PR12MB3053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owERt77+i+mNUWWiDuE/3s3UtyuqxL5hd9y24SAzOqbCjCZFwRGKOFitKmkx6pE4K6fisEnC924u8cZnNv6mXC5YWd00Q4jkkwqGgPVqyi7DC+JM+uvTFPqn76duP8fk/3qJZUd51lwxY76/UEZm+f3VAVuwygvYquCPGqt+hHOaJ4V1Y05YwCYZlHhT335ANdJ7TQSQQyosBdQSo1zADvAnc6zUGD+3CJxCNZwh/Zv4nL7ryyXY5QohoJdaHYztP/D9Z4GApivz0/9Fu35yTnyR2d/eYN/7yq99r0LIYnnbMrTEFYu/NMGhPQSls+UYkc3n25jqstOyP4lOviV6rVazDwnfFt3ZOY1LCB06Oku6NFwy1rydHvgoW1o7gUHeb2ALbLf3r9t/78WW9+HLbHmxhafM9zVx6AeNrdxERPXSHDazjrGw+hcYnOBOqmwmOxayNiqnZVVPupNpqBhBywErC33XHckNpFBnucsncWvMuq/gIWb3mopQtrZKak0Q9ky1DfgXuF0lIDxT6cVHHYy/wjNnnE7dddIIZuaBk7zi1aw1KZu4TuAZ9TSbO8EpS0MuOHWJ9fpxuXWp46ZyQrXKwbA6I0g82XPHvt3laIvb+fcNn6ziwUzEqZU9lhTwvCZVyur5oujud2Er9/tjbHNA1KoTn4CTyQ7yjoilEJyqC8b194MtRqYJAjSQRVDY8R3oBMhvfddC46zNP3HsfvNwidUXR+8cDBsViquf52d3AMyjSqoZEGdQDy1mt4Bb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(122000001)(5660300002)(33656002)(316002)(7696005)(6636002)(8676002)(8936002)(53546011)(6506007)(4326008)(66446008)(66476007)(38070700005)(2906002)(76116006)(71200400001)(26005)(64756008)(9686003)(66946007)(83380400001)(508600001)(186003)(110136005)(52536014)(54906003)(66556008)(55016003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fvvolwVXI/a5tcu6mITQQkm1R7fYsuckxxhY/iDdxbndiwgp8DIjlA7SQgrF?=
 =?us-ascii?Q?7qzKePIhzS32WWhTqmcwHuoOtUQXdO856y2DwO7zM1WXuivudLPQX8lohUQM?=
 =?us-ascii?Q?Y3yakNOKLc1Nwtgf9fwltg3mkKs/bXyJsA9nREzfwvlgam716fFEAVCQwRqM?=
 =?us-ascii?Q?pzLZVSCFbSysJ2o0WiJNRTXtTN6F6S174SpWQI8nxKvebb2VM7zjqOucMj5u?=
 =?us-ascii?Q?gtcFr8gtogNVOp/X9//Zj2QHtDHc4iRGUonc27HEkD7yP+pmHpEH93Qnvnid?=
 =?us-ascii?Q?Vt+ze06dyYIX+rg8IXl6mu4p58VqWSpevSe6Vk7EJ/vLLvQznXsCX0f7bMWQ?=
 =?us-ascii?Q?WsKIoMNICoa8hISVtvvCmRCIWsPTbTM9zs8eel+0z3x04A7aIdzd9W0WFLDW?=
 =?us-ascii?Q?IWWknklPTAFzQ/ipxxHxde7PuNHL+qPy/+rgNa1VKIdmLtv44/4mcKCGJyMC?=
 =?us-ascii?Q?G67m0GfnNVdg06lOAjb02RPNex7YYxSU8jc7vNFwCurSN+8DmICHqI1eglNu?=
 =?us-ascii?Q?bnlpCQf0qBVbtwu50aKaogywDkx91OkUZ7GjUd36WOIWp3OYtzbKSwtDSId7?=
 =?us-ascii?Q?rhYS8OPKQW32jdFidQIlJgL5JQqpU9NYjL5hI8+Lrzk/J4+V/RWI0DRcaGZq?=
 =?us-ascii?Q?kvuir8UcfwS3jBZAklcOFD9DWQSPIBRbbmSnS+mrcjrZBKSZp3M54n7F1sVh?=
 =?us-ascii?Q?2K9Cep4ZCPVKSohN7B+M0z/wTH6JZTIMWyvbPLcAsSb34kdwGZ5SPaJ+a0t3?=
 =?us-ascii?Q?nSxWuEKd7IJDUI4q437vIfkDMCnZriO8bg2Ly4mbGwEKByXBIM1rFuvPJH+T?=
 =?us-ascii?Q?j/5y2URruiGOVWmUWuzAu8SKfX9PmhtdB1zLEA5GjT4nbFLKwWWqnYOUavAa?=
 =?us-ascii?Q?Hfe+E/t9XAbCJHo4lpPfAoz1v6UNi9ZHL5ZwehwZxOHsk8QyAHhrG/XPI8/u?=
 =?us-ascii?Q?471vw0KyokT+NPQKmYtY5Ol6TXyioY/nDmnebDK4irhBhZYlRViRU/v8sFoh?=
 =?us-ascii?Q?4HhPwjRz8m5kbmBi6PeEsF5qGYGDMP3pe5/VwegtYZq3OxRppi9w2TezV3Rw?=
 =?us-ascii?Q?g4qTb8cztHHOmDk1rMUnbrbNyElYtZkV9+XJiXkehj3YkVROrKfflf0eLoXF?=
 =?us-ascii?Q?z/EW/NGA0rsXiVf0w/PEzem5Nb4FWiJK7xKFQpR89ikeMDaO2elG94QAMZpz?=
 =?us-ascii?Q?t0xMlRO3KaKpMiOXTeVU962oCfqYZk5GSaxF+yWOOSJYbJEIe774ovHB5M/h?=
 =?us-ascii?Q?+e8147cWL/965ZiIzy+le7tLR/KTUpNTwoc1z1NxUvnriSSzndgN8vmZ58+o?=
 =?us-ascii?Q?4QzyOU7tXFav7B2xS1QLGmwsaXsbzjT7HtVSB+GPf4Fluk4StODuPqPlnfCI?=
 =?us-ascii?Q?srn4GKoebL1+CMGf4IhK2jUztEDQPlgmJv7M+XWr42a1xOswa+x0EcGxbuXA?=
 =?us-ascii?Q?r0ewdm5L5TNODJURiNAHLYq792WCIS0M7/epDNbKvntd6lLfJ1L5cAImkpPk?=
 =?us-ascii?Q?fKAkyZyHgoEHGk9+HF4fVxvN6MWOohFm5sarRFIXqGk/c+UnPzpQCWJDCP91?=
 =?us-ascii?Q?gG7SZ93ylCjw1z575nFawhMN+NSyl8jjrwzobS1x/SdlmJLiMrbxGzMOet/y?=
 =?us-ascii?Q?6HE5NYJgsOdgGvNphqXBoD4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80621d3-e28f-48d7-d0d5-08d9db14a591
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 06:26:37.2168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOZ5QkCmLUXGx/au8ZUNcvHFVlFkjpcCWXnSrNvhiOB/M+jWZTR/nmh4iYCxYTRuz47TajLveukzQ8SuglufqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3053
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
Cc: kernel test robot <lkp@intel.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>=20
Sent: Wednesday, January 19, 2022 14:23
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>; Clements, John <John.Clements@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Ziya, Mohammad zafar <Mohammadzafar.Ziya=
@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: remove unused variable

Remove set but unused variable.
warning: variable 'umc_reg_offset' set but not used

Signed-off-by: mziya <Mohammadzafar.ziya@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v8_7.c
index 291b37f6db4e..05f79eea307c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -94,16 +94,12 @@ static void umc_v8_7_ecc_info_query_ras_error_count(str=
uct amdgpu_device *adev,
=20
 	uint32_t umc_inst        =3D 0;
 	uint32_t ch_inst         =3D 0;
-	uint32_t umc_reg_offset  =3D 0;
 	uint32_t channel_index   =3D 0;
=20
 	/* TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC registers. Will add the protection
 	 */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset =3D get_umc_v8_7_reg_offset(adev,
-							umc_inst,
-							ch_inst);
 		channel_index =3D get_umc_v8_7_channel_index(adev,
 							umc_inst,
 							ch_inst);
--=20
2.25.1
