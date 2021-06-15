Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E032C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5494A61446
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5494A61446
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C361898C6;
	Tue, 15 Jun 2021 10:35:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FEE898C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 10:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JywTZQ6dmXdq+zBACowFMYnEPeCxQ6nPV6EVlgb/KbykwyZtLY3vpORV4Z4evlmPzJU+cLLH2sKT5JO03YbWI7SmClAAsb1f3S3A6btcZAupz8cL2FLD8FoV6QfzYH99eC7zjT1ps1YahqDSMUfx2fm/qPwpkkWBsPwYcZMETgjRuXKNptnu8yV3YnjStW2TPd/TlxcsDjqU/LesE0Qm8NH6oyMVrtLdopoDTpDThEn4awGdPc5fBmSLBMCPxRDQsyfNnSS5As97TwFZG3V3s6IUmJtOtJ8N8dtHXGRc6UbC1nPsyoMeaQfa5Hm9tg3/eRTDphkw9inCT+TFEa7y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6pQeIot2awlNQb4UUJXjjY9W3GPNcjMpj6xPYu8J6s=;
 b=TggSONXmooaLqHJoMosLONJQAvDHL7+NWWts8NaQJLycISRDQ508mCif4LkSGciyayxIADJQDTRD1CiXAhfodUaq+feeqyGkn87an+9LVVbhukb5FxosXjZNSqmmhW6SuSjYxrhbvSTQAolg7cQlVrNfsjSgHYmuW8OJ23t6KdBqnQ8BgojYXDyD2ljuDM7JNL95/uobkuccVCQ6rmfNmiEHr4xFeye/c8zOOnx8KjwXJFYhpdzBGm1D1oG1P1LJEUPGuHIO0u7tiwLc5/Ie042vxqVjdCNyNXG1KvP9BfHNFAMkaKp0o6DlLB+VNofSnH+OWw8hOPniqNwaXr6bVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6pQeIot2awlNQb4UUJXjjY9W3GPNcjMpj6xPYu8J6s=;
 b=bSpCuk+NwTtoCRyXxQnKRdv0r3Ry5nrbl4GM94DmMW+w4dnv6dgNVRM+zugc9B6BEtbIngLt4nAR93rADYkNU1JRN7jwctyL6gQzByp2mvcxviEvg1SuhWTwoYDDZSrhP+LC3KIRIkVBMYcJ1y1Z/g6WKF7TDiREokgNjU7w8U4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 10:35:35 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 10:35:35 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: remove unused variable
