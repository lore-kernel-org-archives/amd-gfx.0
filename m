Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1561C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 16:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E9261421
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 16:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E9261421
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12C46EA35;
	Wed, 30 Jun 2021 16:24:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180DD6EA35
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 16:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhiWQnR6PSvzZXevmAIqjhKIq7FpUpkQFLqy7utSZbHRZo+X7TYk+eLKWFaJKP7gbBp2DzobIZrxI1z8tO9cKJTVT/VM9VpVVUT4G9dufKAc5JWXrdRTve7SsB6eVK9dFDGlh/rsq195dBp8yhZmRpoCstMs/dlwi7smjfV84rgDLIugSL1JVvYwLJ3SyOKSM2rzEtZBKgeo47biOYVsGxFq8lSYrQPKQ79k3++XBC8lU9urMMvg4swtDZT5FuJA8YAi2/YUVdIARn3x6NCZHuqQfZZop9kRz3h0oqaW1XWPdmnm/0pqCaK94yPO+PpPeIhBwuVoKoNtYJav4Yl7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBCsAtpvOO//jEqXjHzsr4k0X/oiYIZ3fy7+hSxI2vY=;
 b=QUng+UAikJM8uvQtPur7SHqTNkYoldP/NpB1wpToE4jYv0IBtg6vzXcWHz9fGJXep5EWswl8rQabmC1hUxleem8OAuw+J+wMCWYdlakxJUGngtY9e4sKecJT3uM3q44SapcBxDfD+YZ4gK9Rllm3fqd/xHgeJ5xqxVT6NqLg+KNMOCF9x4T/jvQisRSpyiND+p2pf+BDHTASUdBrOniolGlCAV3ZjlY0VJYN9WZBrmkpVC77/k7tbgHqxybQJE4oz8QD8TbzVO9JmcXM65zCFpt56wIXNW9F+PD6fIj4sBI2rpJoQbXRuw2faHI2JSqXi31idVKFSzmG13JCcrh44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBCsAtpvOO//jEqXjHzsr4k0X/oiYIZ3fy7+hSxI2vY=;
 b=e17zhu8vzcCRvG7v5O88nxEDUHY5M2i49i4SczwWyYXL+a1mqYazRo+8PC0Zr4I35ZEO0v8sBMvmksUM0vk6bRvrKH2YsAwnCGjurH7N29vfFyTLJfRrKi+LGFgZla1wEZ2ch7K1xyWpJo5Lkqr8O6rQ6U0nevy2ZpwrW1u0NQw=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Wed, 30 Jun
 2021 16:24:55 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 16:24:55 +0000
