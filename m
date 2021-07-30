Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C382C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 15:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023B560F94
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 15:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 023B560F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468796F458;
	Fri, 30 Jul 2021 15:14:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60E46E3EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 15:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWloDjgSXPpklEF37vc9aVJyWk0qqSKDcM2eNvRenz27wX6LmA4JedGGob25Ur3ptrvxvuyBA8xuShNnDCO5MeGN0JVUwmHyTmZIC0iRZVrfSrfL1JZ3k4w4WKgzdLQ7Y2UuuoZCgrHDRMznlxmquHyfIs4WIi7wrsaCJbfJvmuaW+3PeCapSHi0PQ3CrHzIxak4tHVXx65TjRB5yooXx7PLSfTR11Kt8ei7U9Uyle4FeHp7H25cjZ1dirUwpMemNfdPNZ1HBdfW9oL+Sp4XQEQBXEFWxrYsEgkRHk2NcuJFCZ/qsNAZOq7o44M6C+3o+LYzLz1IkT1ntFENUqYlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIR47624dFXrIt4IO7kCuDDC3Cq1Y3F8H9X/KqRAdlQ=;
 b=nXer6pCCDN6s3ARsclJ2CSihCNzMVY/SYEvjj7/XkIvA/mLv314UBwM+ager0p7aES1uFFLsBmc16Y1j9FVPDHvWziab3WmC0PJVPqR0CDYVIlO3n8QQEJNT8E+S2FWemNTOmmtS+tACuNXw5ezHEUYwMnVaiUAnOp/V1S2asqKZ+QWSriE0tqlE78hZmVsYxDs4q94KgpdOwflIff2DGzmJ7YN0EZ4SewrmB+WVL4cZ2ADDUTfw9nli16G214Ubx7Xv6/btl/G6QGYi5EX9llHnOBxdGFtpxLFRbO+z4IQyr+0dDOowAHJR4lJQbxqnCB9QkG3zwO+L5t6/FYjK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIR47624dFXrIt4IO7kCuDDC3Cq1Y3F8H9X/KqRAdlQ=;
 b=JI3QSW4/tP1PGmabyPZ3yWML/qOtyVDH6f9ELb1c8e2Uqdh9a68+CvXX/LwOc/Iug7/QaPV3y5zJTs1JHbD0/l/ceXlDnG8hQdtMLb5OOk7l0RiIBoBTBjaf6TYlh9YyzDru/CQ6GugVRb/Q2O7iEThWTUQBVzlI6iVFI7+Sga0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 15:14:42 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Fri, 30 Jul 2021
 15:14:42 +0000
