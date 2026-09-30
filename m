Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3C0CA5FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 20:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 274EA10E28B;
	Wed, 30 Sep 2026 20:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TcKwSxFJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16FBF10E28B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 20:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmsHlZujRLBAUEGXYw0obQrm7P2io8qBO2kt5cDhaM6TD0uutSYM4gbNrUhq7m4qvHF7JxwB+jswLaNRUt9a/TD7/vMJNjU4y+SoBuIu2zu/tF+H5FNhyzSIgOWQ+7uoVNI0p/155vkmEgtwHvo9aTRWmN7hr8KQwIOexuq3berRscF9dHy88ZQUXb2eouHEEmr8djglyST/C4uhVoCyAxJL7N9S2OF4gaYLANDCXyQO0/1z3/Tofss3Dpf2iHgjQM+wMNznt5VWhEU10077vpU5m1z7qmkK6D+0ijaRrEWnuiw2+oVgKkmTQMkbzEDgigsMnttC2KZn33O/re008g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBjtZHsyrJxmFfpaN0rOI8PhFmlyOgHK32zLAgYErI0=;
 b=FofqN1k+Kzs1HiCvqW8fyBt3Ac9ra4LyDLtHKIIPK9blLDFVg0kkjYLnD8rHTFckjm2Xgs+OCWPMbyfhcukVfgZik14t3szRSGvU8LIzyiFO5GOZKeMf22zP3k5IqzMSjDnQRZpiNmMl+/2LRf8dpbZpYLnmrH8VeT185Q4DnBMZIKg97bOkfvv71+0q0bwR458ahkYfmTHpJ339aA6JUIXyOqcTgwRXsV0L9lRkJT3BV9VXeFdOiw9mUg5LEk0wP7mOkxwc+GgICGSQ9sZnqaP3cxqRTZDLHDLSOle6aootP/L0D3R7OKgcm69jFPT7Ca24k9ddLkg3zR1MBbBdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBjtZHsyrJxmFfpaN0rOI8PhFmlyOgHK32zLAgYErI0=;
 b=TcKwSxFJECLdGyil4eSFKSYdStrtL/+3iEzZjPyp3hdYBvJ6MNcPPn4dscIqwQcCTKjm7+t2XU81pApoL8ohVsuyKslJKojf5w3r5/3XpsuLCDdOJSGM/zxly0QyJJLHURSPDMxZtEIPdi7UXBCFzOouMCLm0GmqM6yhk/fCiSU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 20:01:48 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 20:01:48 +0000
