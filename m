Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74058CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 16:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F8610E105;
	Fri,  7 Nov 2025 16:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zzkNUmeg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8171E10E0F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 16:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWQsnyCegYSR1RkiIwnfIa/UiLES0jEVwTnv7tswuKHtijqdMJ7qX0b5bqc4k4p1IxMc+GLeSaz8uiH6tF/cGqRUckriV/Q0314vmMVFuAbhb9xAgQ/wvZT13NwPWychPuMHwk9nzVjSPq4I5lDb5xt2QY4NoeHNN60LoXl+gjW9ZKNkwnVULlzlWNnwA9FK7aWZDum2h3GTsCI1H0vZZmIC+ywiVPE+cUNbUm7qXdPnR9aPyT47u41ELtIe9vHhnbRxzedCZ42cgN2l7GdnQSNHSY5hnAQyJvrl7NlWAg+QmgrNpCgBlwj3KMNjR6fXxK64BFmB9Dl+5S46tKqwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjpoSU/5EqEJVnkgbJDcR0abe7yNOxs1ovdA5x5TzaQ=;
 b=Lho0cNyBT0vMSaKw7c+DrAsSn+A2OrDLFn8YDPu4lxx+MZYe70z5KNwsuQxdprvdhp/j1raPO4ezSg9tq+qIF1tJyV5uH5P/+B9Y1HY4Jx0hPS9a7rG07Vs4ztRpMnCT4La418giYUkJizwIAkKRlM7IWvZCVkEEMMxigeXcW5JZFZUcRtXujZqOKRmKTkReJFQSz4HnYx5AZqEBaa9UlAuSLXb3Jg0vcj5H1TkdrBWde75zw6TX6KS+h0pm/JMkNC32UFEO2v4XZKK/AKyzYIg+kuRJj+5nO6I7JNs/38KSmi6+YzeL3Mj85xw6dE6u2MzCgL0T/Od8mco8+QU5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjpoSU/5EqEJVnkgbJDcR0abe7yNOxs1ovdA5x5TzaQ=;
 b=zzkNUmegEqJthnEEr1iHWYuVVeFebZxnkYbDlLUEcPjVL7q+phwOpJzly634AauxpBbJld+EqhefZKVVppjeQ68skIpMJAtKoj9b4vp43sTVQ8Q9B91TuQHPg47FeHShHAii0ijopXCPk2g5mVH/jxDnz4YFHeVrJw782RqJID8=
