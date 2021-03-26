Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B38C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 05:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A97961A38
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 05:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A97961A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0DD96E192;
	Fri, 26 Mar 2021 05:46:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5605E6E192
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 05:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyjXNB2FrQHhO0HSAYAxZJSmxBEgG21ZWzePtpXCmRFZxe98iKiErlgQVeqKHqXr9SWTNXDNtpALybPtMQ9i37hfiY6pBF76G5o7zmAPlnrMSjALcH8UZ1JHhCURZHGQ/OppVENNoBIF2o7xqXYlp4M/r5XZw9hNQB84mrBhEgjCjJMA4sEhaYGUBNvvxoFXiiFcLvAM9CIrRdO6QXtfWCyzaEfCC3x4TEE4lheejMdMnyqyM0wxEs808wCoOq1yzzQjetObYqRrWaNfKeb3qrZ/dfqurTGyEaFjWV6kES+N/D6V7OenSJrO61UMi7onsn6JrBSNcrlFBrnjMWpodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boTmp6BiPTZVGFLWxkWGj4uQT7rC1KAkKLB32xOSmzM=;
 b=bZIWX4q/StsYisM5t9OQQSjAdH28Qh66Ksz9RbSW9dSd6WyJJvgH4EZ7BmSIpndk9/phgIjSvntHkPHRcyRuh4CTkKjs9D3yMlXmuJpSFrXx11zv3qJ+YfM6M6E8IQLSaJxFptXXg1/Wh10zJhr8AVQEUeqZ3admZw2pTbcLrlRYMZ6huwh+vHdMcm+Wg2tpciXO7+BJmH82rmB2OQSZJ/jRnrBsDt35YtXIR84dRubPHFHV7+CO+swRDXqIx2gXqpIIDnc8TChY8sar4+5xc3wqkn1FR52ND7yMHBSNK4+dtMqBAQu9oMSA9wjUfk2OU+vOorN7DHRhL4kbp9Fj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boTmp6BiPTZVGFLWxkWGj4uQT7rC1KAkKLB32xOSmzM=;
 b=brupOAj8igAFHtQpk6NMWrdTomsrMNCzizb4ensIL3OIDp99Kw+fOB6e4m9QdAdruYPMbxrMdNg+tNt2+tBH6zrfQQ5TkE8PhpcuskuTQpyMQef6kPfRZTVwm59EIl9y9hz5vATIUw0wC7l8DLJgdiaOtWAMeEkKUljhbwTQR5A=
Received: from DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28)
 by DM5PR12MB1194.namprd12.prod.outlook.com (2603:10b6:3:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 05:46:45 +0000
Received: from DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::7d77:8839:4114:3bb1]) by DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::7d77:8839:4114:3bb1%5]) with mapi id 15.20.3977.026; Fri, 26 Mar 2021
 05:46:45 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
