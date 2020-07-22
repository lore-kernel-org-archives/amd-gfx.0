Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557E7C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 14:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79BC20709
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 14:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mh5Af/ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79BC20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A79936E822;
	Wed, 22 Jul 2020 14:26:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45B86E822
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 14:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbxgVNKdzq8UN6bJmC+G5kQHOEG1pvPQyUN8UHFRAzkqIbUS8cq70sZXgKk5C2YnPAdizdJiHtGojTAwRT+KJBr4miOM4jn6D6PlcajKi9h8pTz6OW8QH44pFGpysdZB8NY/yhMSW+N1RdWt4HPOrlWuOqD9TL51gLedIjXl1bF+3uhC4FqC04EepJ+OUVSNgon1pQp/yTngzvnYYvPEespNfduy44hHzfYShP6bmoAr2Emr5YfWkNQYbj0su1g1zu1VSEQ8Qvy8zLv0KCHzpJ1V0tf8O78PbWoFIiTs6NT8CYPMzifNI/ak6PLLFsJwL2vWVO8prhfQ9v22K6SCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGDeR4d7USA14UOMtwpypCsz8uPR/xeFeScDPsfgn58=;
 b=lLkBFyy7fF6yFOvVMkoNhxt+0lSQ5ar8XuBNDj8efG2apmJlugTKFTivw80iL5tL2Y78p3GSAsIKseYah7ZmGrNGpG2HlCh//X3T2/GbUDlGYOkErvtxvDuwOONyJB6zCa7lF6ydf4txD6hC/6RmPAUU9A1Zm7RHF/xfOceFV6h1YhOvIJCzXkSfKrTIO00ObpvbnPS1/h2vdI/P9oQWqvT0HagPhYS30+wiRJqzUXajSroNW1ZkIL41QLNvELsckUjoB+X1P1wOqa7qpKjM0sgW3cRkZxQMy0gzuynwDoE2dXERPBlsxgtMh8++cOC5Y+x6VWF8M2HEQ17fjxUS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGDeR4d7USA14UOMtwpypCsz8uPR/xeFeScDPsfgn58=;
 b=mh5Af/htWPcDFTJ+PyQFBxXmqBRnPL/HC3704++3A7Sl0Ek8CpZn41vNkokZoEu3/z/5S0FMmDHJwS9DHxXc4a/yOHovjtn2zeOcBFKxRJKwqurjW4A+V1s8e9Y8W0dYaYiwmqX67QkQMpWiSKgO00O+jsW3K3VI/drgBEhnSaI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Wed, 22 Jul 2020 14:26:02 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf%3]) with mapi id 15.20.3216.023; Wed, 22 Jul 2020
 14:26:01 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: calculate actual size instead of hardcode
 size
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Stanley.Yang@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com
References: <20200722031415.4792-1-guchun.chen@amd.com>
 <20200722031415.4792-6-guchun.chen@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <c735b1ba-569a-0969-b9ea-d6f33c29ccc7@amd.com>
Date: Wed, 22 Jul 2020 10:26:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200722031415.4792-6-guchun.chen@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::26)
 To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YT1PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Wed, 22 Jul 2020 14:26:01 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c99325a4-bc23-4f58-61c0-08d82e4b28d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3308019C84907A5CC06DF790EA790@DM6PR12MB3308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYo7rg/Uu5b3UXe3EwcpbDaoT6ioxJ/VxIgAm6U9OKWN8820+6TITOvR1EgcxreT781wrL0+zXycjzhlkTMe4tB2Qykqe5ATnKmU9DFyHHjMtuD6btP6T8UMdXbEhe1IU9WX4db4pSZxA0G9hFSvhSz3Bd04pmF2C08sYjXoLESJ3hTTVQmu06ZF4At3EaZtApfXDuLbsfX2fP8DgVkqOJohld6PoUh5l+9KqpFLw9d3WOC3ysZBMt34pdJusaci2GLj97j9BPe2PFb/RExRDz2QME+q3UvhcEtYu3QZA4Hz7zQRzyU4045K80fq7M8zoQPwS9/vW9peWaQy0idWGZZNENwQl1FgduL4SPx/vxU7VVg0CVeTYRriCD8RFE86
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(2906002)(16526019)(6486002)(8936002)(36756003)(6636002)(186003)(52116002)(478600001)(53546011)(86362001)(5660300002)(66556008)(8676002)(16576012)(66476007)(956004)(83380400001)(316002)(31686004)(31696002)(2616005)(66946007)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 27aC9FUk6WIFR3gc4C5RJ3UAOY1DV5hAJq4euwteH/teJB/Hvc1dhJGGtEkuqlr9GGoyWCSDhsrDxN+WHS0EmqKezWsKVpfcBCH2fzKYQ6t3doBoHqdgtbimQDWJb/G7aq9M5iJchgKojQQeHN+rn9D1FD1cecxzkJZho+b0L1CE44/vxIQpSWAhlj0oof0C5VUFh5NAqWOlUGiivXDQp9Uvi1FJ56DhTylau3crI5IRX89CpGMLSvju8Hf3OPtKRJ10Y8ZZhOOfrzvsWFJdHR4EWq4+2upYq+RXvKju3H+gjMVmyr4Rtgh2XLxWPvCXquO6rUEetsNTCzSM3pav65SQ6U+YUoR+yiFkf7NvCpcBVDN+8Fqh6icthfSNAGsS+/QsHK56Xfgn31IrkxounI2ic5qqHMenWkZs/qRIFC/SWGima8TTx659IkrC9f5TPjilGTWEvp02Spar6JqynAKWdPmTIjvxZyI4+zr/P3U=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99325a4-bc23-4f58-61c0-08d82e4b28d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 14:26:01.7671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUVjlq3kzaLz/DCpNaiN+C79l3cxXFif7l+6aHLUtzODqr/Pp3GDDQn9mbiWPybLeEKWyYgNMfvQsZeIx9UhTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
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


On 7/21/20 11:14 PM, Guchun Chen wrote:
> Use sizeof to get actual size.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 96b63c026bad..a5da108e43c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -34,11 +34,9 @@
>   /*
>    * The 2 macros bellow represent the actual size in bytes that
>    * those entities occupy in the EEPROM memory.
> - * EEPROM_TABLE_RECORD_SIZE is different than sizeof(eeprom_table_record) which
> - * uses uint64 to store 6b fields such as retired_page.


Did you find out the comment above was wrong ?

Andrey


>    */
> -#define EEPROM_TABLE_HEADER_SIZE 20
> -#define EEPROM_TABLE_RECORD_SIZE 24
> +#define EEPROM_TABLE_HEADER_SIZE (sizeof(struct amdgpu_ras_eeprom_table_header))
> +#define EEPROM_TABLE_RECORD_SIZE (sizeof(struct eeprom_table_record))
>   
>   #define EEPROM_ADDRESS_SIZE 0x2
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