To: amd-gfx@lists.freedesktop.org
References: <20210615103325.28587-1-nirmoy.das@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <0037a67f-d0d8-16e7-b174-721249600aa0@amd.com>
Date: Tue, 15 Jun 2021 12:35:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210615103325.28587-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f25:c00:389e:e320:3bf5:cf96]
X-ClientProxiedBy: PR0P264CA0079.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::19) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f25:c00:389e:e320:3bf5:cf96]
 (2003:c5:8f25:c00:389e:e320:3bf5:cf96) by
 PR0P264CA0079.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Tue, 15 Jun 2021 10:35:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fc2104f-a3a2-41b3-a4de-08d92fe94f51
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5389BA9A492A4C7D9B33FC368B309@DM4PR12MB5389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyNYKIZe+9ifjyfQTcstvZPP+8YPm4aCq8OQ+4PZjyFSaZFwaQhBNg/sz2G/9YkdTEMULni4Hz6/7bRV+N9sC0BpwbyBlsy4b7/4G7IEgegriczgQo9muv/vx1bHl97OtaHwxcX5zWb69JqMgaOdW2UAK4IbpxxJWfDbtFnVkornRteGU1FOGlivBEJomXsZl1Lj7M7X1ADTR48svH5wRzdZMkKz8xFEdvKyKJRMQxz0eFyU9RR/3n9K6fgOZWfpgLHZ4y2UYB00RufdKB6Gmk676Lp+6bQIP2y0n9yygc8fXEZiutU2B+7FnCa1Gs8h0o1Lh8wN8O9tmmaDUeVgNo04cz2dzPzy/gSbB7/caE7+O80oSTwK+a2+yjg9QF9bwQ98O0ElCMbWpqt/pC2PYKKi35ACl711XTD+/PPvqxR4oBlhtRMk6CC0BZ+JgRUZIuam0PQcl080j7V2vsFdUbFxjV/FAFG4xlpC1j7J/NMkQ/Ajbx3Xhrh0clZ4YNobilafAf8OVwmBRA/haoq8bL87R5FLwzuCWV2jXlKEKe2Un68/yzRtGJvRDNG8a3lNA63Wv+5L5XlyOZ7uaLV99VvNPWJuFCgoLHD5z7Rfgx6yfopvGwZ1QPlbp8sI5WUXlePEIULYkbvNyLPiMeZ9Tpp2yRpB4nXvY9HDPbgQNC9+H+1hqE1IKG8A5dYNV2xH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(52116002)(86362001)(2906002)(6486002)(36756003)(6666004)(16526019)(31696002)(186003)(2616005)(316002)(83380400001)(31686004)(478600001)(66476007)(4326008)(5660300002)(66946007)(53546011)(66556008)(8676002)(6916009)(8936002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFiNVRGRmRTekk3NkVHa085VDN6TDFEUzk4S0hoTkxxUUxvN3dLNEdBT2ZT?=
 =?utf-8?B?WDBCazR3MXUrZ2R4K1FpYzZDUnNQUDUzVFFzQkE1b1RDYWdDWnJIUjFKSUY5?=
 =?utf-8?B?eW8zNXZpTW8rVVh0NzN4cmY3UEUzbDhSZnhTb29mU3lsMngzbWVjSFRmV1RU?=
 =?utf-8?B?SUpDSUZWWHprNUhiLzZlamFFMnlGenppVC9lK0R1Y0w0aUZHTUFpdDl0eXk2?=
 =?utf-8?B?bUIyNWtvbkkwUmY0Nm5hVUpFUFd1SWZVSmFFOW50ZWw2UVZ1Rm1ZV0hoMStC?=
 =?utf-8?B?YzVwWStuaE5hbEtCb3puSG5FMVZSYzMvdVpaeVYvRmpwOUZPSk9JV2lma0tp?=
 =?utf-8?B?S0RGU1VIbGc2ZDd5Sy9FRjF5cG9pQzZNbDVzd0NaVno3cnlXeWtRRnJRL3VO?=
 =?utf-8?B?OTRGaWYwTUtkajNrZUtDVmFLMXEzZnVjc1dHZUZ6MjVTMlRqR21GTEdSWkFQ?=
 =?utf-8?B?T05oczQzUDQ4cXZoaEhiWE00NWlTWHNXaGhWYkE3ZVAxY3cvWER0aFN2ZFNU?=
 =?utf-8?B?MmF4aEVwdy9ybldMZFNXU0Y1cm9XZ1o0TlgvVkhpTTBwdGw3Zk9WcElZU3VT?=
 =?utf-8?B?ZmRSMkJVaEU4K01LeVBpYUxHOVZmbmpKSGdxaUxnZHJuL05xRmNrM1BuWlF3?=
 =?utf-8?B?SldpT3F1L0RYbzdPYWFvMTVuSmRLMEg5dEJrbi9MeXgvTGYyUnZIamVhbHNM?=
 =?utf-8?B?TFQrQnZuZmVFTUVWeU9kbXNLRjJlR2trTTdFeGx3OTJvUlBZeThmT0dIQzNq?=
 =?utf-8?B?eTVQTDlMS3BGN3QvZ3ZSRUNsUkk5SFEzZ0c3a3E2elFwV013alZXZTBxblhH?=
 =?utf-8?B?OXZNbUdaYm8yaGRtblhJQm9kYjJaL0wzempIMHFKTXp6bWlLbVovRHkrNnIr?=
 =?utf-8?B?djFSemk0Z1RBRmxBZUtxMFlLb0NHYnE2TlBraG9YcHBCaEVWVEhEYzZud2hQ?=
 =?utf-8?B?d3NPamVkZ1U2RDljbUxHSk1GUTYwd05VVTYwSm85ZjlMVUVQUzdjb2VGWUJ6?=
 =?utf-8?B?VEF3eEgxdzFteG41UGwxcFE4NHZpRjJqMmcvd3NiSFJSZE5kQm9rclpKU0Vn?=
 =?utf-8?B?K2lPaEdyb1BSWUVyWHZOR0RVcmxqSi9Kc0ZEdzYxMUNzZlg1Y1BIWTlJMWU2?=
 =?utf-8?B?bmcwMjVmd2pNcWpDMTYxcE1PTWlSV1c3ZTFtcEpDRG9hN3YraWZMVXlhbW05?=
 =?utf-8?B?UjNvOFRxenhhRE1PeGhKOUhreWV6ZEd5cTgrVUlUaytLZVJwanVZM2s1cG5N?=
 =?utf-8?B?TE5QMUVlenY1Ry9HeU9zOEw1TElVclY4UURVUEZmSUF1NTlKbjlzQ0RsVStH?=
 =?utf-8?B?aVhuS0xtamplWkJKK3BxUW5SdElseGhSa25qV0VaWnRaaHVtOVYzbWVBaW9q?=
 =?utf-8?B?dXF3bnRjVEF6cVpJN2EwbnlXV3F2MlJ1RmRIeFEzdnU4OVpCTktMZU9Ed3JR?=
 =?utf-8?B?RXZKT1hjbDNZV2tlaGlFR1NiTkN3UGNQN3dDYnBJa05UNnVsUk40N3BWSFZV?=
 =?utf-8?B?RTR4RXI4VW1QR3BleWZJMjVxZVJ0R2dQa3pQWEF2N1JjdzNJWGVSVkRWeERG?=
 =?utf-8?B?M3BWOTlnQnpVNUExNkhvVndnUFNFSUpScE1zM1hFMEhaZ09sdnFkQ2doQkkv?=
 =?utf-8?B?YUZwOFpqMzhZWm5NRkxMRnd5eUIxWkdONHp0K0VpNnZWaHMramJ2VzFOWG93?=
 =?utf-8?B?S0liL1RxR2pCV2d2VjFLdU1qL2pWNHdMSjhmV01wSDFObEIyOEVzM2ZOdG5N?=
 =?utf-8?B?TUp6YUUvT0U3YmlsSWs2VEdsRE9UZFRQc0laNEo5MWtTM0lJZmxhTlBEbnpY?=
 =?utf-8?B?VHBGT01WNEg3UzVNTjQyK3FBSHZGOFFRVVVPUWRvdk51elladklIaGF3Skg1?=
 =?utf-8?Q?WTwMfMnzpwvcu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc2104f-a3a2-41b3-a4de-08d92fe94f51
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:35:35.6113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIwGbrAqZ/cAn6iEgPkos2hIVZxjCy0KcTPwib1nGoHMSfq+jrimZ+W46rX8EB0N5BlYPxw3UsFpmN3GkVs5jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
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
Cc: felix.kuehling@amd.com, jonathan.kim@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 6/15/2021 12:33 PM, Nirmoy Das wrote:
> Remove it.
>
> CC: jonathan.kim@amd.com
> CC: felix.kuehling@amd.com
> Fixes: d7b132507384c("drm/amdkfd: fix circular locking on get_wave_state")
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e6366b408420..539212039876 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -997,7 +997,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
>   {
>   	pr_info("SW scheduler is used");
>   	init_interrupts(dqm);
> -	
> +
Please ignore this extra space. I will push without it once I get a r-b.
>   	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
>   		return pm_init(&dqm->packets, dqm);
>   	dqm->sched_running = true;
> @@ -1674,7 +1674,6 @@ static int get_wave_state(struct device_queue_manager *dqm,
>   			  u32 *save_area_used_size)
>   {
>   	struct mqd_manager *mqd_mgr;
> -	int r;
>   
>   	dqm_lock(dqm);
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