Subject: Re: [PATCH] drm/amdgpu: fix 64 bit divide in eeprom code
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210630152537.1133143-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <416d9ae4-4313-16c1-19d4-375b1f51d9d5@amd.com>
Date: Wed, 30 Jun 2021 12:24:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210630152537.1133143-1-alexander.deucher@amd.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.21 via Frontend Transport; Wed, 30 Jun 2021 16:24:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4b8bdc3-f824-415e-f2f6-08d93be3986d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3690B5563284ACF024E4EA7499019@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1jeY5I9hHOE7YWoW6NwTcVs1Y9VLGFzG7bpKOulOHRj+sJHVOSXBH7grSTdqJlerFV2a6e5Kk2iqfTpJhqJerNDrFCSrEcRAoTzD5GEn+ZrUCOKfTzadk9QaLVZIatv+Zc0LNL42wWFtrQWgYwFPFLCnmD/n/ypYJYSXlgva7dczrlp9bZqp3TP0zQgF0iHZvDirm41rOpQnM1K9ztvM/wa2i/09U6DEyW7Dh+zikkH/KR5EVKT90HpmdYefuPeIbmv0xIZhnqzY82duB5svSgmzVw1RI/1hNIFmgBjcUXNqrK1jOiksWuO1A9vwdogLNNcZ3Bm2QK3eU1rzAYZhOkKMVWS3T5+OJd8su9UqYIZw3clx4MlLVZ7uFjQtA+5b6Q7gB6iRkXZ0uEWdmlTSx+wbliB7q1lnA04d3EQjpV4J5NxSSv46OAWGzC7mteoCbmhaYYNb8dP3lfW+i/+h4DXAWOVHk0koxKsgInREpZg/LTblxh4puYUSIk1btRMtOvXICldgUfmzujogfWbd09jFfBWBh+ozNkVZlw93b2XM3iWu3gdnaPkoMDfWlPRg59L6MdIYLDq2y42QURj7SAlrovFIdMnLb5h3jBPcUXquP2t1kG8gWIKh9mn9YrQilwcVpkQpIsozqil2aHEsmwOstarJLbu9h/0tIRayjL6mpgAS5N0xnLi6BWWIKTnijV+aVAy9FEXS+Y/Ndy69InFYHI4dy18/aYAA/7f+VC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(316002)(8676002)(31696002)(8936002)(4326008)(83380400001)(956004)(2616005)(44832011)(38100700002)(55236004)(36756003)(478600001)(26005)(86362001)(2906002)(6512007)(5660300002)(6486002)(66556008)(16526019)(186003)(6506007)(66946007)(31686004)(53546011)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVJ3c3VLRUZrMnl5WVZXZG9pRzY3eDQzZk45eXduOHMzbUFwQlFDOFhRNEJu?=
 =?utf-8?B?LzFnV2RHeTVOK0k4eHVCRHRlbVZ2dnJ4ME1PVW9FV0s3WVFjNkFFU25XL0Ez?=
 =?utf-8?B?NWQ4ekdZR21BNEJ1cC8zK0EyUHNsL0VPSU5ZZDJQZ2hBRXZVZnBLbnNTaXpH?=
 =?utf-8?B?dFpwVno3RE5zVGVlekxRL0J1Wlg3OVI4dUw5NUx3aEFjRDlpSm51dVNXMWM3?=
 =?utf-8?B?NDhtRVU3a05obCtveFd1NzRTSEZORmJuOSsya2dOd2RvZjB5cEFTWVk4TzFM?=
 =?utf-8?B?bEc4UHVYeDFYOE5YOTEvWUFDcXZUK0ZOOFhBdExHQjNGUTgrbWg1SEdiTUwx?=
 =?utf-8?B?SUl2VDhzK2c1N2p0OXlkUnhjWGhzajdiM3BveGUwMHVoN2Q5bUszY0lxVHZ5?=
 =?utf-8?B?cjN1NkJFd3FiTnluWEd2TVUvRmhJNG9VSWZFRzNYNlAvQUF0ZUxBK3RDOEFZ?=
 =?utf-8?B?ekJlMTgwTkE3Mk5sR011YXA2T0dOZWV1Mk4xM2tRMGpGYTFyM3YxOUJGckli?=
 =?utf-8?B?MHFzQmhOc0ZiM2IwRGVwZTMzMzJFRWIxcE9vMjF5bE8ySkZhbDFtVE5nODdU?=
 =?utf-8?B?MUpRbWdmSGhoMzB2RXRVUjRpekRsRDVTQ3FaZ1VvY3RmVXcyMmtpSndDaE91?=
 =?utf-8?B?UzcyK2tLcHRkTXpSVDBrOUx0N3hVTEU1YzhLNWFnM0pnSGJ2SEN1enRvYSsv?=
 =?utf-8?B?UlAxR01QSDZ6TDZFeEp6dnVLbytSVEpneGNwbXphMGsyMzRvUWgxTWRHWmhv?=
 =?utf-8?B?QWJPQWliZE92UXpJUEJObmt6U21OdFQxRjF6N1g5MnFEV1NGQnYxd0E4SHkr?=
 =?utf-8?B?a3ZNQVFJTVdUTWFHeEppZEE4cFJNTm1hbDlvT1NQb2FTRTZwbWVVcVM4OVc2?=
 =?utf-8?B?SFdtUjlMVkhTVFRJMldQZ1NSSUYvT3kzeDBpWTE4UGl5QXJZN2dibW9NVVU1?=
 =?utf-8?B?TmxvVVJVY1JoTEJUdEQ3U0FvZ2JuWDNyY2RHQVhCNSsrbTJ3QTdqNlhmbXFy?=
 =?utf-8?B?K2kxZ2V0ZjlNcUJyWkNXSW5FZE5lbHEvWjJsb2JwT3ZPdWVXSG5UMEp3d3ox?=
 =?utf-8?B?dHNYenJqS29QOWlmdW9BK3hjQzN6UFloN2NETGlEcVZ5TW1hRk84eERuVEgz?=
 =?utf-8?B?TVl6L3pKNTgydG9NRDh5VXRSVEMyM1EwUzBxKzcwckxRdFVYcWVFYVRoYTAz?=
 =?utf-8?B?R29KZWpzVm1FdHhRMUNRdTlhSVFPS0dsL3NrZWZaTWZhTEhwdnBFazQ0TjJ6?=
 =?utf-8?B?WC9zMDRZODQ4SVZHTkRFV2wvVmREQWtkK0xIMXRmM2dOb1JjSjFaYW9qM3Bs?=
 =?utf-8?B?MTI2ZGdKYlI3SnJxS25sdjdkV0IrNDBZS3YwZ3laaFBqd0IzSGhRb3pQdVQy?=
 =?utf-8?B?ZDhDZXNwNUQyS1BoMS9uR0Q0S09OcnFFN2VGYVV3TUZ5dk1wMXUrWVVvZWxq?=
 =?utf-8?B?RzBIZXlnZTIzVm84VVA4dFJDVjBHTjY1VTVka2ZBUzJCOHMzZjA5NEc4WmJH?=
 =?utf-8?B?VFd0M2hub0hKVTFtalkxTUpqWXl4U0xramtHMFJ6MTNsZk1oTE9HajV3YWlX?=
 =?utf-8?B?eUpGMmdDb0VRRVdwYlplM3BYUmJ4eTVUbXVmWVdlVzZlRXEzZUtzQ2xrTGRp?=
 =?utf-8?B?Rkk3OVN5Kzg0ZHcwREJzdW91T2NHZW13Q1N0Rlo5cHRIVy8zN2FGZkIzVFRD?=
 =?utf-8?B?ay9hSDZKNWU0YzNkd2VoaUF0UzV2TjlDc2o2U3JUYjdpNzFWUXFLY3M4UFpi?=
 =?utf-8?Q?Qcqea47VhDeUpRFP+7wxhX+EyF8liAxicTubp3a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b8bdc3-f824-415e-f2f6-08d93be3986d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 16:24:55.2322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyDydtXb048j3XFMtHIanjTzNJ0yv+TbOfKUV7XN9lsKToVJlCbKvawEcWqIumml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
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
Cc: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2021-06-30 11:25 a.m., Alex Deucher wrote:
> pos is 64 bits.
>
> Fixes: 5e98eafa90ca19 ("drm/amdgpu: RAS EEPROM table is now in debugfs")
> Cc: luben.tuikov@amd.com
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 677e379f5fb5..fc70620369e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -880,13 +880,17 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
>  	if (*pos < data_len && size > 0) {
>  		u8 dare[RAS_TABLE_RECORD_SIZE];
>  		u8 data[rec_hdr_fmt_size + 1];
> +		struct eeprom_table_record record;
> +		int s, r;
> +
>  		/* Find the starting record index
>  		 */
> -		int s = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
> -			 strlen(rec_hdr_str)) / rec_hdr_fmt_size;
> -		int r = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
> -			 strlen(rec_hdr_str)) % rec_hdr_fmt_size;
> -		struct eeprom_table_record record;
> +		s = *pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
> +			strlen(rec_hdr_str);
> +		s = s / rec_hdr_fmt_size;
> +		r = *pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
> +			strlen(rec_hdr_str);
> +		r = r % rec_hdr_fmt_size;
>  
>  		for ( ; size > 0 && s < control->ras_num_recs; s++) {
>  			u32 ai = RAS_RI_TO_AI(control, s);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