Subject: Re: [PATCH] drm/amdkfd: Expose GFXIP engine version to sysfs
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210729202514.3506-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a37a0f34-9184-dd4a-f59e-d08f946f2123@amd.com>
Date: Fri, 30 Jul 2021 11:14:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210729202514.3506-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Fri, 30 Jul 2021 15:14:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3df304f0-00c1-497c-e991-08d9536cc19a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51457C2596E9F6BCA72A436592EC9@BN9PR12MB5145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmHBnpp+m71/RgB3MZp4twf1/bFwHibCVA4QGozz3JJTvnTP41dfV416mFdMMxiL7a2Jj7PZKB1gSsq7pi9JDgURTJHRD91pdPqHjVDOD26ps7OO9mjWmT8+n5YCzUe5v8Ji0ZwLKf4KyrStXUhE3g3s22ngNBpOAuFFZ31xe/Ymt+fexZabK9YXroiygRfhVLPS8DWHLq+wsUYB17GKoQSrPO8X6KdrSqR6//aP95EXt32yetGcWJNfDEU3OtjIIbKVAb4lXwvnvU5MQ0CI7uhmHXnWSdhpPJa/4z6NBc56MZbF3mihrfy3rOKj1CHOjihy52I1kvk54+nfkTo1rlSqI22MEMCs//pFrvVFrUKmIfSZJFJCwOPeSZnWo6Tv9VU+y5U+t5BirbYGhDKXIaQ/Sz/YShTxUjxYOZjF+BSWc/qUqUqGXmkT+7NE9YO4QnjIJkMdv+BdXgAkTtFmLJZ7euDHSjUvWQLU+vRykpmCqLktnFVoqHfCYCTLZDYEGqOl+oTLu80SoDrbSDndCXCFnWotetvJED6/hqkJZ90bcLIhOB54RSXSNnrVypzPvnVmXaZkd01vSXevcVCC8w6YEjh08se8yLfEJrYM4FX4Txn30Za57Rd9O0FVA0qobfesjkK9/OK8RRAhbhDzhQIO03Ua8Z8ghPjUY9oir9CF+ixVhG4HQSxdJgTWVTlB3crjovXoMCpOHFpCJqUJghdYWlBHKM1rji08SuuIJx3JrCGtWVJn7IJkT510Ysyt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(316002)(66946007)(31686004)(2616005)(16576012)(38100700002)(956004)(4326008)(44832011)(2906002)(186003)(5660300002)(30864003)(26005)(8676002)(8936002)(31696002)(6486002)(478600001)(66556008)(66476007)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE9wVzNTbmJ6ZkhNNE15eVptSVNGNnVqeGs4MFlDSG5LeVpsS21oM0VwQTky?=
 =?utf-8?B?UzVjRjkyQ3FJY0t1cGdpVlJkeVE5YWpqK0lyeE01YjVNcWZ3ZzNMS2hJWDJ3?=
 =?utf-8?B?V3F6ZHc3V0VvNnJZR3hjRzZtL3J0VWdDVkZ2ajNaV2g1eHN1VjlhdUx1dWYz?=
 =?utf-8?B?V2J3eDBEd0tqUjk4eXZPKzZyYjIvZDFrVlJiazZIc000TnJsRVFKU3VCaEhm?=
 =?utf-8?B?WDJOMG9oVzUrcE5zOXdqTS9kTHRzY3BRY0xYSnBKRWgyTEUxdllEL2Q4OUJP?=
 =?utf-8?B?c0FjbjRtNDZsVDBFRDM5VjFGSVBlQU1Tc3YyUEJRekpJRjBHbkQ0RkJ2TG1p?=
 =?utf-8?B?SWkvenJhRkpYNnRBVTBtU0lvb1VxSkdJVkpvMHN0ZG1ac1VNRmt0Yy9pUmVx?=
 =?utf-8?B?dUJTZTNQaVI5c2NzOEYvbGF5ZlF4RFZDT0w0Ykt3SzBCVlNjdnllYVZFcTEw?=
 =?utf-8?B?RkFHMm5BRjVpNWhuMEtwOG1QcDdWS0ZOQ0VGVUc0RTUwVDlhaC9pZ0E2OUlm?=
 =?utf-8?B?T1ZQRm5HTjFFSDVXVDFwd0g5cGl6eWhyZmdNdzQ2V0EyaExMcU4xQjVqQnQ2?=
 =?utf-8?B?YXlJbUZ3dnEveThPL1dmeXkvTTh1d0JkejJIRFJTeXU4a3lvdTA0Wnp6OUNY?=
 =?utf-8?B?NFQ2MjNzT0RrTEp0ZnprWUFNdW1rblFUbmp4dHl4VjJlSm96bXV2RkdUa3ph?=
 =?utf-8?B?czFvT3NzbXB6Tjd6S3laTTFWWC9wdXFRZktCczNURm5nYUovaGwwZ0tONUhD?=
 =?utf-8?B?QmpaTXhuRjZGWDF2WTA0SmFCTVZEVDVHSW1ldVJwS3FYOU15aFdHRDVNbDJZ?=
 =?utf-8?B?NHNsbkUrR3Jtbk5lVTdCeWJuWmtlSGhtdXdZSEhrcUNNN2h1WWd3UUZqYzJT?=
 =?utf-8?B?V0dUUEpaODUzR1dyT0lIYzc5M0lxa1g2MVZEclA5ZWZ1RmlVN1IralhGTFFI?=
 =?utf-8?B?WDJTQS8zZXUydEl1VXB6M3NFVjBBU3lpeEZab3lsbjROckFyekRDbEgwRzhr?=
 =?utf-8?B?cndzMjZoUDRCdngwUGhqanROQVhuQi9Uay9pRzhiMjFjT0t3NzBzTXRpL3RQ?=
 =?utf-8?B?Z3BYL0R3dTFBOFBJQ0VLK0V3bWh1Nk8yUVBuMjJtZjZZNjdDQ21iWWYyajZh?=
 =?utf-8?B?MnRvMzRDTFJ3Yjd2U0NyWTdGbWZOeWE0YWpacjFoYTJpOG1wUmlRQXd3MWhN?=
 =?utf-8?B?ejk2K3hhTldBdk5hKzRoL2N1eUg1emxWTEZrQk1LY2QwdGhWVkpESW9RbWRJ?=
 =?utf-8?B?b2MxNXF1clAxMUpmemx1MU52YXdUcnRqWmVORm9JUVpxWlA3OUttbWgzYmZp?=
 =?utf-8?B?cmJiNkJnSGFUUWsxendVaDhmcmZwMm90R2Z0ODlvYU1CYmNHakVtY3ZNV3NX?=
 =?utf-8?B?c2hadFpRVUV1dTZwekdITW9VZ0tybnlGdExiWDlxNFZEbGpMbHdsRjZsY2JL?=
 =?utf-8?B?MGVYQ3c0a1NxYUF6cHI1U0tUZzRtYzNNUmFXd2hkanVQaXJSVy9sUWU3WGRO?=
 =?utf-8?B?S0xqRFkvbWt0ZGZLRjJzbDFVbUFoeXpOOVoranlESkNYNU8weDhYRmFXREhJ?=
 =?utf-8?B?MTV0c1NpWXkzNW9EeVBMRlJFd3cvckl1ZjMzZEczb3NPRC9ST2lrN1cxcHJ2?=
 =?utf-8?B?SnVFWi9MUjBBdlU4ZkFlTEluL0UwMWg5RjJTMUVaajhLTCtKTE5wWFBzZzZY?=
 =?utf-8?B?emY1QktYVnFMVy9MQVdJYU5WZm1pNjBaRUtvVmRyT0F0WWJPZVNTQjFhYzRw?=
 =?utf-8?Q?7RRUsrbWitMvChhrHaNADfsgSrLPGmt9syEpf1Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df304f0-00c1-497c-e991-08d9536cc19a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 15:14:42.1664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3qX7K0t4iAkWB4Xz0otPUO5+Zh+EkXxyAA1GItDGKOi+rC4xtrktSYVaM+fAaXw4DaNein4/JZmlewi5yHy2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