Message-ID: <80f5cb1c-d92b-49a1-a34a-a918e952c956@amd.com>
Date: Wed, 30 Sep 2026 15:01:46 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Sashiko enabled on the list
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::7)
 To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 6959e974-1f2c-4f5e-ed15-08df1f2da91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: n6KZsvIo9XEXgfoyljapDPhf7jX8VyoYgq5Xg7IZGtRKGPWc7ZMOCTTlViIlD1RX+QX1fJ3HdL+EkCGOCG+EGu9zZANhXBhX+DLetHGtritRNxJSF0ApB/7joF+42VwX+gEG96CVGo2LlmPOPTUYMtD1J4LcWXzdz9Q++G2020kw7JVnG9b5xkKuaHwjVwaGHDwt+oQ9zA/g9wy1AneUNx0fg22lD2TpvKy8WBPmCprgMK3Xpbv8WtDGiJvj2FOy9GrPwqjpe1dUA+jFFkDj+Kv8wgacO+2WZK9RF4Y9AiJ8vN0G+qTAItD06RNn+VLrHQrTHl8uz5qTBJ6c9ul28wqAu3BaBadUp/ebOThhErIjJg2kn7GIcfpzbC0V/E8MnYa4dAwTETkTrStb/OLX3d09FBWBlEApricR97JtrJr1o2em6kQ/+TlyPOggCKkAYju5GYS8CLzkPaAlilit5d0n8gHD0Mi5iYV4V+EM9BQjJPwEpjNQ3m2BqTNTnXCweb9rRKLbNYEFm0N6xpzI0LedsYJhOVvqlJsBT/nqLK3a68tgH/LZ2Pjz9B/dtzVg3fZZF/O6NVqWFaZe7BCIGhX4u75dqvQM/INYrwvF6r0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emhCRmNEZ09GR0p3R0cxcXV6WmhmZVVRd3BIWHRremF0TE9PZ3dNY2Y1YWFz?=
 =?utf-8?B?emNmdVc3d1pCMmFMVFFRSW5Ud0NhTVVEenpXMXZmMWhkR3J3Q0VpaHcxR0Uz?=
 =?utf-8?B?azZ5bjVGaFR0SFhHNklDVHExU2FQZWZVUWZWVzFIQkdKUjd3TEEzdGtWcFBh?=
 =?utf-8?B?WnhUUmZsUmJDSGlwRFkxc1krZFh2YTV4RngyQjhmaVB1b2g1R0dtZ1ZUbWRa?=
 =?utf-8?B?MkQxb3ZidHo0RnF3ejVJZk1ZdjV1SmlzS0xIaEFwNDk5V0hZa2t6VDJ4dG9X?=
 =?utf-8?B?c2paR1U4RXVGTU8zNitlU3ZwbTlEdXRCUHl5Z2dFZ2pwVlNGbERWQU96dnVV?=
 =?utf-8?B?bmdidWtCZ2phQWdCTnlrb2tHenBBR2orSk8rbFdjcy82VFk3U2NLOVZKY290?=
 =?utf-8?B?QmVTSDNVcC9oVnZRR3NVSE1yZkxFejlnTVlVRlFyK1lucXRFTFBhb1FWeC9v?=
 =?utf-8?B?RnhDajhNNEJ4UW8zY3dVVlRlQ3dEM0g3bm5nRzNrcHBLWDloRUxMOHpOcjd4?=
 =?utf-8?B?cXc5WnQyY2F4TGcyZ20wMEZySDFOeXVpNTAxY3IxRXFLN1VFSTRjUUxUZ0xK?=
 =?utf-8?B?NG9raXJibWpiQmRrUTJ2MEpyaGpjNGpVYVZSS2h0WmVTaWd6b3hVSmZJaWZ5?=
 =?utf-8?B?LzRXOFNSeU1PUW1xQjBTb2cwdUtYdWdkanpYVEtaemhnekp0cjFTb2JQSytW?=
 =?utf-8?B?N3NCMSt1RDhHcHhYdmRQZFlWa0YrVWs5cFhlaENYWFpIdmNIWFVQOWdKRHBa?=
 =?utf-8?B?SVFCL0lvZ2dlMkpuV3lFVDB0S2tDN2hUMTVmZEtvUHE5cUVad0J0RGtXSVFU?=
 =?utf-8?B?QTFuUEVNS1FuSC92YXdYOU8wM1FkMmsxL3dYUUFFWlBjTDBCdmVNTityaDVo?=
 =?utf-8?B?UFRjQTlKUXdsNHlBZ2xOakFIeUUrNWdwOFdpbVR0T2EvQU5uU1BxRVVYektn?=
 =?utf-8?B?NXBRR3g1NEllZzN0Q3cyRWhWN041bkUzUzBRMkVXUjJPYndhUFdEcXd1T3hU?=
 =?utf-8?B?NHRpK1ZMQmoyOFFUN05ld01UTCtybVMxMjQ4VDZVL1dOZlBwTDBWYXEzOGdF?=
 =?utf-8?B?Nmk3em1IVXlOMU1pbWd4cGx4UXU4blNjV0hUcnR0MWlockpaN3Rrd1NWbFZw?=
 =?utf-8?B?NlhjaE1CUXBoTUZvWHVnRHQ5SFZlbnFxSXVaZnZtdlc4Qk1oM2ZPdW1yVWxG?=
 =?utf-8?B?TEE2S0VNUjZ4S1hROUdaZ0hhZVBLK2JCOEpRcmcrYldOM2J0RDhmMzlBZ1JY?=
 =?utf-8?B?ZFRHYVVab0FSekxuUXJ5QTVhRXdPeEl1c3N0RlJGV2pYUjd6dlRPVkllTUlx?=
 =?utf-8?B?a3cvdlNtcUoxVlltN3J6TXlpbUxtMkxubkVLbUE4UGVsdml3SnZEZmp0YVFi?=
 =?utf-8?B?eG1JUTVnS0lHRVFrZjExei9laytlV2w2N0wzUDU1VGVmcEdrb2EyOFpONlpj?=
 =?utf-8?B?VkxzR0RXTHVyZjFYb2UrMEdkZnpwTnJ1a0crVjRTUmhYNlNrRWtLRmIwSEkv?=
 =?utf-8?B?Y2czT0xkVURsYXJiQ29WWlhGMHpGeXpIcnBZamJMOE9peXRYaXlCTHlXRzM4?=
 =?utf-8?B?aUw4L0VRUmh5cDhucHFBZmU5Qk1Fd0JnM0hXLzErY1BqL3AxM0N4WDBDZUxq?=
 =?utf-8?B?aWwvYzl6QmFRbThwcWdxNzJyN1dkbUN0WVJCN3hJclEzWEd1QzJlT3M3cVU2?=
 =?utf-8?B?bjVML0ZxVHpvNUhGMmp5YWsxMlMrSWxLRUxLcGJ6SFdkK3o1UzJlb1pGdGJ6?=
 =?utf-8?B?RkV4VmFManU2VExPMDVvUGVBTEFta21uaC9FSHR2ckJ0OC9lN05WKzEvdHpk?=
 =?utf-8?B?TWorOGp0SUMvb0o1dEU0cEFrNEp1V0ZhaUZjRnhySzNtNkJxaDZ3V3BNQWgy?=
 =?utf-8?B?NitNUmFXRmlCSUtwNlhBbytFNW1wK0ZCSklIOHArYWhTUlptT3J5Z090K1JE?=
 =?utf-8?B?Mjl3djdDRVVIcU9PUXpuWEEwbFRoUTcwZGhTakNEOEFJNldZaHVGWjc0QXJH?=
 =?utf-8?B?ekRvcmx3eVNERTQvd3p3UjBUeW84YXRLbHF0MnVQVEU2SUgvcTRscW13akNu?=
 =?utf-8?B?RitPTW1WaVhxcTE1QURzeDhCbFFQNHhPSVVrZ2VER3VLMFYwbDN3RVY1ZEM2?=
 =?utf-8?B?aDhsd0NLTXlodzJrMlF6a3k2ZFlmWUVIb3FWWVhkaGxLUTFOUm5CWWdNUUJt?=
 =?utf-8?B?UExlK01OeElXL0pDNHY5akg5SGNVeU8yQ2kzdzJzanBQc05xeG9maXlXUU9K?=
 =?utf-8?B?bEtWWWhVRjBNZTZhdXl4ZnJtd0ZjRUVkdW1JVi8wRFpWWTFrd05LVXdKaUxm?=
 =?utf-8?B?b3JuOEtRdnlhQi9iNUJjMUJSdXF6MDREOWxyVUxCNlFCTnNKY2NMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6959e974-1f2c-4f5e-ed15-08df1f2da91c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:01:48.2436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifNcMOLn8WNtIEuLT1H31LsZcmst7c7bQ/HYkViAhFmp3539oPYP10XQKp6nJh+4uFTdko2Kdvh3+zHKWX6uPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
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

Hi Folks,

Just wanted to let you know that Sashiko has now been enabled on this 
mailing list.  I don't think people automatically get emails about it, 
but when you submit a patch it will get analyzed by Sashiko and you can 
review the feedback here.

https://sashiko.dev/#/?list=org.freedesktop.lists.amd-gfx

Thanks!

