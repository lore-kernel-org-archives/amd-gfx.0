Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39B6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 10:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4327D10F07A;
	Thu,  6 Jan 2022 10:05:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DED910F079
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 10:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdNsvXqx20X+D4zNqsh+QROf21IKXBbHxKds9elQoQ0XQ3o9XMDORF6QBb5fTlvjUINOhmY2/W9hKrKV/YyevPV1ea1Jnr33qcB+QnIYfssXlBeWSzIuXNDqH4pYcZeuqoDJyzbTagzQvhxo8yHWLTvrVRUxndD6Ii3fGYn2ctrnqEy5BMhMaFqdfkHekmblYDUb2T0ZvEQWeUNVrtmFAipTjY+if4o/tGL1jg5B4NMBxQwKsrBybxyH4aSogceBxU9wln3K+WcYOly0eNV/jS9rzea5+VwIZ++qu3/5ZogWCOEpLznrOkmwZtwirIbfWsM2sTKNiC8gEuIDAPorfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIYcpCeCF9tX+00xsUXp07UNPCe8tkVNds5fvNhdyRE=;
 b=hKSWRvYx7BAeAyKCJuEEmMJS6ey1x9tGMu3xLVM7XNbsriffF8JlXc7tig22CrX8xjYfsGPGAHjCEy2fkYwHsmN/H9IzkOO4QZJ/3mPijJCQqy+T/uZQfnqxg9g7tyPG19Jta7sTkE5Iv8tdetIQbZywPNwy/FlKieads86McEsMt8S7w/zIXFeaZyNLmwteWN8JNdTh/3fNC63+tzc8MFUot/K+sgTWgCBrQeG2HE+jyb843C6WR0LzZ1mEEDhCZ+EcZqxAe8hIlY/G0xFS19ZcVxCny2I51bmDZxFeY4T7T8f4k+aDrYu0AC+S/UMxCi5oCV2UdxmxRfbYe/xr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIYcpCeCF9tX+00xsUXp07UNPCe8tkVNds5fvNhdyRE=;
 b=YYQL/i/3bcbcXKSkqfTbvipgg1c8WcBQ/f11V7YNh9tElw7Zcoelka0aJ2u2KSrJbWUaEZiLjlhQPaztBaNHLCRQ0t99c/1+XsIUStyseBQsQIK3XBcmBMPH0PSx2DmpmKGacSki3V5hcD6TG9F7DpijbTuojlu8Kxbqr9KqJ2k=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 10:05:18 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819%7]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 10:05:18 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Clear garbage data in err_data before usage