Cc: Harish.Kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-07-29 um 4:25 p.m. schrieb Graham Sider:
> Add u32 gfx_version field to kfd_node_properties and kfd_device_info.
> Populate <asic>_device_info structs accordingly and expose to sysfs.

Please describe the reason for this change:

    This allows eliminating device-ID based lookup tables in user mode
    for future ASICs.

See also two corrections inline. With those fixed, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 29 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  1 +
>  4 files changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b551dd675085..1699f1adff9d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -91,6 +91,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
>  static const struct kfd_device_info kaveri_device_info = {
>  	.asic_family = CHIP_KAVERI,
>  	.asic_name = "kaveri",
> +	.gfx_version = 70000,
>  	.max_pasid_bits = 16,
>  	/* max num of queues for KV.TODO should be a dynamic value */
>  	.max_no_of_hqd	= 24,
> @@ -110,6 +111,7 @@ static const struct kfd_device_info kaveri_device_info = {
>  static const struct kfd_device_info carrizo_device_info = {
>  	.asic_family = CHIP_CARRIZO,
>  	.asic_name = "carrizo",
> +	.gfx_version = 80001,
>  	.max_pasid_bits = 16,
>  	/* max num of queues for CZ.TODO should be a dynamic value */
>  	.max_no_of_hqd	= 24,
> @@ -130,6 +132,7 @@ static const struct kfd_device_info carrizo_device_info = {
>  static const struct kfd_device_info raven_device_info = {
>  	.asic_family = CHIP_RAVEN,
>  	.asic_name = "raven",
> +	.gfx_version = 90002,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -148,6 +151,7 @@ static const struct kfd_device_info raven_device_info = {
>  static const struct kfd_device_info hawaii_device_info = {
>  	.asic_family = CHIP_HAWAII,
>  	.asic_name = "hawaii",
> +	.gfx_version = 70001,
>  	.max_pasid_bits = 16,
>  	/* max num of queues for KV.TODO should be a dynamic value */
>  	.max_no_of_hqd	= 24,
> @@ -167,6 +171,7 @@ static const struct kfd_device_info hawaii_device_info = {
>  static const struct kfd_device_info tonga_device_info = {
>  	.asic_family = CHIP_TONGA,
>  	.asic_name = "tonga",
> +	.gfx_version = 80002,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -185,6 +190,7 @@ static const struct kfd_device_info tonga_device_info = {
>  static const struct kfd_device_info fiji_device_info = {
>  	.asic_family = CHIP_FIJI,
>  	.asic_name = "fiji",
> +	.gfx_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -203,6 +209,7 @@ static const struct kfd_device_info fiji_device_info = {
>  static const struct kfd_device_info fiji_vf_device_info = {
>  	.asic_family = CHIP_FIJI,
>  	.asic_name = "fiji",
> +	.gfx_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -222,6 +229,7 @@ static const struct kfd_device_info fiji_vf_device_info = {
>  static const struct kfd_device_info polaris10_device_info = {
>  	.asic_family = CHIP_POLARIS10,
>  	.asic_name = "polaris10",
> +	.gfx_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -240,6 +248,7 @@ static const struct kfd_device_info polaris10_device_info = {
>  static const struct kfd_device_info polaris10_vf_device_info = {
>  	.asic_family = CHIP_POLARIS10,
>  	.asic_name = "polaris10",
> +	.gfx_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -258,6 +267,7 @@ static const struct kfd_device_info polaris10_vf_device_info = {
>  static const struct kfd_device_info polaris11_device_info = {
>  	.asic_family = CHIP_POLARIS11,
>  	.asic_name = "polaris11",
> +	.gfx_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -276,6 +286,7 @@ static const struct kfd_device_info polaris11_device_info = {
>  static const struct kfd_device_info polaris12_device_info = {
>  	.asic_family = CHIP_POLARIS12,
>  	.asic_name = "polaris12",
> +	.gfx_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -294,6 +305,7 @@ static const struct kfd_device_info polaris12_device_info = {
>  static const struct kfd_device_info vegam_device_info = {
>  	.asic_family = CHIP_VEGAM,
>  	.asic_name = "vegam",
> +	.gfx_version = 80003,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 4,
> @@ -312,6 +324,7 @@ static const struct kfd_device_info vegam_device_info = {
>  static const struct kfd_device_info vega10_device_info = {
>  	.asic_family = CHIP_VEGA10,
>  	.asic_name = "vega10",
> +	.gfx_version = 90000,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -330,6 +343,7 @@ static const struct kfd_device_info vega10_device_info = {
>  static const struct kfd_device_info vega10_vf_device_info = {
>  	.asic_family = CHIP_VEGA10,
>  	.asic_name = "vega10",
> +	.gfx_version = 90000,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -348,6 +362,7 @@ static const struct kfd_device_info vega10_vf_device_info = {
>  static const struct kfd_device_info vega12_device_info = {
>  	.asic_family = CHIP_VEGA12,
>  	.asic_name = "vega12",
> +	.gfx_version = 90004,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -366,6 +381,7 @@ static const struct kfd_device_info vega12_device_info = {
>  static const struct kfd_device_info vega20_device_info = {
>  	.asic_family = CHIP_VEGA20,
>  	.asic_name = "vega20",
> +	.gfx_version = 90006,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd	= 24,
>  	.doorbell_size	= 8,
> @@ -384,6 +400,7 @@ static const struct kfd_device_info vega20_device_info = {
>  static const struct kfd_device_info arcturus_device_info = {
>  	.asic_family = CHIP_ARCTURUS,
>  	.asic_name = "arcturus",
> +	.gfx_version = 90008,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd	= 24,
>  	.doorbell_size	= 8,
> @@ -402,6 +419,7 @@ static const struct kfd_device_info arcturus_device_info = {
>  static const struct kfd_device_info aldebaran_device_info = {
>  	.asic_family = CHIP_ALDEBARAN,
>  	.asic_name = "aldebaran",
> +	.gfx_version = 90010,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd	= 24,
>  	.doorbell_size	= 8,
> @@ -420,6 +438,7 @@ static const struct kfd_device_info aldebaran_device_info = {
>  static const struct kfd_device_info renoir_device_info = {
>  	.asic_family = CHIP_RENOIR,
>  	.asic_name = "renoir",
> +	.gfx_version = 90002,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -438,6 +457,7 @@ static const struct kfd_device_info renoir_device_info = {
>  static const struct kfd_device_info navi10_device_info = {
>  	.asic_family = CHIP_NAVI10,
>  	.asic_name = "navi10",
> +	.gfx_version = 100100,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -456,6 +476,7 @@ static const struct kfd_device_info navi10_device_info = {
>  static const struct kfd_device_info navi12_device_info = {
>  	.asic_family = CHIP_NAVI12,
>  	.asic_name = "navi12",
> +	.gfx_version = 100101,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -474,6 +495,7 @@ static const struct kfd_device_info navi12_device_info = {
>  static const struct kfd_device_info navi14_device_info = {
>  	.asic_family = CHIP_NAVI14,
>  	.asic_name = "navi14",
> +	.gfx_version = 100102,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -492,6 +514,7 @@ static const struct kfd_device_info navi14_device_info = {
>  static const struct kfd_device_info sienna_cichlid_device_info = {
>  	.asic_family = CHIP_SIENNA_CICHLID,
>  	.asic_name = "sienna_cichlid",
> +	.gfx_version = 100300,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -510,6 +533,7 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
>  static const struct kfd_device_info navy_flounder_device_info = {
>  	.asic_family = CHIP_NAVY_FLOUNDER,
>  	.asic_name = "navy_flounder",
> +	.gfx_version = 100301,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -528,6 +552,7 @@ static const struct kfd_device_info navy_flounder_device_info = {
>  static const struct kfd_device_info vangogh_device_info = {
>  	.asic_family = CHIP_VANGOGH,
>  	.asic_name = "vangogh",
> +	.gfx_version = 100303,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -546,6 +571,7 @@ static const struct kfd_device_info vangogh_device_info = {
>  static const struct kfd_device_info dimgrey_cavefish_device_info = {
>  	.asic_family = CHIP_DIMGREY_CAVEFISH,
>  	.asic_name = "dimgrey_cavefish",
> +	.gfx_version = 100302,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -564,6 +590,7 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
>  static const struct kfd_device_info beige_goby_device_info = {
>  	.asic_family = CHIP_BEIGE_GOBY,
>  	.asic_name = "beige_goby",
> +	.gfx_version = 100305,

I don't see Beige Goby in the Thunk's gfxip_lookup_table. I think it
should be 10.3.4. Please check (I'll provide some useful internal links
offline).


>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -582,6 +609,7 @@ static const struct kfd_device_info beige_goby_device_info = {
>  static const struct kfd_device_info yellow_carp_device_info = {
>  	.asic_family = CHIP_YELLOW_CARP,
>  	.asic_name = "yellow_carp",
> +	.gfx_version = 100303,

In the thunk I see 10.3.5 for Yellow Carp.

Regards,
  Felix


>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> @@ -600,6 +628,7 @@ static const struct kfd_device_info yellow_carp_device_info = {
>  static const struct kfd_device_info cyan_skillfish_device_info = {
>  	.asic_family = CHIP_CYAN_SKILLFISH,
>  	.asic_name = "cyan_skillfish",
> +	.gfx_version = 100103,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 8a5dfda224bf..eb4eab9a18e3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -196,6 +196,7 @@ struct kfd_event_interrupt_class {
>  struct kfd_device_info {
>  	enum amd_asic_type asic_family;
>  	const char *asic_name;
> +	uint32_t gfx_version;
>  	const struct kfd_event_interrupt_class *event_interrupt_class;
>  	unsigned int max_pasid_bits;
>  	unsigned int max_no_of_hqd;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index ef992dd2da3a..6043b6e7b390 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -478,6 +478,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  			      dev->node_props.simd_per_cu);
>  	sysfs_show_32bit_prop(buffer, offs, "max_slots_scratch_cu",
>  			      dev->node_props.max_slots_scratch_cu);
> +	sysfs_show_32bit_prop(buffer, offs, "gfx_version",
> +			      dev->node_props.gfx_version);
>  	sysfs_show_32bit_prop(buffer, offs, "vendor_id",
>  			      dev->node_props.vendor_id);
>  	sysfs_show_32bit_prop(buffer, offs, "device_id",
> @@ -1360,6 +1362,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  	dev->node_props.simd_arrays_per_engine =
>  		cu_info.num_shader_arrays_per_engine;
>  
> +	dev->node_props.gfx_version = gpu->device_info->gfx_version;
>  	dev->node_props.vendor_id = gpu->pdev->vendor;
>  	dev->node_props.device_id = gpu->pdev->device;
>  	dev->node_props.capability |=
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 8b48c6692007..073567a2e0d2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -78,6 +78,7 @@ struct kfd_node_properties {
>  	uint32_t simd_per_cu;
>  	uint32_t max_slots_scratch_cu;
>  	uint32_t engine_id;
> +	uint32_t gfx_version;
>  	uint32_t vendor_id;
>  	uint32_t device_id;
>  	uint32_t location_id;