Thread-Topic: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
Thread-Index: AQHXIfnLvVMjV1VKNkW3sRwJp4caJKqVwpQw
Date: Fri, 26 Mar 2021 05:46:45 +0000
Message-ID: <DM6PR12MB2971DB53BDFD4B623C368A619E619@DM6PR12MB2971.namprd12.prod.outlook.com>
References: <20210326043731.779691-1-alexander.deucher@amd.com>
In-Reply-To: <20210326043731.779691-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e63748e0-0343-4e42-bafe-6663a36cad53;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-26T05:45:45Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 620a9a4f-4bdf-445e-050e-08d8f01a8ab3
x-ms-traffictypediagnostic: DM5PR12MB1194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1194242AFA344E9B6058CA449E619@DM5PR12MB1194.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4h7M/EN5KBGT7VSVG0Kjbqr3IJqva53/sGJpOAOq3jGUhvP+y2YQPnetixbQOgKb9X2cLZ/tIcVleNhKHx9PLBxlJ1UrJgz/+xUff8rH43hnr5nfuYulKFB8LWA2d3wiZRXH7yV3kUmZ3Sm6INFT6bIEnuODrSn/mTkSdyCiZgU3t59lKZMcYVkJQAej70rIInoP2AUlKmUw6eUaBeK4+aQgwHB3f5RfaLTkdEfx1NBdeB7Bs8/U2lYMeaH0hsnWW8Udb1mI/6j9LqP6Xx67+gbKvuN9DK9Uz5zQTARXI72hpv4wJbsaeLW4Udgs0UIvLaQ1LNqrAwOkgchEjFWmTtvcy1KQKPBmQ5q7SXjDo5tJ316ugAUGpObh83sfvLgyKyFGHYgPUHEdKBlWx+CK8+hvxickATYitxAx9k6IPXbkQubJjQEs/kUFORU9BsKJhQCZcDlsrVo6H+mQQMCgLE9h3Rrdn+fr38vi6NbTzNkTqpTBuy/CScl7VTICoT3dTl8FUW3LRqWPPOn+4BfnMnc7ev5ryBbGYsVUI4s0VSmYN+l88AbFOHZoG1K/63rnwVRomHzGZIXCVlbROF9MWbHASWl6T4F/giamyGoRe66UXzdhIavghMOAumT0uakeIYGfD4Q5fDQyFUdJuINA/i/nUFxNAa37FTdUZLc0BZiCQ+cNYHPmAb9537GhPS4yoR5+EtecddJjeVH/8vxvDht5pA8wkNax/PNjzkTVPgAFmuve7Hm8BD6Wehpq+vx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2971.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(9686003)(478600001)(64756008)(7696005)(66446008)(66556008)(66476007)(76116006)(4326008)(55016002)(83380400001)(71200400001)(966005)(66946007)(86362001)(316002)(110136005)(8936002)(8676002)(33656002)(6506007)(45080400002)(2906002)(186003)(38100700001)(52536014)(26005)(5660300002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aE/lOHd5VIquM01XWxcB1bKsm3wvaZUUmC30tSb3H3rBxqbckRw1XF9DobBw?=
 =?us-ascii?Q?QYuF0KjItc/oNfczyO8P5UHr+I90IPLSSRIcAWCVw6ixQ19gRo2j1HkWzfTZ?=
 =?us-ascii?Q?1umdLG+xxp+99Y/VtubyRe5aWSrByRUFpqRe0hHvxaN3LgHsL9g9SiA1rUwD?=
 =?us-ascii?Q?drYcyhyvxHT6D+JYXME9knfY9MK0c7IDEgj4W+wBWE7e2c7ksjC7NaEtLWaM?=
 =?us-ascii?Q?m2gkAjAberBEbzffOuUmtlaRV/QsY8DuO5tpRAAPBvg9ku3wNiMyF43TAom3?=
 =?us-ascii?Q?jXjAMv3Lu2NCJfsxgbtpa2nWf9SsIPOwHpzV0zYt7prbFRerFCX8c/0tE3N5?=
 =?us-ascii?Q?BGz8occiYkQslQKxUhEUzoniA7PKZ17HNBceYNE3FwIPiOJUx2yXog3rPnxh?=
 =?us-ascii?Q?D1nWRIqwfpJktAnENdll6vxQ9bnxrgLHuZvrQ8DJubHo0/oSpmoQ0IB6u4pE?=
 =?us-ascii?Q?1w9L/bHU3nyMYOnZUTNvlzS/OZWozEvr1dTEm3NO1zTkdH+DsJiN/7nF8doX?=
 =?us-ascii?Q?BIkIDlhR9pxNe4vSz8bhBdcsyBORvBLFmde+X5XjBb14E7LuV0kI/4h/1qkk?=
 =?us-ascii?Q?z+OyS7dlUhiGI/bXEw2SoA7ABLNNrvXc9KFqKJH1vk4PHV2y6JXR8rU+bZE4?=
 =?us-ascii?Q?hvNIAfxHg76D8Tli+tftBfhfwoErGVImcBCuK4MpGojL7Py7E5EUkUp8qwcn?=
 =?us-ascii?Q?VCC8Q0TvcmVqXlYURAvvV/gW5w9QCIdFKKQ7BTntkvEIlOWIQX5hoN3PevT6?=
 =?us-ascii?Q?2Jh2AhvVoPHiQMeEeLguL5ZIAdgHmWNwzTS43wtsBsMMHD7eSXUzf/wtST8C?=
 =?us-ascii?Q?G6LifRJQuFiBLERyJ6LWIlKFOOwoJ+0p8fgf5Uc5963Fe+01cwac+b7FwDqr?=
 =?us-ascii?Q?Q4nR4UG33v678Pb2N+z6Hut+FULwyms/YqCfchvDs+H/bEP+zo6qcwwE6ujV?=
 =?us-ascii?Q?AVGDMfJL0dxXqC9gtzloR+AwgIb0QybNz6q4l7SgteAhjHFW8gKUuuqrQoax?=
 =?us-ascii?Q?gF/wxB3CTwoco20HkzpsPSZpiI2Lc8bB7XA+CjkeBPkEiIEM0l5XSdI1bDo3?=
 =?us-ascii?Q?5pypZVsij5IC7NsWw3T/c1K1dmHPCfG9G6DV/2nu12MsH4Ly6sFVLB8gILkj?=
 =?us-ascii?Q?mhnv+/CzHk0r0T/VbuNFXumP5fvi1iJojfP37tpRbzndXc1ZiYEvSsd9zl1L?=
 =?us-ascii?Q?KKLpGD2UotO4jCv6g2sFRGujoMVVUdx/MZoXFLR+yvWJYzXOEX1ZPBPUFsSb?=
 =?us-ascii?Q?JccnN13/BRrzkQ36UCJwNjUIslVkeOnmJe8iEXD+dpFmsXuMBmVFRVZ24Tzx?=
 =?us-ascii?Q?CuUxzmkoZXXEGKKQCYVillrY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2971.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620a9a4f-4bdf-445e-050e-08d8f01a8ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 05:46:45.8909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ze+Y9/XMh14wsolfOUeirzBagCJ360osbZ/yXh2fpD7ngAmH4njdm/3hSiKgN2tm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1194
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: 2021/March/26, Friday 12:38 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on
> resume
>
> The SMU comes back up with DPM enabled by the sbios, but the driver still
> has to set up the SMU/driver mailbox, etc.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Zhan Liu <zhan.liu@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index d4b804c7b986..462917d4d5e2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1102,7 +1102,7 @@ static int smu_smc_hw_setup(struct smu_context
> *smu)
>  uint32_t pcie_gen = 0, pcie_width = 0;
>  int ret = 0;
>
> -if (adev->in_suspend && smu_is_dpm_running(smu)) {
> +if (!smu->is_apu && adev->in_suspend &&
> smu_is_dpm_running(smu)) {
>  dev_info(adev->dev, "dpm has been enabled\n");
>  /* this is needed specifically */
>  if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Czhan.liu%40amd.com%7C500744d08f7946b2c5d
> e08d8f010ec49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375
> 23302768646367%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vN
> JawxwfojJrxNOG5L8Y2BAWpGRRN6valpk6y00XIQw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
