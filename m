Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D71C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A5D64FE3
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A5D64FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D588B6E9D0;
	Wed, 10 Mar 2021 08:21:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 102836E9D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 08:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1D6wPzHHD2cPftLT3qIyquna4uuEm7MHvN0iDt0Mi+aUvHwngPqlZhwqccBmcu93iEpsEGl4iWUqLvGiYwEDFO9WKPEiDxfWsgspq4f8irDHXtH2g+1NgTGKMUAHqEQQCDzeH8kMAAjHOLKYY6Bbirkcu8NiAqZy4lH8ktDy+b5ZW89UqNEH7p3RuQcWgnO9IexhzTaNdz1/tjbzR+NEEoxwbx5kGeMiO2HCohLK22r7GyI/g6l4oaIFXKoFn/Bs7ipW7Z2IjwY0+cPXx8y8kPLIN/mVfakt9jXh7TB2tDt/tZwbz2c294sD/HJzrtUvQmn9Ovz14JJ2LrDMDbnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEK4S+gqITBqNTZYOM7fvdCnym4UF5+V3TRqW7Thd2g=;
 b=XmC+6f3WpVT04yxhaUukU5Y2IUBxA0h8BP8U1EjFKXEP2bRUwTnrqq2PlkBzbVg21eErVU3HkKbYYMIw5Frsyvhyqj8i3m3I8o46jRv2mPyE6q0dv0kflQyTcIaTr1hS/IbslKoJyGpXiWrVICnKuE7p0mSYB+FzuIwoYIV0ake/LATRQudldAOc8wmQbdTFKVLKhCeqMOFaBJtFYx1HJ3kZh7CHBR/okPo8REpIAz2cti434OoL/OaNRK3E6s3pwMufOkrzy9oCQvvHAC8lqurjdDv2MZJzQ4XoK8uIFcTx6LI0s1EZSUW/ey7Dr8q07tnLZvlFkf5oTtnI6ytupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEK4S+gqITBqNTZYOM7fvdCnym4UF5+V3TRqW7Thd2g=;
 b=YzKYys35GoGrCxZHOODTbhO9TU3V+cOdoFCJx0rm8jFUyftf9GbGXmr7zm+C554gCefD7kkim3R6LBbqp484A2mc9n/Wn0qq1lQWYvnj2KYtFPmAi+dmvPuOA5A4IG/lVowdKfuXdLf1pab4w98aAX/4aGH1MOFgMQ8v+DP4wx4=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2792.namprd12.prod.outlook.com (2603:10b6:a03:65::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 10 Mar
 2021 08:21:00 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 08:21:00 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix S0ix handling when the CONFIG_AMD_PMC=m
Thread-Topic: [PATCH] drm/amdgpu: fix S0ix handling when the CONFIG_AMD_PMC=m
Thread-Index: AQHXFWIAl+WI/eAkGEq3WOwrqntheKp81B+w
Date: Wed, 10 Mar 2021 08:21:00 +0000
Message-ID: <BYAPR12MB3238AC37D323303D02FF7D79FB919@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210310040043.289471-1-alexander.deucher@amd.com>
In-Reply-To: <20210310040043.289471-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=8ee7ae2a-b97b-4981-97ae-ab88b5167a40;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-03-10T07:32:04Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a873dfb-a2cd-40ee-9c6e-08d8e39d7054
x-ms-traffictypediagnostic: BYAPR12MB2792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2792C1C8F0BDC7A5323C8F89FB919@BYAPR12MB2792.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dnXIWZayt0uYwYntGsOeNwX0HhUe5+o3fxtNKwTXH1jeUCLBKOtqV7Pn+8gvM6brmFnm/1r2pts5PMciq7jZbYuXnvuUfU7G7B5MIKkPAOFDJMNq9d8BUZ3ad+TL5nEQwrB+2nGqsAckgZ3FMcP4KP3jilAlAYqPELxhgNB+jhGuBJDXxATVAZ08prr1vjdkGUaAIAB9aBXsPrl8F3cRUp3Qdj7hED+KW8mYfi4jIBkY2M3M8ytrB0n4izXzBJ9q/9HCFeJHoQMCdme4rhteDOXDysqdAy+LI0mse3sL01EXAMVFaTFbu5OVFT/ttnAJ+fc4V+9qq21hv1s4mf6LN9UrVP2e0d4jSJXs1KsAI1WuJohhMye01mUQulRmafZANME4gCATDRwOreN28EV7Ta4YqNXgYtlHGrM43GJzx/LYtz8BE4xKojXxCQlSf9y2frz0+EmW1Xg6yCdsij/tAle8Hc1k2vOKF+eW7MwS/L3DTBXVesm1Du/knjim+BwSmt6qQ9SxCRgQ3I0G/XGA0b0CkeUYYwtfhcAf+f8fO29hINnSrkKOkE9lWlaIy2N2M8NMx0ymGnz0bNz1nSizWEto58x+OhFAm5tJ+KjphER1SsvBh0XliZYvfzxMc8NfLLQ59Skz9TGkv35Thyw0kA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39850400004)(376002)(66946007)(478600001)(2906002)(26005)(66476007)(83380400001)(5660300002)(66446008)(45080400002)(9686003)(966005)(64756008)(33656002)(316002)(8676002)(110136005)(66556008)(76116006)(7696005)(4326008)(52536014)(71200400001)(55016002)(8936002)(6506007)(186003)(53546011)(86362001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DAZarWMHXb/0N5sFrI9yhrJH/FILBpCJRaCz24xhM4mGQdd+d/NqeYCkt3Gu?=
 =?us-ascii?Q?O/RBNseyjToFejqIhFcOHZb61b7hmCnmQqxiD9OvQW3AObRCfl7IC3kbujJj?=
 =?us-ascii?Q?hSZn8YkTWvPtVn0/NhVjouRuyIxo78W2cxUoej3Oq53R3ppWvlQt17Ddkyci?=
 =?us-ascii?Q?zEZCHgx3BfKPu+FdSmJOMJo6khomfh4dRYbJdfK+0GtX8rXI4yLdxgAOSyoq?=
 =?us-ascii?Q?KEqnIet+UGgGpbamSE1hJCgkpVJv3VtaWpnfzyyKqLOpulXPTn3UhBWYhau/?=
 =?us-ascii?Q?kRgHRe5IV6ABUfGW5118VnBea7BDDPX9tbL6OdleGREi3ZizXuYgcoQdmhms?=
 =?us-ascii?Q?VJYoxz4EOGIRRNiGSwXz2u8yGgVm4nydEq8a8oDU9vFZH/Zkw5/syihQJqyS?=
 =?us-ascii?Q?nvZtwNRI7yKXb8ziAor1A35c4wNne+XYgxuc61xSJHnyrRr3GSoQflG5N/RH?=
 =?us-ascii?Q?AvlIRD7bnGJvgiN77+Hl8cd/E7hAgj6uw1uWaBx7c3YY7CaEo2Apl9sMVoDe?=
 =?us-ascii?Q?STAloPYICNH12rrSkapCHhtH9w/tPjIpe5JaJv0GhC1HI7KP5VdZxQ7gAbW/?=
 =?us-ascii?Q?bvgcqVEyInDVHMRdxKRScs35F7pnp9GEOTvb0cMgEceQPlftnBBsrDcLGFLK?=
 =?us-ascii?Q?6Wxq7DnxwExyBJI20mhu499UJWcyLa9xWg13LQFJ8pOxeGKftb2SQeL0dhIN?=
 =?us-ascii?Q?mR3UHLoesb4nC4D66pWNuPa7V/JZtF2oNXORvXA8/S8jjM5a8kPjeG/f3qFB?=
 =?us-ascii?Q?5ip3i30MI7GrOlb6dyDDRedboF0GKf0l+gs716ZhlA0ksBUMXdfb5+E066Fj?=
 =?us-ascii?Q?i6JSsBhuSImf7qlwLk36eV+OSUgscihJ+2fjbtWdJh/QMMOZFuNy8zHX0VFL?=
 =?us-ascii?Q?SyaQ5yYrh5URas0ZXL9ldYBNVEO3YSS0c4EUJ57BtneZpCCXSt89bFPLWywk?=
 =?us-ascii?Q?NxygVcwA3ACt8e9iONlihwTQlnSfKjTqm0J9OQO86WZdOp3uWJeIP8zFqLSr?=
 =?us-ascii?Q?WH0NKURyHgU6nKXmz5l+tOQ7qqODW/sM3sm4Ba0n/qylKQ3bB/yogNY0Db+h?=
 =?us-ascii?Q?BzuaITXFyuotVJeMkVmplA6Nx1WJ/Zn9Gq/P5G+CUltzxLT8mXmUP9O+fHcA?=
 =?us-ascii?Q?rKOe+tBzIOVQ5Qofh9cms5dqm5EpmK2SNHfnv48QQL56pE7Ttrg/0mY+1u/L?=
 =?us-ascii?Q?uz42N98pLJDPVtkpWnrWMKMrT1dGaXwJt+BsY4AkxsMj13kcaQe/PEQiee+P?=
 =?us-ascii?Q?ilYeKl4aVpBapNi465zgVch3Re5AZUCoPG6Kv7cZg/4d2GK3m6uZMvDMj3QI?=
 =?us-ascii?Q?d2QHSDq8V62sI/kNms0ribsV?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a873dfb-a2cd-40ee-9c6e-08d8e39d7054
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:21:00.2591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +m0t+gLF7NjbETuaOCwCQR3CxbIR/M2ehe0SyVz3TIiayylruvCELJKZ9dBhkIgL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2792
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

Not find the Kconfig script in the in-tree repo can strip the config variables and add  _MODULE suffix to module config variable. Not sure this  _MODULE variable config whether introduced by some specific ENV.

Acked-by: Prike Liang <Prike.Liang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, March 10, 2021 12:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: fix S0ix handling when the
> CONFIG_AMD_PMC=m
> 
> Need to check the module variant as well.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 36a741d63ddc..2e9b16fb3fcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -903,7 +903,7 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
>   */
>  bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)  { -#if
> defined(CONFIG_AMD_PMC)
> +#if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)
>  	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>  		if (adev->flags & AMD_IS_APU)
>  			return true;
> --
> 2.29.2
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7Cebd55e2581834e12
> ee3d08d8e37921b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
> C637509456690121890%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd
> ata=zKMQiqcdFs1lyuSJY2Zg3DxQemTYqCRVGtNFSiud3NA%3D&amp;reserved
> =0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
