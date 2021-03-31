Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D34CC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 02:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB016619C5
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 02:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB016619C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8931B6E9B6;
	Wed, 31 Mar 2021 02:21:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6706E9B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 02:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ2nWsZaSoc86qrzPoK+XhOW92x5Phwt7B/BfxV4TlNghyPPoCmPsGFankY+nYREJ+UfJtIkkz1dalKjhtnZYSPHaIBgZRaQniIiab0MFj/rqZo8H/8Nu8ZFtM4Q9X2umm40XAHU3t+XCFs3/nJbmetZxE8K/t7dkNg6tL8ATC6YDIGCDyVN1lilV+qBkoJKxOHfCjFH9OmnZ4uqukYnbtUC2+KuaKlwAi88dtviLm6dsR4UQEU5WirVd5zzCswc1E1SSERdIovJzii+6bkY+yL4wrdHN0BwIOjr66GjEmR1hAl2sbo/cADMziEL8u0His9hBJ/k8DLrnq3OihOZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK4ZTQvBpL0qPnml54ZA7TgJA2BX4ZJ/tpHLrc4H7sM=;
 b=KNwgYTb4qz7syKA7gt5e5Pox1f/dnzHFUZYWCUesSDBY6b25HIOKCpyNZfM7rNPDAzqggMmp8I840aPevfynW1OmGxx2R3q0Zb1Q9Jki5D/FKagtouK+RCknnWKEvE/G+KbbhpJlMww2oY/eSVLdwgpIxeY/95pf9v0i1E1sbC3LFZcUSBzF2ngq0/PzGZXpSjNe+MBLhmxVHdLVHgiYmAV23UmY05evq0yJy2nuzAiwGmjoux+RDSfF4CeNYAFLn3+AST2lo//n6ojwkjiKrK7tiqzzRkAvqrmm5xElmSKUo8cvpjZK27p6JX3hy+B39Pps6seg22pXnewMArHIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK4ZTQvBpL0qPnml54ZA7TgJA2BX4ZJ/tpHLrc4H7sM=;
 b=2Gk3tLb8O02OW1mRwSwuhzFNKHlFJVcQxxFIvseLQ2sQx1UUINtPNieFM9mZLDCQaPvYmhwAQpsJStVtjcUAsU7H9cSbpWnIckDE7rvKyPLkHAeRBgT7dYsrc5kmFRklE1FrQbYikXGQO2BRe1jA8VDvO9eoeCx6ok5JPD6yqQs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Wed, 31 Mar 2021 02:20:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 02:20:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "amd/amdgpu: Disable VCN DPG mode for Picasso"
