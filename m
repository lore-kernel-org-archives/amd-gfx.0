Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8324BD2F009
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 13:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B0110E126;
	Wed, 28 Jan 2026 13:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="km0elROC";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E6810E126
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 13:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqXZ7dF8hj+ZTGU+fYfwZywW9vNNiHhN+WdaSgs+jB0UTptXEBrZpHn7gQqVQfPsH/gWCYGMEMzNrs9OqcTB1GAdO01EFLKG9mqx/e23PCtu7AvFUIFvjffVuoQTNSz29Aw7jwyUQe3rQ3Nfo2xwEIcRi5P2/pSgaieUhOM/GjJ/sXOcRfRC/4XCGhz/BC8FwOEQ5jdn4vl5S0Qh4YB621OoUwEcAHRhR3quPSmqzyrCIpFFEl2EgRPHn9mFCnJt4QqTxhSrAjC4Omm8rO5BAFsfo0IJH82ozj14ATCNqR8ocbPOtwKEyhKZFWlBxXurpIyIfGT5ainRph52Puudrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI8K+IKOEQ9CgRUMfpZOpLk3flk2K2P66xjj8V/dFFE=;
 b=HwEfKuhBswNsJsAD56NrIigHEPpWezzjrfV99ODxvJeZwB5G/cjrtVN2ghaiFNtwBpebe4NUKXkfxmvVkLSeu7qT9bMNsgvcqkZ39oB1OxUVQpGkfeTs0EszuZA8zScvkwIyUdXI/jmBadUW9m+DXBpEMWLXaZJ/iebgjb6hq0KVeWDUuJ72aYoFlGPm7aDtazLm5u1QhPu3Lya/fC8BDi49T0KPD1d+02+Rh27Qy+4zusGSaFYot5pZ6Xmv1dU4MpSsXr5Pnlv1WlqLggGQVV+buVbxWHZGfmmXZm0oFxoP8X6tU2Q234PoYGQ1yDmO+m2nyYYXpBWY+xE/MeZ+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI8K+IKOEQ9CgRUMfpZOpLk3flk2K2P66xjj8V/dFFE=;
 b=km0elROCidBVtwzc+plEyFcUyB1KUCCylqn2McMJC3h5GNEs/5A9OYRjs6PftAd5o5nne85hOHQ9so4a1t5EHLmYFBMpsBTNmOmuX4S9GVl4MwGj01Y+/iKq/KD2AbuQZ1jSV4uxbeLCS3Kpu2pSzlOeN/sz4iGyj88HC+lZpNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.16; Wed, 28 Jan 2026 13:57:33 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 13:57:32 +0000