Thread-Topic: [PATCH] drm/amdgpu: Clear garbage data in err_data before usage
Thread-Index: AQHYAt4xy4ZcallTZU+ix5UiBq2AQKxVwtfQ
Date: Thu, 6 Jan 2022 10:05:18 +0000
Message-ID: <DM6PR12MB4650ED32BC92BA7B1B2E468DB04C9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20220106091640.18705-1-Jiawei.Gu@amd.com>
In-Reply-To: <20220106091640.18705-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-06T10:05:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=055bee7f-cd50-4ce8-a257-f0f5deaf2179;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-06T10:05:15Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7295037d-6c4f-437d-9548-6d0333ee6fc7
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5478338b-7540-421a-47dc-08d9d0fc0ae9
x-ms-traffictypediagnostic: DM6PR12MB4650:EE_
x-microsoft-antispam-prvs: <DM6PR12MB465016B8865E8FC8B7FA38E5B04C9@DM6PR12MB4650.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AONWXa5g7PAX4hPymoOTpCE1PjTLMZZ3yDtyj/s872NfK1myI+EggIgUnNYHW6piDge7zE90KVtkc+O/+2Opj8u2HUL+wDHCuqwj7CtnsGFZPUEtis2Gie4QAdAgWl0nJvvSM32huhKROHNAEr6/HP7gPZ/02kPeaHCAApQR5mhsV6Uk8Mp0hQyBnCNHI7zZD0iJHWczisdljKckOVDEhKmxyfSs5Z9VoiJRJVgxjdG+TkF6f94rgwW1IpmvimUJm4uRhplRee3419Y6TK5NJ5xLnA4nkS7KLG4XlgoJy5dBnZBVQBxqGodCmisLsH35l41k9EflHRc2/+Hq7fYCp4bsc0fR0FQUVXtPFGwLpxBWDUkhUDMqVrm9EKduS47adOaI+QXH/Vfz0Y3Hc1YNedYVsLYGGGbWDK7RarTbje/ufsyOIEuQwqYMXEibPvVZWlMQIqaMwtHpnKk+pFJxi/Oy3siUbQ31U/tyfJj/JsWL2csQGGelvjhoKnwK8bO5WdazDjCGtpaPx7iXQBz2US6IQtYFp3//Pj4eAtLKq+hvQhRvgXGjorq6nahKlAeELTjTzfhOMRoStR6Ku4BV0vQzxttdFYfQ/pckGypLqItQFCAV9+MKrjM+PBBXtCIY2jov0pjRK0lCduQDZ3SnwpjcGjPFhH3ulQZhPBIuzGcmMAQuBZ8LxDR8EPER6IKyVatRdBBW9AgqSheSc1EG4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(66476007)(76116006)(508600001)(2906002)(66946007)(66556008)(83380400001)(66446008)(64756008)(6636002)(316002)(86362001)(33656002)(8676002)(4326008)(38100700002)(7696005)(110136005)(52536014)(5660300002)(9686003)(8936002)(26005)(186003)(71200400001)(6506007)(55016003)(53546011)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QfKsYi6Cvg7EME49/oEmnDlogyluDBmF2mEOWSY5ok6y+CQyxSzRuEkxRP51?=
 =?us-ascii?Q?OvimDMbtP8JwNFDaHCtaE39PXOZDTNYxqZejnsL40wLatWLf9eduJO21ygE2?=
 =?us-ascii?Q?nqS6qyUaUyktovfLUx05oon2pMZk2vXyW0pX5Tu6XkcGglWZMeq0Jr1uuShk?=
 =?us-ascii?Q?34c+bIbHGfFCl6mmKNSXHxLapJ+EEtlp8eAPsduDltmTt/+2wXysnc2sc4Ja?=
 =?us-ascii?Q?DSjfJI3/3PozSjT+xlgMdsGsDhVe2Sblf5LmwnVzOS2Q+glsFzKma3BoEtOq?=
 =?us-ascii?Q?gmkhTJZ1ojoTB8/kRe6uB7nZeGjatyNB8aeQnOQuoRIGSlkVfKqIxhHWGoSt?=
 =?us-ascii?Q?2zcdrLuAQYXYP6NP+nBIg1DmP/yCEMbwrXrIQ04eDcZyvvP1LYbkSjC0wWxH?=
 =?us-ascii?Q?z8ElSK+VVzsEJx8z68Lx4o2QwG+c0ZFu7TDRRpo9TnNe9BmoS5L2Etn072Er?=
 =?us-ascii?Q?RG6Y0MngUeGQxgkiTFbu01OONcUkevRrPTd8sBKciY8IBqoTuzVhODzWncGH?=
 =?us-ascii?Q?tN9npvC+l+EpjNuB5QjdNja/KE4blx0n1u4H3L33Cu0FvUQtxgiqha5C9Qvk?=
 =?us-ascii?Q?TG5qeiPIfU/cD0u5iAW0KC/rbGD190NvUtrOsaNtHwuTSxsS1OnsDoL22v78?=
 =?us-ascii?Q?4nLe6PYfuUJAzJc1839CuWquPm8Dy5CUr7RuV8j1yqW1g0Cc4e0Hyi5ZUsPZ?=
 =?us-ascii?Q?kglZnULc+Xpz3q3yxFeB1DZaHF2hSpb2g+SVmq9zvuHTjLzuNm/G7UOGkX8O?=
 =?us-ascii?Q?1FP2xVTK3eyG9srC5jQ7hjW4KIK/e66F3IcHYcuhycYfsargP+uj2USGudy/?=
 =?us-ascii?Q?w6g7wgWTQwMv32iLSXAHpy1zhnriupT3UL80i6iYmkGLRhDgEc56Ks05J8b9?=
 =?us-ascii?Q?NIXw5v2faIcGVnFIhqlNGHdkdkUufxGsMJZYiFChowIZbsJFX2LZyBZieiti?=
 =?us-ascii?Q?SYENzvn2F+3SnIKehU/MCXC3pvYRpXTnvNA1/5jQ3ml1NwaxHywO5avX8XSq?=
 =?us-ascii?Q?+5brJB1fvwhPY9lkE64eQuon2dvN7A4dbOFo3+K5pVm2PxUkmsHYcQ1aX0ek?=
 =?us-ascii?Q?sJ1AEuvX1Qn6hDzsyt+hFwQeWKVGbY5P5Na/U1oNMGRMvqsAe6YyVHRA1tV+?=
 =?us-ascii?Q?zWvAi1klb7fAS3S+QEs12a/6d/PvE0xYF9ShiXbcX07sOgPf6MBlPYcSM+Wi?=
 =?us-ascii?Q?Kd+3wOczsvdfZUynHhVcIKuQCImdBfHzrbxSoEojnvneiIfrz6SHrCShz49V?=
 =?us-ascii?Q?GROoXdgk3bmRGiQ45fewwWMPfj6FIOq1ze30RzOoh+Whs0m53EdSiTBEoo4E?=
 =?us-ascii?Q?PiOeOqdWw9X6bAfY4VUWDo+L8I/z9Xn0QOB6DhTbaA4V5/dscfx+4hzlbgep?=
 =?us-ascii?Q?i2oDf0L0ITk2ikxgawF7cs6P4DygQWws9ZxW6hHz+AiOzSoxlhSJujgK6PWs?=
 =?us-ascii?Q?V2wJDSeVDkfY6jVQB+ylQUa7Dv8GVqEUTf5wd6GDCy3mDpHZF6jgad2xmGZG?=
 =?us-ascii?Q?ogYDvBY44aAl1RAMfuCSfwglE6z2Ny0JG5VKq9dOTNFeOoHqXHh/K7L2L6DY?=
 =?us-ascii?Q?9A/f/E++NFIsfX4kul8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5478338b-7540-421a-47dc-08d9d0fc0ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 10:05:18.1792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lq1zYlNbWOPnjQPvLdkz63uWr74aNv6+w40O6w5R326WWYumt3y1P1bJMLDYesSs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4650
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
Cc: "Gu, JiaWei \(Will\)" <JiaWei.Gu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

May I know how do you reproduce the issue?

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiawei
> Gu
> Sent: Thursday, January 6, 2022 5:17 PM
> To: amd-gfx@lists.freedesktop.org; Clements, John
> <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Deng,
> Emily <Emily.Deng@amd.com>
> Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Subject: [PATCH] drm/amdgpu: Clear garbage data in err_data before usage
>=20
> Memory of err_data should be cleaned before usage when there're multiple
> entry in ras ih.
> Otherwise garbage data from last loop will be used.
>=20
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 31bad1a20ed0..3f5bf5780ebf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1592,6 +1592,7 @@ static void amdgpu_ras_interrupt_handler(struct
> ras_manager *obj)
>  				/* Let IP handle its data, maybe we need get
> the output
>  				 * from the callback to udpate the error
> type/count, etc
>  				 */
> +				memset(&err_data, 0, sizeof(err_data));
>  				ret =3D data->cb(obj->adev, &err_data, &entry);
>  				/* ue will trigger an interrupt, and in that case
>  				 * we need do a reset to recovery the whole
> system.
> --
> 2.17.1