Thread-Topic: [PATCH] Revert "amd/amdgpu: Disable VCN DPG mode for Picasso"
Thread-Index: AQHXFoGjgC5rsJteRkOljA1F1IvU6qqde6rQ
Date: Wed, 31 Mar 2021 02:20:24 +0000
Message-ID: <DM6PR12MB2619A8FEA32B308AC6C9380FE47C9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210311141942.44342-1-alexander.deucher@amd.com>
In-Reply-To: <20210311141942.44342-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-31T02:20:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9bc64b31-763f-4703-9fbd-4754730ac2b1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b690c89-8978-4378-58e6-08d8f3eb8b00
x-ms-traffictypediagnostic: DM5PR1201MB0123:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0123E049E3DEF000C708E0A9E47C9@DM5PR1201MB0123.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EY4TsfBh2caTUdO9tQ3ghbIOoYuypu6n/zl6lQj9dvIRAxBdtjztFCrIpJOgzy/DkLWa4cRnLlK7RONQNnr6d6XvPnxHSJ33P2uvx44E2/qXGmRa5GGft9fxvCY+xM37z5Ccm51d7mptQjO3zY2uF8WALwpLah/ThVbxCoCyyvoDxIn13/y19f2Iuq3tXpBieKxEPW2FOPK0jTPAMZaEQiSvhTTeIHYif1ScIidsfiQrvmVcHAkGqDO8JvUh73IdWSyk3om0ijMzCimQxIc7K3cAS+gYj928ZiOh0grZXIcmD4HZ3XDn/FQW5M7ndBg/51fjMc89lO8U0w3yoal3+S/JatIWFMsvvsEqmD0eNVrwyABOeIC6x6o5TH5BjlgQWoBFxnaTe6x+pegkYpT6TM2TkC9PZDOoS93HLHRcjB7X2DqY4pxqRb7tt3RXGyBIUxQH/XkRGFuTHvE5caFL2dTEXSx3nl4HGqucSOGuYUbwMrRlWiETDYaMNBaSIk+gcqFYxIt3vG/EgNiWMPX88cKB1+LU8pFOEtdgVKsJHTnLYv+E4r8sdP56yz7GI4r5yAe2zMsgbB4EkW8vUh+j04+/N9Jv+g4Xz/Ylx1SIhKjxxQzDiWKavHjEyuoWtPxbPIPZ1M5gg5eslcLOYSRkTgroCDxoXzlcq5s0/PqnL3JYM8Gdg5E2Bg+2zrFQ97UNSG8jWceWUDvCPYgC0NRhZxj3W5tQxeEohGnf7cDUr7Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(110136005)(54906003)(316002)(33656002)(86362001)(53546011)(7696005)(52536014)(2906002)(83380400001)(6506007)(5660300002)(26005)(8936002)(38100700001)(66556008)(64756008)(66476007)(66446008)(8676002)(66946007)(9686003)(71200400001)(55016002)(45080400002)(966005)(478600001)(186003)(76116006)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3ObPyYQdyoRjKj8c3GQl/0tcWyRr9yxQ8F8KYqTh635jWih1n+iSgflIlQrR?=
 =?us-ascii?Q?2t48eLDhsfvol4MzLbkWJZtYWFzc2Pk8BAJQReJ31AIcaad3JZbC9K7MzaOb?=
 =?us-ascii?Q?LBHmTzRxY6AOGsV5FnPMFv/pXFns54Vw56QHKtr5qSA8o1CUE8izXf4FHR03?=
 =?us-ascii?Q?mMqcpL2AQ9ees/cTtaRYT2PR6K7l17/0hk5cJw3iKGGyiKcEaNNmmDcAk0Fe?=
 =?us-ascii?Q?d3nLkU3ROh30/2+uMwfYUZ6a7s+sURl9ipZgw+72pqyUkcBq2yqbYe/flt5i?=
 =?us-ascii?Q?t5YziBZYMAuCNciA+QxRRpOgHFppRzrOencajF6N7mTfu0aP1nRfkNtBje5b?=
 =?us-ascii?Q?8tPJPk7QhYd9hDI4w+KJzDFL7whTXFZWHBLa0wssm23bjWGM5++b7QUbilzs?=
 =?us-ascii?Q?BsBY9OBjhWCkBLxgQTYwDx/Nxf0WRJT7azGHHJlr6MLcukVdUHPagvjlvEPr?=
 =?us-ascii?Q?Jn31nrIdVspWG7F2BtPxGvkQmzFZYuveW5VfROMLYirx7EG87JkvN3//zktS?=
 =?us-ascii?Q?JTlsECWq7pjjbbxWyWPcnMAOXNLBT921s4O9R9P6LcXZVpHansOETc67Xl02?=
 =?us-ascii?Q?DctipK0h+SCSkuP98C7YdaGRWBQ9bUa20y5X9tH+iJ6epo7oE4XiYvEI3/rP?=
 =?us-ascii?Q?YuRQAZdk5VIKkmXsQ5pFRT1n2fqf1HHrU044hbZFXMhvzaapVvOUOJNeyLsj?=
 =?us-ascii?Q?Jpughn+7dG9sBIyzihQrfobIGz0qPu5WHPEzSxToxC3UMvqP8Bs6F2dmQn7Q?=
 =?us-ascii?Q?/ySMj1Wn1gn7bdR5Ru36TKZ+aA4Gb5F8odGYIz1l3btnPXQQmnl3wgCpeJ5b?=
 =?us-ascii?Q?yunNb6gImv9edESQs46yPPaLUg5CGuKt0VkVCRRc2nZgRMn4IdDXfKPNUgyy?=
 =?us-ascii?Q?hP2+ujwSHa2yfd/Bsag5ccW2wg+UMA6GpxfpDZ2C3gYUpMq4H00JO6Co0fV0?=
 =?us-ascii?Q?7gpbQxttqHaF0f+A1Ig4rpmunnQqjstzM8KyMolLBuqqlLNbIfeZaNh7f7+t?=
 =?us-ascii?Q?XZ2VQ2sS5soUX/PiSNJSA4m8po1Zp1WhSAQJvKCjTZv2TCdDsn5JSATXwqo2?=
 =?us-ascii?Q?1cII1vPSMWeWIV8qqJ/A6fafsMpYB1TZEvLhTUP+JiAPOEC3i4zhKq9g+msa?=
 =?us-ascii?Q?WXakJCrMk76BNKxStU5WBbXq4tkk+t0Re/3YG7W8LmMf1m/F2wVcE7bZC4fR?=
 =?us-ascii?Q?esZfobXNtInMwkpujiltdjyBgtg2/pulzq0SJU6eEEKsKOULJVKbuDlVLtsP?=
 =?us-ascii?Q?RdsfNRUvR4ESLPVXIeruY2BNaNAnnc0fpx8HQL+IS/LidssNM0vwQgeAJdu0?=
 =?us-ascii?Q?fKqDz3t60HYAMpBIPtJU/eMR?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b690c89-8978-4378-58e6-08d8f3eb8b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 02:20:24.5776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEYHw0nreFVp685ogMeNSDfwT4gRiIq4ZLFsSPuqmoRNMHEx+d8zrJ5QwjDQLvF8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gopalakrishnan,
 Veerabadhran \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 11, 2021 10:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gopalakrishnan,
> Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>
> Subject: [PATCH] Revert "amd/amdgpu: Disable VCN DPG mode for Picasso"
> 
> This reverts commit c6d2b0fbb893d5c7dda405aa0e7bcbecf1c75f98.
> 
> This patch is a workaround for a hardware bug, but I don't know that we've
> actually seen the hw bug triggered in practice, meanwhile a number of
> people have reported that this causes suspend and resume issues.
> 
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D211277&amp;data=04%7C01%7Cev
> an.quan%40amd.com%7C106f649374b14dc3383108d8e498c485%7C3dd8961f
> e4884e608e11a82d994e183d%7C0%7C0%7C637510692088534999%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=yLxYzonL8VrQui3MrFzsgA2FIM
> mRYt3e40jtvNCtRRM%3D&amp;reserved=0
> Cc: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
> Cc: Leo Liu <leo.liu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 3808402cd964..1a0c3a816863 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1405,7 +1405,8 @@ static int soc15_common_early_init(void *handle)
> 
>  			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
>  				AMD_PG_SUPPORT_MMHUB |
> -				AMD_PG_SUPPORT_VCN;
> +				AMD_PG_SUPPORT_VCN |
> +				AMD_PG_SUPPORT_VCN_DPG;
>  		} else {
>  			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>  				AMD_CG_SUPPORT_GFX_MGLS |
> --
> 2.29.2
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C106f649374b14dc33
> 83108d8e498c485%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7510692088534999%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> hG2dxaaaNNQEqgpKP5opDH3reYhZYKY%2B7q1n4aEPoqA%3D&amp;reserve
> d=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