Message-ID: <5cbdede5-2f37-4960-b8b9-261e7e2e3152@amd.com>
Date: Wed, 28 Jan 2026 19:27:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: ensure no_hw_access is visible before MMIO
To: Perry Yuan <perry.yuan@amd.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260128062315.2848821-1-perry.yuan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260128062315.2848821-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0071.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 3849ca9a-5a15-4ecf-d2c7-08de5e752ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlFoU1hqZ0dJUlNuL1VHQ3JBRjR1Z1BTZHFTYjhFYWRkTGhyc0YycVdPTUVv?=
 =?utf-8?B?WGZDby9EYVdMQTNJRGxIcTc3dXRHdXIySmhnY3RNZDVPZVM4VURSeDNOMUtU?=
 =?utf-8?B?Zm96eXRSdmE0VHVlcU1SK0cvNWF3RkxxeDE0VCtMNEtkRG9STUpjRkFHZXNr?=
 =?utf-8?B?Smo4cHpMTHk5cEh0aUoxdEs1MFk4enBGWFg5WFRlTTVYdlNsQk0ydndsUXhT?=
 =?utf-8?B?WVk2aEZrbmVtS2NMVW5QSEY5Q2RpQU1CS2JvUVpOS2pub0YzVXNZajlGSlli?=
 =?utf-8?B?Nmtaa3NEcFJ1SXBpOWJRNWRPOEJOLzVuQklsejQ2dzQxNDZIUmFRdVN1SjM3?=
 =?utf-8?B?b3h1NXRYci9xSThGZlljeituZkZJNXoxMUt6aVFrVWJuVENUckJlVjM2UWpu?=
 =?utf-8?B?dWpqaU1Xak5yeXgzQy9oWWJTRmFvODhuSGZoVlM5Z0c4aGo2Z0htYnVPaWln?=
 =?utf-8?B?bWt2UzdHSndBWkVhVEJRS290dHRqVkl3ZkFuYndhdWRhbi9PUzZCZkZOMnY1?=
 =?utf-8?B?TnE4cXk5WnFEYlowUUdYWE1qKytINytBZUQrR3NwTkdzbnBOSHVJQS9ObHAw?=
 =?utf-8?B?cFlMTWdlTi9FNzh0b2FaVHdkTm1TQzNYWTRvcDFtQVZ2T0Nid3Bjb09wRVdB?=
 =?utf-8?B?TEI1VjkzMHZHY0VScGJNWVh6ZUZ3cTlrakl3TTd2OE1sRlVQa1BXZERxcXNU?=
 =?utf-8?B?blgyVUVjVGJQbS9lUDRYOEUrY0locitwbW1XY25qaWEybDVKQnVyYk9QdFQy?=
 =?utf-8?B?SXp2OFRZUzhtVjA0Yk8ySlVXOFZSOXMxMDQ0YlFsTHh2SmxUMVNydFMrWlo0?=
 =?utf-8?B?TE9kcC9GdURLbWUxQnJNYkxWZVJwc09GSVFRcEhUaldLMmlnYzZVZnRpUFBy?=
 =?utf-8?B?VzFSajlaVmJkL3lXbFFlaTlZQU5aZlNsa3pTTEc4MVRsR3RDYldTbGUzQ3Vu?=
 =?utf-8?B?REgxZlZySmlaem9ZUHQ4R1lyUGF1Z2lwMHVkY1NrcUNZRGxzRi9GVjJzOVd6?=
 =?utf-8?B?VWtiQkRUQ0NHc2JLSG1kTHNNRm9ZZHhESENyZFIvdWZGbFlWRkgySTF3d05r?=
 =?utf-8?B?enFTRm56QXFiV2k2dHpiYVpET1dieWlBWHVtQi9HYlltM3hGNFRvR3pCVnpE?=
 =?utf-8?B?ZTZUQjZoK3pZa292QkxhdnE5dm1CdDhhY2Fqb0YzdFh4YkJObmlUZFRuK0x5?=
 =?utf-8?B?TVR5Q3ZsVGcxMitoVmYzaklIUGtLMkdFN3R2Zlplb04zUS92bTJ2eGFJMThD?=
 =?utf-8?B?NG5OODNtOGNkTVNaSHJBNEI4aHdVRGFXc3JranZ6Y1dkTGFWVi8xTDFkV1JY?=
 =?utf-8?B?cHJoUDd0cGZXd1pjRGlHUTFSS09MbFB3SnJOVkEvT1ZBQld0c053alBETTlE?=
 =?utf-8?B?QnhyUFAzSW9ka0pGTVVFTncyYVJIcGttemNhN0dRaVc4UGRvMWppcEc2bGZT?=
 =?utf-8?B?Rnd5ei9pRlBnVzdhNWthKytnRGJqczBselN3clN6SXVLbFhCNGJyQ2g1dmln?=
 =?utf-8?B?MFBGcDNTVGowSUEzaVp5eG9SZk5RNG4ycXZ6QzFPSi9yNnVDOUplOHhJRWl2?=
 =?utf-8?B?Vk5WYTRJMXI0ak43ZTluTDJ2MHpHTlFnQUJtTjUyUE84M1ovV2s0RnFDVXBv?=
 =?utf-8?B?MXZkTzFCTHYyZTFPRTlycDYrdXdIc2k3VTY1TkI0eWw0RVZxN3FZWlMzTFBp?=
 =?utf-8?B?V1llWndMYXhFRkp4TjNESVdhd0F2Z2J6U1dKZDc2TmQ3cUV0elhCU01kSW9v?=
 =?utf-8?B?Z0E5aE4zOUVqOEp6enNPZW5YZ3JQNFB5OEdlb3ptL2NFV3lVbFlzK3ZOSkhs?=
 =?utf-8?B?azRWL09WS1JlRDA5Z3ZyWFo0UFdCa3pETzhjRlRFbVFicm5hT0kzVUpvdk5Q?=
 =?utf-8?B?NGJCVFFwUnN6UysxREkrcmdkM2VYZ3MrRlI0c3RzVmhBd3JBWm5nQmc1ZlVx?=
 =?utf-8?B?d0FnM09tVGluQ3IvTnJXMVB6TXNrR3lBeUU5SU90M25NcngwZk9JMkhCWFh3?=
 =?utf-8?B?SUlhd3F6a1pKalJJK3VDT05Ld0lOS1ZWektXR2ZDL0U1OVYvbEVwNGIzaS9P?=
 =?utf-8?B?cjNkeFlpT05yOXNUZ0QxRXB4TWhyZ3BKNTYwdEFKbFZSMmhSTDA0RzM4c2ls?=
 =?utf-8?Q?KIos=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmxONFBjZThCTGNyWkNrVVhhQWZacVJxM1BHQXBFWHZ1Z1N2VmpwZHU3enBj?=
 =?utf-8?B?VW9qRXVaL0Y3SUZrRGdrWHcyY1J0ZHZrMTFvYlh0WFhPV1lMbnhlbVRhNSty?=
 =?utf-8?B?SXZhMUlDSk5YV3h6OHBqa1F1UTdSRjB3Rlc3NEloU2ZWNkpYSUhnWVhvR3h4?=
 =?utf-8?B?WWlsNFB0RkRjRUxET0RKd2JKeFBXbGp0ZTNYdURsWHc5UDVEZm1Sa08ya0hw?=
 =?utf-8?B?SnF0SE9USzFGeXU5SXRyaWlYdGtUZXkva3dIOFhWSEJnajJrMVpNYkxoN1ZQ?=
 =?utf-8?B?VW5ROTExYU42QmNLVmNUVEhDRG1LdXEwTUZjbFNvNGplYTBCM0VKY1NLaHRB?=
 =?utf-8?B?UERiTkUzNTZwSHVWNXZwNnpoSDdNSVViNWd4MDdoK3RTTDFBSFIxWUF5cWtr?=
 =?utf-8?B?Z2ZyZGtick9UMGNyd0VkN1FCS1A4MDN0Vmo0UFN0cHlXeVpocHVkaVlmc3RX?=
 =?utf-8?B?Mk5hWGlkSUxVMnRSanZOZVFuaS9TeXR3K0c1akowNEEwVEZLWVlFMWFuYzha?=
 =?utf-8?B?SXRXOVR4SEJYOXBiTEQ0V3NQTjNZMEllM3pXYytzanFIYTdhYzgzS09KVFZX?=
 =?utf-8?B?SFkyL0c5c3B5ZTJxMDJoRGpXa2U1dnpsaVY5VkNMU1NLTFZLSUZhV2FCM2Fo?=
 =?utf-8?B?Q2FaWXZXYUp1K2syaHV1emFYV2VZQXdEN21mVnFlL0I0V3dveGdUQUV6YkhX?=
 =?utf-8?B?YUM4U0xiK0VUaGlaZGh3bHFXQTE4K0JvZlg5L0lSeHlFVXdoeHhFdEM3bVRW?=
 =?utf-8?B?aGc5OE5TK1c1Zm9UZlBDbWhvVE9mMUFKRW9lMFI4S0s4QS9idXBhMHo0RkRR?=
 =?utf-8?B?MG83NStjdkVrUHZyUEYyRTJPczJIMFU5TGtXV1V3RHpsck9jWWdrWGQ4SVJr?=
 =?utf-8?B?TkdjYTBUUHNaUFYwR0t1dm1YNUFGM2dlZUtYVlRkTzFQMkpHM3V3cnJiYjZH?=
 =?utf-8?B?bjJTSEhVdGwwZEdrMmlWd3pUUWV3b2IxUHZITExrZE8xNmN6S3lyYWNJWStV?=
 =?utf-8?B?WTRLbzR4b2Jya3AvK0ptcHdTeVRaL2sxcThmS3dvclNtTUNtYVRhOFBraEdn?=
 =?utf-8?B?TW12b2RETlVhOFBFTnB5ZUphbHpLUUJROEZmbHZtMWN5bnFOMXdjSjdYRzBl?=
 =?utf-8?B?b2tIcjd6SWhYWDlpclA3anVpUGxHTkFDWE00eTdzM0huMzdhTit2N3MrVW9z?=
 =?utf-8?B?Mzdtc2twdDhWTlVyY0NIYzgydGsramF4T1NGYlRnTGZYRUFucWhBSVNZNTBD?=
 =?utf-8?B?YS9ySkZIUUFkeUtxRDBlc1A2TmhxMTV0a0wwTkdqNCtFejNadGtlRnJlQ3Zu?=
 =?utf-8?B?bEJhUkNvYkFJanpaMmFPN09saGF2VVBIa05MQW9MN3I1c3BMcHY0QjNIMjNG?=
 =?utf-8?B?TTJPS3hhdkFqVStMZkhHOEk0MmI3UXF3L2NFMGhjYkpvQksrVzFBVnc3SVc5?=
 =?utf-8?B?RmVXOCtlNGtkZE9zNHRQc2gxdVZxUW15YmtKMCs4TzJuSFU1UHR6UDd6Y0pz?=
 =?utf-8?B?WXRXNFdjb093cklnZEJDWUZiRlVxaFFsWFRiVzN2TXBYWTBmOEVudFJ2UG9I?=
 =?utf-8?B?UXd4QUFSTFJQWndHUS9zSkdqUWJkRy82VzBodTA5VWNQKzlWaWtlUkRJRTJJ?=
 =?utf-8?B?dzJPWW1FU0ErdUo5MUROa3JwZ0VKV2NGSHg0aEhCMENoSFlxalRTQzdVMHg3?=
 =?utf-8?B?WGpnMy83VEl4L0VPVUxMSjdPemF2WDlVOC9jTEtnUDZaNVdlaWVROExvVFBy?=
 =?utf-8?B?WHVEaTZ2OFdiQ3c2YldJVFJiSGVpaEQwOUVnOVQ1UG1zNkpJQ2wzWDZWaGZY?=
 =?utf-8?B?c0hVelNobThJcmRIQllWSjlBdDNHWmRSVGxFODlsRFkvbTlLREtQVEdwUTFT?=
 =?utf-8?B?NEwxM2ZYVjNiSFVibWFETzhVTkg0ZEppcDlvUTNmZXNnMGdaL2V0WDVHTUVD?=
 =?utf-8?B?cVlvL3hHd0RoSjVua01iVHlGUXdqYVQxaTZLWStNSnYzVXlwM2RlWkJaM0VG?=
 =?utf-8?B?ZnZkelVhR1ZVeThhTEg4cjJ2Z1NHMzMwMFI3TW5kYkZNQlVMRU5sVlFuUXZk?=
 =?utf-8?B?SzhMUFNDWHBPVHNRWTZsZkhNcDV3aXZYekthUEt0bCt1QVNlN1J5MFloT1h4?=
 =?utf-8?B?eE1wTnhaT3FQNitHYk93aVlqL3NGV1gvVTJKMHROTHNlZVlpc1YrZ1BkL1hQ?=
 =?utf-8?B?OHRzY0NOK3Nrd0M0ZEttUHJZazZwY3FQdDlWUmpEOUc0L3l4NE5mMHh6YmNX?=
 =?utf-8?B?RlJaMG5qTUN2YzdIK0p4U1p5aHRMa0dCc2cza3pQUzBjUHNSM2pKYXdSVmRX?=
 =?utf-8?B?K1B0U05TWFllUDVWaThhQlVnM1JxUnF4SHhFZ0p0MFJTNHFTaCt1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3849ca9a-5a15-4ecf-d2c7-08de5e752ea9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:57:32.4392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE8cKFNQAfPr03e2bPenHwtFkANC1W1ydcs613fwcTQ6kzFEnfmIGP3MzHzKe99s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
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



On 28-Jan-26 11:53 AM, Perry Yuan wrote:
> Add a full memory barrier after clearing no_hw_access in
> amdgpu_device_mode1_reset() so subsequent PCI state restore
> access cannot observe stale state on other CPUs.
> 

Just want to reiterate that this approach masks the original logical 
errors within amdgpu.

For ex: this is one such which would not have been caught in the first 
place with shortcuts like these.

12caf3b76150 drm/amdkfd: Handle GPU reset and drain retry fault race

Thanks,
Lijo

> Fixes: 91ae0045130b ("drm/amd/pm: Disable MMIO access during SMU Mode 1 reset")
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b2deb6a74eb2..e69ab8a923e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5735,6 +5735,9 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>   	/* enable mmio access after mode 1 reset completed */
>   	adev->no_hw_access = false;
>   
> +	/* ensure no_hw_access is updated before we access hw */
> +	smp_mb();
> +
>   	amdgpu_device_load_pci_state(adev->pdev);
>   	ret = amdgpu_psp_wait_for_bootloader(adev);
>   	if (ret)

