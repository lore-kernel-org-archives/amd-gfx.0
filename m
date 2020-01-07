Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573A7C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 21:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D56B2072A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 21:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vPxeG/qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D56B2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C326E13B;
	Tue,  7 Jan 2020 21:18:07 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690065.outbound.protection.outlook.com [40.107.69.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9BC6E143
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 21:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7/f7MuX6pMI18OUnC7B0wLHI8E7r2U3Obyhe1jVYPwghwT8BVyaMqYvzPWRsH8WsEu6KE1zskVb91MI2QFvsJbSQnzKWU6b0eFeY5yth39vJ2bMoYevPC5E+ehn5FEkYKqwugDEHCUtrXXQVK5FgIQQa/fWMpC7ZQMf+8zbvzEcCpmk/Q/RvIUDgvg04U9jzf2ijbw00eepNBCHLq2zLHo10ldqkK0hkiGQJUBA34AKtD+NwWB7VPCERQslYJw5c3nHZzWN17+tJGrtIPRipricb6t2VWAAknN719HZTGbO4Xa/OLhVscKU2niBIBAcYpk5MEER4OZ894AS1+AoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNDRyKJBv5lMetiGI4Z63w3iuZvV6K3lenE2WnBO0ow=;
 b=LvQVhozdadpvwF8GwlKTZ3GJ2Kx87E3qlzOWHxLATEqcOhzJ12Vy2Jc/kRIjhl6JZvsfOdyif1Hi7QLqdmfKqYn3vUKElE9znyG8/Go4e+2gGDStxCz+P66PVTLuSoYAteDxH88tOJ4Ycb+yAGghJUnXtYC5yCz4Gt/q4pBFrHQ0X6R2Nv+L4zDPOS4LaOmUmGwBe8aZw/AxxyykqgfIdaz7YcNXAtPJSJdVmc2EwXvRiZL+o2sSXx6x5SReVq1tryoLvFrrT9tLYb939Tlkk/2JE8iVQulxL8O1WZd53jQXokEzKbaq3jinJnXNkgWijnpkYRG/rZMFc6cFkwDIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNDRyKJBv5lMetiGI4Z63w3iuZvV6K3lenE2WnBO0ow=;
 b=vPxeG/qfB7HVi2eWkWAu7CTY9KLDZ9WibZJ4W+3d9dDanElSHhhXu15vuEsqNq5pY5D+Rc16vYakrIXMgdpdM+O7I8WUupShW3d4mjAyYqhdXIbbIE18tF+c62scBKlMn+YTcmakUwx4ZkmjXDNfRy8Q2uk/oZ754xd9OZXySDE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3078.namprd12.prod.outlook.com (20.178.55.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 21:18:01 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 21:18:01 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn2.5: fix PSP FW loading for the second
 instance
To: amd-gfx@lists.freedesktop.org
References: <20200107205508.2651-1-leo.liu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <c47b2b69-57e6-9e0e-e72c-4d0f33e0b08d@amd.com>
Date: Tue, 7 Jan 2020 16:17:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200107205508.2651-1-leo.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from [172.27.233.155] (165.204.55.251) by
 YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Tue, 7 Jan 2020 21:18:01 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bb39316-1d88-4509-c724-08d793b713a6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3078:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3078C544C5D470A78CA4AAAEE43F0@BYAPR12MB3078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 027578BB13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(31686004)(316002)(16576012)(36756003)(2906002)(6486002)(478600001)(6916009)(52116002)(36916002)(2616005)(956004)(8676002)(53546011)(16526019)(26005)(81166006)(186003)(8936002)(81156014)(66476007)(66556008)(66946007)(31696002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3078;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34IRAIOG54EZOnEKNE4QgOhOrWXEMngtQjEl1UMTHw2++/8uky6BSFnqykc80FtJFZbw80DN+qUiWTgYRYUQppid85PIpXJszAbg3AnLklb5HaZADheY3kpYswWyNfwxWwlwL7/Vfvc1UcqoPIREEU4n1wgwnvgaY7flw7lwbJyds9Y9GcOfjaQO7ww027B7726PspNEqtk8gwz7JIZt6HxSX/6IEMcYp+XdfJ9qrBavtLPGW+OS2n//hcTa4WH5Qwe/1NAtFokaFpAKo+F1KKDNZouleEn5rMSGYbLC2eke39HGx4ThphpGcVZYsICgcluGkjAAgefoLzN5Ceit3PCO0dOXqy+yJ7cj+RV1SOpO7vUwzEGbpJlgy6d6C3iKkHnH1L3yH6pf9OCvZmKGKvxmo5V20Xbnm2aVf8E/1LBtpyNMH9rH+YQa/lUyNbTL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb39316-1d88-4509-c724-08d793b713a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 21:18:01.6078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwl85cCnwgahyzu9Go9D+C32mQc0ae6FIWboVbFiUwRAjQcoNH1WgesM5UErlIbL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3078
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: James Zhu <James.Zhu@amd.com> for the series

On 2020-01-07 3:55 p.m., Leo Liu wrote:
> ucodes for instances are from different location
>
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 4ea8e20ed15d..fa9024988918 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -384,9 +384,9 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
>   		/* cache window 0: fw */
>   		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> -				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo));
> +				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
>   			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> -				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi));
> +				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
>   			WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
>   			offset = 0;
>   		} else {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