Received: from MN0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::32)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 16:40:50 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::1e) by MN0P223CA0011.outlook.office365.com
 (2603:10b6:208:52b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 16:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 16:40:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 08:40:48 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 10:40:48 -0600
Received: from [10.4.12.116] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 7 Nov 2025 08:40:47 -0800
Message-ID: <1e56118e-a71d-4d3d-bda7-022bd8731c7a@amd.com>
Date: Fri, 7 Nov 2025 11:40:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add kdoc params/returns in dc/link
 detection helpers
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Roman Li
 <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Harry Wentland <harry.wentland@amd.com>, 
 Tom Chung <chiahsuan.chung@amd.com>
References: <20251107142934.3058349-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20251107142934.3058349-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 590d2933-2a5f-4191-1758-08de1e1c6914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkJEbHFUVUJxQzgwdGxhcnlmcTArRDcyL2oyK0oxeTBHZktLdHVMcDl5d2Ev?=
 =?utf-8?B?NmQwMWFVVC8xbmhlMWRzM0pKelFTdytYN1NCa0p4QXAxckFPelU0RVRrdVNX?=
 =?utf-8?B?OW5veHVYUjh4bnJEZVk1dE1YeVdwU1o4NkQ5dGhMMEhlSXdTRlBLek1pRFRX?=
 =?utf-8?B?NU5pZi8zQ0orSlJuRXRleHJ4cXRaS25ITUphY3hRdmlzc1NnUVZBWHFWckRU?=
 =?utf-8?B?WHZvVzNUdzFlUGJ2T3ZaU0RiclBhNHJ1ZTdZQ1ZPMFNjWnZwZC9sZ2JVSWhW?=
 =?utf-8?B?TFQxNjY1YWpaTTR1RGxiWmtjT091MS9JZ0E4MVdWcGdVdTFvQ25Ra2NWMzFn?=
 =?utf-8?B?azZndmR3MFRhdFRwSVc1WmI0dEZ0K3lic2JJT3FIbXlRcis5dXZldCtGZW9H?=
 =?utf-8?B?ajMvVGRMeHlneTRxbU8yazRmeVZpeWtzRlYvYmVFTzA1SFhCL2hIWE56UGZ4?=
 =?utf-8?B?WEJCd01jTjdHa2NDYVp3R0o5ZmxVV3QyZWNOV2YvZWNWTTlGY09Hall1WjVy?=
 =?utf-8?B?bHBRVEdoSDBHdHdFSEl3S0I3bE1ZMWtQNkovZ2lPL3hZWUd1dkZEak1PclZY?=
 =?utf-8?B?ZnJMbkt3RnBtaFdEYlJFbytxS081QmVxMWtmNjNWRDZDbkNVVmlMOUlCc01B?=
 =?utf-8?B?STZsYU9GS3Vma1RneXE1cFREWkVxcWl2MHlsRmF0ZXl2dkkxcUUxeHFBcWpa?=
 =?utf-8?B?c3V5U2p5cFRJMXc1NlREZzczbm1IMEpaQkFUVkR4SFQraWM0cjhKakxoSm42?=
 =?utf-8?B?OXZOL2RnNlpDYlFoRW1DZEViNFlkM3c0L1NJNFRpeGhjRWVLbEs5V2tyZDdI?=
 =?utf-8?B?cjBHbkV5R09HalhoYkl5T1lkNDVZWG1HeWtuTGRZMkZidDluazIyMVduTDRm?=
 =?utf-8?B?Y1UzWGNFaGFnRzdSdURuNkMzdGh6OUVnbi8ra3Uyd0RZYllaaGhMTy84WHRj?=
 =?utf-8?B?cFROMFhxeElpSk93ejJTczNzQW8rRUNrY1hmaG8xaUFuTmp3dU9nVE1RU0pM?=
 =?utf-8?B?eEdpWVdRaWp2VTVodEFZcGtjL212T28wMVlUQ0JKNkVyVmt3YkRKclJabWlp?=
 =?utf-8?B?UEFVRW1MZ0p4VjFva0lyNUJJR3pKQUJvTTdENFRNZERoSmJjQUZ1S3Nyb2o0?=
 =?utf-8?B?TzNwa2I0QXUwZjBuSlBpMHluQUxIVUYrR1FnZWZrUTdpZUEwYUVua21jck9Z?=
 =?utf-8?B?bC9tWVVKbk12WG9mVWNJVk96UG95L3AxRWxyaENrZit2azQ4cnA3S2laZ1Zm?=
 =?utf-8?B?bTNDRElETFFzcm9qN1NlMzR5TjFGMG50T1cydk90N1g4aGpRVjBNMStESSsy?=
 =?utf-8?B?UDV1MlBDendnWUV3aGhzOTVaTHhSOFFxS3lCOE9WUGVJOUkycEVOS1dkS3dR?=
 =?utf-8?B?cEt3dWtzOThWWDYyWVovbTZKZ0krSUdwWi8yMXAwTzExSHFjNkJORGRFazNT?=
 =?utf-8?B?cVN0WDFuM1pkVnZJa3lUZklRUVNETzlIMVF0QTN5R25TZnk1ZUZZM0M5bDlZ?=
 =?utf-8?B?b2I5NVhCZ3JEdjh2aTFoSS8vSWlNRFZqeUxZc3N2cGxXeHBSamN6SHZuamVp?=
 =?utf-8?B?K2hQMTU2VlFod2NmUTZEbzNJb2JycGVYVU42RDBrcEtDQURKbzhrTDFTeGNj?=
 =?utf-8?B?Qk5RTU1PNFk5WCt6dDc0a25USEtjY09zYXNLbTBqVXVrZVAxVDlTVFJLZFpU?=
 =?utf-8?B?cnRWemhJT2JlcEk3V1h6MlJmZko1SGpBSVlydXBBNjcwWFNZT3o3a1lEbUx5?=
 =?utf-8?B?SWNYOU9NYUVHcTFMdGFseG9aK1djY091SDJINlFiN2NmSTNNQlZGMTJ1RUl6?=
 =?utf-8?B?WGthSVp0bzFsOVBtWEdydmhDQW5aOUwyNjhzRTJEbjNjcWJET2FCSEdaSmox?=
 =?utf-8?B?Umdpalh0NTF0Y29zRjkweE45YnByVUd5clZuT1BuZmJ4Z0xSRHRaWURUY3Yw?=
 =?utf-8?B?OHZTR2l5YjNyMDdsQ2pNRStSQlU1NEVkK3JpbGlxWTNpMTFsOXdOclJWTVFq?=
 =?utf-8?B?dkZYVVZMR3BMeDNwazZpMjM1em5Zc1duRmdvWTRLbEdWQ0xESTVHR1lQSUdt?=
 =?utf-8?B?WHJrSHk5V1g1RGRDT3dCTlQ4ZmsyOXc5M3FXKzkrZ1c4aGN6VXZ2Rkd2V3hI?=
 =?utf-8?Q?/EJU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:40:50.3583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590d2933-2a5f-4191-1758-08de1e1c6914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>


On 11/7/25 9:29 AM, Srinivasan Shanmugam wrote:
> The link detection helpers in dc/link/link_detection.c were missing
> kdoc annotations for parameters and return values.
> 
> Fixes the below with gcc W=1:
> ...link_detection.c:872 parameter 'edid_header' not described
> ...link_detection.c:890 parameter 'link' not described
> ...link_detection.c:914 parameter 'link' not described
> ...link_detection.c:1355 parameter 'link' not described
> ...link_detection.c:1355 parameter 'type' not described
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../drm/amd/display/dc/link/link_detection.c  | 23 +++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 5d287874c125..d163360a2bf6 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -868,6 +868,11 @@ static void verify_link_capability(struct dc_link *link, struct dc_sink *sink,
>    * Evaluates an 8-byte EDID header to check if it's good enough
>    * for the purpose of determining whether a display is connected
>    * without reading the full EDID.
> + *
> + * @edid_header: The first 8 bytes of the EDID read from DDC.
> + *
> + * Return: true if the header looks valid (>= 6 of 8 bytes match the
> + *         expected 00/FF pattern), false otherwise.
>    */
>   static bool link_detect_evaluate_edid_header(uint8_t edid_header[8])
>   {
> @@ -886,6 +891,11 @@ static bool link_detect_evaluate_edid_header(uint8_t edid_header[8])
>    * Detect whether a display is connected to DDC without reading full EDID.
>    * Reads only the EDID header (the first 8 bytes of EDID) from DDC and
>    * evaluates whether that matches.
> + *
> + * @link: DC link whose DDC/I2C is probed for the EDID header.
> + *
> + * Return: true if the EDID header was read and passes validation,
> + *         false otherwise.
>    */
>   static bool link_detect_ddc_probe(struct dc_link *link)
>   {
> @@ -910,6 +920,11 @@ static bool link_detect_ddc_probe(struct dc_link *link)
>    * Load detection can be used to detect the presence of an
>    * analog display when we can't read DDC. This causes a visible
>    * visual glitch so it should be used sparingly.
> + *
> + * @link: DC link to test using the DAC load-detect path.
> + *
> + * Return: true if the VBIOS load-detect call reports OK, false
> + *         otherwise.
>    */
>   static bool link_detect_dac_load_detect(struct dc_link *link)
>   {
> @@ -1351,6 +1366,14 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>   
>   /**
>    * link_detect_analog() - Determines if an analog sink is connected.
> + *
> + * @link: DC link to evaluate (must support analog signalling).
> + * @type: Updated with the detected connection type:
> + *        dc_connection_single (analog via DDC),
> + *        dc_connection_dac_load (via load-detect),
> + *        or dc_connection_none.
> + *
> + * Return: true if detection completed.
>    */
>   static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *type)
>   {

