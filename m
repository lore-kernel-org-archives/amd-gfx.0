Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E3EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 09:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C2E60F24
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 09:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2C2E60F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8776FFD2;
	Tue,  2 Nov 2021 09:19:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C696FFC8
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 09:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa9jX+PtgygWgrBfy6Q7o04y/2oCElNPTopwoj/DWvw3BA+HPW9Dkd2kH5KYVFxjxqdiH4vlM8XBClJfqY/7EuDlgrG/o+uL1Iw85LXt510V2Mtrzurhb3qsN0/UD0NHHqDI6LtvvBkUp2QhkXhy+ltCgdgPat3csSznshRf6rJyng7TwXVLNUHPjeraAOdob6iS3UGZT2FDtiJiHq+sQKqaVL8eGhdUqELXJi0H9VmQNgj5CDLpS8igJ1LT284cPzS+GMSNcUZOcSKjJBZNxFRC0d6BIXsALJtFQsRj2PxZ6lI7LSeZB3qLRIwOoJhsk7UqO9m2zCAjk7iF5mSVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAUvkgqKR/wYUKnMa54VXdc4YD3GiIYtfheovuOB+Vg=;
 b=nUauMAcqoaPdnUOrLRlx1BuhSlGpP2f52NO27g6WK6t8aUDIDCFwq+fTe7Ie9PXPwzleGhTRvOYts5Rw4LC2c9Cw9p5xY5XA+BuqcevO3FTd7q3zblWszRZ7HcOTwTcZcyXvsBV6x/iPFhAv0ppMzBq/kY0yGnK8t4ydAGOhswRUubMTaaV5pn0QIANF8hJK64FTKTG5ULnoAAsqTBihPPkTZV9JHmS3mMNEPlE0nQt68lr7Y8/t8rS0VcggENBOgCLpLHYobcueAaMbmrI8HPlxgrZVk3LHGOtk2tbEp+O0ugWarGz9Ig8C+ykwNtjY1LGOe6swc/kjgbTV8iHIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAUvkgqKR/wYUKnMa54VXdc4YD3GiIYtfheovuOB+Vg=;
 b=AF+JngqwfM1ki13SlQgCHaVxg0n95I8sMvDNvyNTk5BkE6Nqdgd4tsJIpttfxUKt5XAniY2dFaBH48BXVaU1i+LW+qnM3rkN0SV7FW1RlScteCd2PgsLtUJp7h7mt2gTJ2yK/xA9jm+YqCzGCWDjg75ErpNCtdgBlLhHdF9cMJ8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR1201MB2470.namprd12.prod.outlook.com
 (2603:10b6:903:d1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 09:19:17 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 09:19:17 +0000
Date: Tue, 2 Nov 2021 17:18:56 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: update RLC_PG_DELAY_3 Value to 200us for
 yellow carp
Message-ID: <YYECgG+FxkFioTxm@hr-amd>
References: <20211102085118.1465543-1-aaron.liu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102085118.1465543-1-aaron.liu@amd.com>
X-ClientProxiedBy: HK2PR04CA0072.apcprd04.prod.outlook.com
 (2603:1096:202:15::16) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by
 HK2PR04CA0072.apcprd04.prod.outlook.com (2603:1096:202:15::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 09:19:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db6716d-8741-4bed-a3bc-08d99de1d830
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2470:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2470675F39E92F1FAD54386DEC8B9@CY4PR1201MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GJBdSowNayQT3/xotjepaESGYJmRS6utdLp4zyL9eFm/wrf9xy3Pc3MH2WjMoFCg/ZTK6izXIOMLBStzLJOXlKvXhBdNsvy4zh73iZ3cr5h1U4HwjW4cMIXt8NBLJ0A8eu+ixGjo3fvBto3FeXYFON3740D347x1z0BAJd/Dj26ve8A9e2I0OBA8ol1XjtpPe+YyD5nwwnU5tdJkPRU+ocwbVQgJ39pTP7QPdYlx/idOSo9rq72gEWAed1t89z1tw9EuP1BXSApgY9cBdOYU1BAJ5glVz7yhlb7bP1XUtiztbEqkDz6N5HXulvEY68pWLERhVwQnrnDMEiEOLs2t7IeSx1alsjjpRa9KdPha8nfTNYpg8cDR+7iBOsSE138pFW9CvxG401k/Du1dLbcR4/QHQ70g/+nWOw1v1PhLeil+Sl/VItAsLjO35cAbMMnZbOXrkJf9zNAiu1dcPDqBRFo0s2JRkEa88vlcCOU/dyjNOYIvQL+O24PaciWvQ+NCpACLWCj64/TvqIpGkZfiRKATwBcC663gdWYnub/NI2noPrbnm4fSv3nSvzqTw05F+hEzs9M5NZ5q9wqNDH+5f3dZRGcBBHZ6Aotxdx9iFa8K2KT7ibdrQOY6flG6rdHGTFLjpz6nw638GhrAzJCyXLgrphgeRZrff+7GXcmUX1lOhkezZUrA+lbKulI4Jfc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(956004)(66556008)(38100700002)(8936002)(6496006)(66946007)(5660300002)(6862004)(83380400001)(6666004)(8676002)(186003)(6636002)(33716001)(26005)(316002)(2906002)(55016002)(9686003)(508600001)(4326008)(86362001)(54906003)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWUrCYc8hDl48DJLQDg0noACt6bjugKg24wtCez8dacM3mFcDZwOPl1sbfN7?=
 =?us-ascii?Q?1KpiV7oisOc5Uok1nuzWvI9hiJFjOK/oxM/d/prRuygSLiV2DcdENl4QsCUs?=
 =?us-ascii?Q?kJvZXG7AMmPqyKum3GUBrav6yRb14WQnkEeiBcTN6v40azJOZA0xJ5DMOWz/?=
 =?us-ascii?Q?E3Uq08Gj8mW79cs4oT7+BDazu4VytpqCsF3tD6tKfwDe4VreYSmXnRqGryV9?=
 =?us-ascii?Q?cD4s7w386UbZhQKQ4TqgFtFBAh1IEGaC3UrwirMM1ix+aZrt+o+P0y8zNhjt?=
 =?us-ascii?Q?eeiHtbYepel1Y2eDbngG4SjCJUZsJfKptXQw3+nSNfhcvdzbYPCsCVs0LuNj?=
 =?us-ascii?Q?pa+lx3pcj4NEuOyLWcdZotX7rYtPWsz5WmdjsxdZiPsHCrNqvv2ZuL9zjxdN?=
 =?us-ascii?Q?WPBFIdIuNNO5MPnPgmnB/ozMdKbpfskzYSv+W5I5U3R6EUkSR+UquIGefZCw?=
 =?us-ascii?Q?F6jIIkZVYwvULBVylX1+U0xlT5VQU1N2PPTfHjdxaXKrxh2+6qya6QDFTRQE?=
 =?us-ascii?Q?egeJQu5riQySNkl74qcLq1N+S/qI+gwZ+Ps4t6XzR2BT5w7YnCyQ9X9um263?=
 =?us-ascii?Q?XNG4h/wTzpbmCJ2JWoI1hHCmyNhEP/oVr1qMNCEf2osWE/M55J4IbuRJGb2S?=
 =?us-ascii?Q?SD45JA4qAdnVIqqk8y6xUuroGF81o+ptq0CQ/t/MNm1OHGYYzXRu3dtpy5CB?=
 =?us-ascii?Q?zf77PvHg/Ur5Di6sArN2cTD2sFt0Z2qAkrmf+3BxtfsioXPh6W3EW6lWLIhY?=
 =?us-ascii?Q?brcHmCeoW6mMC0XyWC0iIBYP13m508RBH3vA0YQzzZvDFQhojbvm8JTtSrB6?=
 =?us-ascii?Q?0UXiVFJg1qHGbGIyFPkuRNMZiFwmnwRcv7OyJcgnRx8bbkbRMEJOBI+C+twf?=
 =?us-ascii?Q?sYlQL3+JEOPDAhO2CvTSLkPAd2Xn7dy5BoZdeK1bUXx9xmdpa1xwGDFVxKU1?=
 =?us-ascii?Q?Q8I5DnaaQtzgl44EzWvq9Wa3CANBaekRgtNQz93YpajVJBOAUYhjuoHSFUJ7?=
 =?us-ascii?Q?yiQjOfWO2ZacKNa2XmNE0b+GPd3Xx2+XsbIhtVAZMq00FJKvb5pfPxNG/Dzv?=
 =?us-ascii?Q?n4mzo2J7+RYcePsmx8q5ip7HQxw+qvbr7fsalov/Fb41NGaQ1jeSNuqi3IsX?=
 =?us-ascii?Q?ImsKgpX3v+NfZBMnGI71b/DauKPDi548jXFu/VznC6oHkSWia38+u37hFHKJ?=
 =?us-ascii?Q?5tid06BNiiJLzEXV/+trmVYpZ0vQpiNMiwKFFUGOAW/A9Xmd5zbZY1bUIhcB?=
 =?us-ascii?Q?qwOX16DGitdAmbeswqWy3dAf5/DPuhN47lA3hDKK9wMBRRthzJCiCoR2E3EV?=
 =?us-ascii?Q?qSSt2BuGpe6C6fwAyBEh0MOT7x0YBXkORO6+myHLkjGj3rR31W2H0PE3znLe?=
 =?us-ascii?Q?zdjA1J7L3ZxFImWeWa+JlaM16r18ZoABQpxUG6ZKN+oA4zFrzg7uNfYBovBQ?=
 =?us-ascii?Q?1HduhOJi60lkliVjcZOe/F9QqWaCs5suYBr5KrB9JhSF20JuY7ZwlxA7eVir?=
 =?us-ascii?Q?Pcoi3b9sTrAmkaZjdsrqog1Hw5qgdmMAwjEuaXOh17qCB+wSCGcu0j9qX9jb?=
 =?us-ascii?Q?XDrvV7qKKV7yngXGnIbuAgyFDiNkyTQeObNF/9ZuebrwbVRV2/XbvCsjwg0w?=
 =?us-ascii?Q?A7E3DKCdWMbeziMMl9T75yU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db6716d-8741-4bed-a3bc-08d99de1d830
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 09:19:17.1483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A162XCW2tasMz4NJv8Ak/sW3nwYjfnRdDfKhFrN6wQuV7m0ZYRrdkvEdLUQ+5jDq/9gsvB6MnPliNIBPSyzuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2470
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 02, 2021 at 04:51:18PM +0800, Liu, Aaron wrote:
> For yellow carp, the desired CGPG hysteresis value is 0x4E20.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 90a834dc4008..b53b36f5ae92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8316,11 +8316,8 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
>  	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
>  		switch (adev->ip_versions[GC_HWIP][0]) {
>  		case IP_VERSION(10, 3, 1):
> -			data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
> -			WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
> -			break;
>  		case IP_VERSION(10, 3, 3):
> -			data = 0x1388 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
> +			data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;

Acked-by: Huang Rui <ray.huang@amd.com>

Is this patch able to fix the cgpg issue in ROCr test?

Thanks,
Ray
