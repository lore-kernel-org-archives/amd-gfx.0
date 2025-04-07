Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77931C3601E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 14:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B95610E486;
	Mon,  7 Apr 2025 14:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3npA6GhJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D9210E47B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 14:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqLS+eM/hm4XUKYuBcg3dOxi6UjNkMrAQZDxMMTp9QpuFk2/cshB69qYwcwB+o+8+MFD4EGWptW0Zfi9pgUBErihoOWkcX+nuS5ZiFZ+FXh9JcQ4EAx13077sspuDdOEuIZWKLcJaVnBqPA/vZQCxpNLyaPtXyy6cUDeJ1iIKlPZ3SnbERGNtS3nyifeGGCswCszYgRc6BBfYLtNxz7IId+VdJzD24mEjB5MeCNXNXUbFh1Mnvm5sY4y/5PrvKEgbFyssPFd8qvt4ZpnCKmAQ33ZlSP2Yv2sMAVALsfaizuIWZunQNWe0l7AhKPtTUqT6o7h5eu7eMk0rO4sF2sG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YzuQiLmk/fswZ1eDy/2VCvbHiOcF0HTWlSthBwJ4r0=;
 b=szUZ8eb5HUXfStjn8YsCOkiDcBR2y/y780VS45yK27bbYnwvhxULDa2ggHwcsMkKMXzNEbkrjGY7Mi1fqnazrJK/hEmnoF0YyboBxw8GKY1MOtmhB6SSAoB4K++sXiz6elgLuoFRzMsD8QmaoNNyvrePrkK8a1RTFUCcPNGAnc17RJjjWHzExS83w8iR+d0OFPmMbCjERQ+V2eXqwqw1YQ5Gm7eK9XjyLuUItKoQPTIcif/GU61whde7cOBF6YD40/Nm5LbKiFzufKX07Q9TEPuthaJaqUptuMNuqDINgGi7QAQLIplJTxfbMNgUfUQ2goS/a4aEPbpDlZy3eQJqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YzuQiLmk/fswZ1eDy/2VCvbHiOcF0HTWlSthBwJ4r0=;
 b=3npA6GhJHU+p5DeSpZIlNrh6NExRUilzssbv4qO6S3r21zSybSMfs1DMWdJ5SlwTFi0MJZJIA5Ub8FlQR3O3iU3yAHO7XoXJJddMBUR3mfI7jxwb98+9L1/L0Qvr6iJ2/tsuhPfow2jTJDHwqb8jihuCQsoGDmKmsMsxFnktWoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Mon, 7 Apr
 2025 14:00:13 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 14:00:13 +0000
Message-ID: <bda75ff7-a09d-4117-b7f5-1762f95048cc@amd.com>
Date: Mon, 7 Apr 2025 19:30:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx9: dump full CP packet header FIFOs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
 <CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com>
 <04635121-c8ca-42ba-a56b-20357702c929@amd.com>
 <CADnq5_OZCnYtfMPKN1CH4nDLEJsfpQvnSxLPJE=EjH9C=N_vJA@mail.gmail.com>
 <119debd2-b6a0-4d7a-87ce-7b80486d95ee@amd.com>
 <CADnq5_MuPL07pTRatWXsmLaWJUVqJZ8ptKyv85oQTapDS68d7w@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_MuPL07pTRatWXsmLaWJUVqJZ8ptKyv85oQTapDS68d7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::32) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6cfc3a-31d5-4987-3056-08dd75dc841d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1dYa2tOV1BTMnBCSkgyVnhodmVyTjZ1ZkZpUVF1Z1padEhxeHZwaXZmWFpq?=
 =?utf-8?B?SjZwdE9NL2VkY2poTkZtcGxFUWRVZ204SGRQbkh3bDN4c2FTZW9zSzdHWlRH?=
 =?utf-8?B?YmZ5cUt4b1ZiOGtraEpDV3pObndsT1VNWHlSN2wxcVoyb0lMTDAvQ2VIclZO?=
 =?utf-8?B?RGZUbG5EU0tXWXE0TXV1Nzl6VWZ6aGlndzUwanBnWXBpTTRQNFBuV1JKT0FC?=
 =?utf-8?B?ZW5ObFIzVHprNDdTRkVFNGFmLzFqOXpyeVV6dzcrUUY1UWlIVUVkOWxZUW9Q?=
 =?utf-8?B?WGFRTXU4dlcxSmgvWUZ4bnRmSTVmWmpRTmtQWTNFNFVhaGRpc1ZDODdJaGpj?=
 =?utf-8?B?VEF5VEpvZVFESU1TYnlRcGFBbDRvSnJSdldiOEt0czFzSXRxUzRlN2grZjBs?=
 =?utf-8?B?YjQ3ZzJrcHkxalNNTUlpYnozMFU5WmRSRUk0WFZJRXM4bnBDNkdESlFwOWRh?=
 =?utf-8?B?YnlrOHBnU3B4dDZNV3oxUkQrNXN4blNHTUtvV0xLTzMrSFpBTm1oQXQ3Z283?=
 =?utf-8?B?a1NWWGhhdTRqT0NHdnhsVk1SRitpRm9seFJrYXRnR09OMVZSUVNCakloVzJ2?=
 =?utf-8?B?L0c0MG9xQjc3YWo1NFFHQUlRbTdkWTA0cnJKN1c2cDVld2VpUmJVeDUrODJU?=
 =?utf-8?B?T2tuV2tHOWpSQ2dqaTBhMkpnSXEzZThQWmFRSkRSN3M0bm5rNzhtZk43S29U?=
 =?utf-8?B?OVpZQnpIWHFDbjBsUjlFbDJjaTF1UzJycTd2anVZbVRYTmFlSEVHdGhrNDBD?=
 =?utf-8?B?anhwT0xoNXhCWHk2VmFJcFc0d2N1dkh1OG1jUnNuQkNqRFp6cUFJbU1ieWR0?=
 =?utf-8?B?ZENic01UY2cwU3dWZGJqbnJWWlNheG9ZYjVPUDNvVi91d2pMcEJtZCs3NjEy?=
 =?utf-8?B?bWVkQm9qNGJnTDczUm13eHlmOC9wZVNueHN1bVdNdHVoUHVncW4wRTJ0MVZ6?=
 =?utf-8?B?TjJKN0xLZitBZ0xUeW5PdkRndkt6VzZ1cDJmckFSbzhYQU1LK1lRWUpYdE9L?=
 =?utf-8?B?RWUyN0VLd3BPdWpZSEx0ZWZoSjFhQUNLVmxxUWJYZ3QzRTYybGFtSW1XYlNw?=
 =?utf-8?B?VmpzeTVDdG1HSGsyT054UUdrZWpzRWhnemw1QWtWc3c0WmJsZW1BSzhEZ3dQ?=
 =?utf-8?B?QWZabDZ5Yk9jcUdWT1N3eXBwQUd5a2xhUWg4WlNLZGZBaDRwa2JUblNETXJT?=
 =?utf-8?B?aEtzOG1aQnlpUGU0ZnRuTG5sejlwYTFUbUFiOHUySDRsbXlIMTJOL3p2bzVh?=
 =?utf-8?B?RDE2ZE81Y0x5QXB4T2tBcmtrbkd1NGg1NWQ4d2xHVmsrSVRRYWJCclJwVVNS?=
 =?utf-8?B?am1EbGNXcnBGbW5vczZtSm1WdVByeTJuZ3JFcHRzdUdHWElKNDZoRmk0Qnlw?=
 =?utf-8?B?d2REQ2dRLzB6dUVmaGc2RU9ZNm05QWJ0eUNZN25SelRTNzdzR29tdGdLa0Mx?=
 =?utf-8?B?UHloNjMyT04yZmwxYjd3c3VrQVlnNDhpUDlaTGdZSU0vdDk1Qis2VXVJU1Mx?=
 =?utf-8?B?Q3FWdW4zZFdaNmxHUEs4VnNWZ0U3bVpiUEZXTDU0MUt6d2NnWEV6S0VRTEM5?=
 =?utf-8?B?VFlISi9WeXlmWW5RSjMvLzBvR3d2SHpmdVFZSGZIVFJyd2dZVFVpMUJ4OTZI?=
 =?utf-8?B?bTg0TjJnRG5GNXlXdGZaWXhkTEJoOTVyZmNQY1pTMGFwUzYrSHU0VkswUzRy?=
 =?utf-8?B?bGpLK2huTS9md3JzUzZVZHZSaGFYOFpzbTlGRTlJdDFyanlxSklGZ2pZbFRw?=
 =?utf-8?B?QW5zT2p4Rk9WRlpsUnBpVVU4QXd0ajI2UUo5QjNWZzViUllmdXBZOHpiVFlU?=
 =?utf-8?B?TGowQjFhVWdoZFRyb1JjRzVxSjFHM2tSbTRzOC9OQVBMemlZVkZUeFhic0l3?=
 =?utf-8?Q?tHkotj4kOLJ8e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVR2RDlDWmdpKytST24zd25PcFVYQURURVN1WU1CMzVkclcxNGRLNUQyWW8w?=
 =?utf-8?B?dkdRYVliRTI4VG1KRGswdFYvWTVmRlUxVC9BY28va2tHeHdmREMyNWltYk9W?=
 =?utf-8?B?ZjBDZUZPVUo5V3V6Y2tSbkxQemgralFteUNLRmZrTVB0QlBGNktnS09Ea0FI?=
 =?utf-8?B?ZWVFK01kUkF3cG93bEJCcVhwVW1XOWg0RXoyazk3VUlERGJSdU1VWWMzTElM?=
 =?utf-8?B?MlhtUkhhaDFIbE5uZ2x0RFJ1RWlvZWY0Sm5iUmZQNHZoV3d3RFVmTGN4L3cy?=
 =?utf-8?B?dG5wemJPZHJOU2JlVTFKZ3VmMWtFbThXM1pJZEthUGhuT3dwbmpLcUprd1ht?=
 =?utf-8?B?MnFTSFlMemxEWWkrVnlyeG9CK1E5RTFxT2xCK0xMQ2RFck9mUlR6ckpFSkN0?=
 =?utf-8?B?dkRlYmcvM2wvTVl6Y1NjTXVkbDZIOUkwMGZ3YjVQeVFpUkw1V0gwQVBrT2Fo?=
 =?utf-8?B?Q3AvVzBlQ2dyaWZ3aFVHYVZLWWJGSU4wSmZLS25LNXpEZDlWNmY4TWtNdTdv?=
 =?utf-8?B?S0tzeEJEaXRybmRjZzRvZExOaU5QYVVyUGdZcW5iTElkUVF4K29TckJpR0Yv?=
 =?utf-8?B?Q1VDNG1WRFNGSmFUOUtQZHVtTzRtUHVJUVAxeWNpdVVFMHBMdTZUYktxQjQ2?=
 =?utf-8?B?OVh1eGdXT2VzNzQ2SG1VSWcyTlZYSzRIY1M5N1lEdVJNMFlHK2I5Smc4cElD?=
 =?utf-8?B?dFo4czg4Slh5QUtzNkRPSFE5OFNJOXJlVlc2bmNpYUpRR1lLVSs1OFlycFkr?=
 =?utf-8?B?dUUxeTFrcGh5YmFIZmhwaGQ0bzBDbHhmR01kMm1jUW9zSlJJOXQvLzZlR0ZY?=
 =?utf-8?B?Z05MNWtHMTZBZXoyS250TmZ2Y3RRb08rczlQbThMRFN0OTNyMHhFbnZ0ZnF0?=
 =?utf-8?B?cVNWLzBiaDJteTh0em5maFFMV1NLVEh1V0w4NUNPeksrbnpDc3pHQmJZa0NC?=
 =?utf-8?B?ME1hVjdqMXhPSXAvMXc0NW92dXlyMHpteXdvQkVNSjA1WDZJUG44K2EvNkNn?=
 =?utf-8?B?YVZ4bjBOamhLM0J5WDVwUlVweTFGdDA0eGlXNTl6N1RWUHE1RHl5d0pFY0ZQ?=
 =?utf-8?B?Y1ZBK1hCR2UwWS9KOENtcElrcUN0K0NoVFV3NC9KT2tqL3lEcEQ0WGV4VU56?=
 =?utf-8?B?cEorNStjTlJ1bm5qclNzVEtKaEM1QkdMcGZnVEdHMDFwYXV2TVhia0Q4MktJ?=
 =?utf-8?B?bytoL2puYnBFQTFoWWZ4dFFpbUZlWXd5Q2JjZnNUSzgyUGhQMEM5QUJOZzJL?=
 =?utf-8?B?Um94U2Q5MHhvVnJHamtkRlg4Qjh0UTJBNUdiNnFVM0lGSGIxRjJaK0hjVngy?=
 =?utf-8?B?SVRSYjlFMDE1WVZSVmt0bnZuOEhnZW9oRjFQSERlTVpnN1RESDlMVUpFZ0FP?=
 =?utf-8?B?TmpXQUo0Umh2S1BJa2czSHd6RVRkREtVRGJEbHkzL2c1eUcyYUg0MmdsN1lR?=
 =?utf-8?B?WVZROW42c2MyR2tLOTQyMXlkUTQvNEplYWxtZkRteXBOTC9YYnlyN3VYL2Ex?=
 =?utf-8?B?MmVUUlowZ0dYeGlIYVM0VjQ2VmRSVkVaR3lEcmVNTGFQMEdoa3RvZS9hZS9o?=
 =?utf-8?B?bytXUFhJVFdzbXRrcmFyTVNMMTF6WXBpakI2bmQyLzJxT3M2czlkb3dNejR5?=
 =?utf-8?B?YUFNRHlhQUh0d3U3TEEwMnlkOU1lN3JJa1pCQjl4dTV1eGlqWDFEdFArSnpp?=
 =?utf-8?B?U0RwYkVETzJzcUF4MzhoYW5wU216SURSdU9pNFpJbDQwL2NjS0dKZnVURmdN?=
 =?utf-8?B?aXdXYnVVdUxPVGVUNlRRRGZNSkdhaG5tN2xWZ3VlYnF5RG1Ram1HZ2hsUlVs?=
 =?utf-8?B?bVpJRGQvcGNKN1pNRzhkTFNHOVdWc0Z0MGJDNU5OdEUxaXVBQkRlNWFrb05D?=
 =?utf-8?B?Wm5PNDZ2YjNncCt4bnYrQ2dyd0ZCeUF0VUxmaFVhZlM1bDgvcnIwbFVNNytS?=
 =?utf-8?B?OFZ1VS83K3hzZ0xQVEtjV3NQYms0NEt2VWJpdDV3anZZS2xoKzQ2OEtjUFVV?=
 =?utf-8?B?TlFMQlo0dlQvUlQ1YzNBQi9EeitQbWxhV2c3YTQ3VDJRSHNYRWFNaCtyRU1i?=
 =?utf-8?B?dDBGNmtibGc2bjNCamdsWEZIU3BGZHpMTThsVGZjYU4wNk0rNjFWUDh1bDdV?=
 =?utf-8?Q?nWtQN5un/KC86Cjhkta7A9Sdl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6cfc3a-31d5-4987-3056-08dd75dc841d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:00:12.9391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWhY3HnUuaen+2zRyE75o1A2xj3yye4NNlnHXxCwlxne72iDie19Ky0xmWAKSzH9dtPwqj3TZb2zrx1UpUmDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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

Thanks for the insight Alex.

Series Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/7/2025 7:15 PM, Alex Deucher wrote:
> On Mon, Apr 7, 2025 at 9:27 AM Khatri, Sunil <sukhatri@amd.com> wrote:
>>
>> On 4/7/2025 6:26 PM, Alex Deucher wrote:
>>
>> On Mon, Apr 7, 2025 at 6:14 AM Khatri, Sunil <sukhatri@amd.com> wrote:
>>
>> On 3/25/2025 1:18 AM, Alex Deucher wrote:
>>
>> ping on this series?
>>
>> Alex
>>
>> On Thu, Mar 20, 2025 at 12:57 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> In dev core dump, dump the full header fifo for
>> each queue. Each FIFO has 8 entries.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 62 +++++++++++++++++++++------
>>   1 file changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index f4dfa1418b740..64342160ff7d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -225,17 +225,36 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
>> -       /* cp header registers */
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>>          /* SE status registers */
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
>> +       /* packet headers */
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>>
>> Reading this register in a loop will give value of each queue or we are reading same register again and again ?
>>
>> The register is an accessor for the header FIFO in the queue hardware.
>> The FIFO is 8 entries deep so if you read the register 8 times, you
>> can dump the full FIFO.
>>
>> Thanks for this information. I was kind of thinking the same but dint know it works directly and need not to change the way we read like setting grbm etc.
>>
>> for (i = 0; i < reg_count; i++)
>>                  adev->gfx.ip_dump_core[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_9[i])); With above loop arent we reading same offset again for
>>
>> mmCP_CE_HEADER_DUMP,mmCP_PFP_HEADER_DUMP and mmCP_ME_HEADER_DUMP 8 times. How are we making sure we are reading from different queues ?
>>
>> The me/pipes/queues are indexed via soc15_grbm_select().
>>
>> Alex
>>
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP)
>>   };
>>
>>   static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
>> @@ -277,6 +296,14 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP)
>>   };
>>
>>   enum ta_ras_gfx_subblock {
>> @@ -7340,9 +7367,14 @@ static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer
>>                          for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>>                                  drm_printf(p, "\nmec %d, pipe %d, queue %d\n", i, j, k);
>>                                  for (reg = 0; reg < reg_count; reg++) {
>> -                                       drm_printf(p, "%-50s \t 0x%08x\n",
>> -                                                  gc_cp_reg_list_9[reg].reg_name,
>> -                                                  adev->gfx.ip_dump_compute_queues[index + reg]);
>> +                                       if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
>> +                                               drm_printf(p, "%-50s \t 0x%08x\n",
>> +                                                          "mmCP_MEC_ME2_HEADER_DUMP",
>> +                                                          adev->gfx.ip_dump_compute_queues[index + reg]);
>> +                                       else
>> +                                               drm_printf(p, "%-50s \t 0x%08x\n",
>> +                                                          gc_cp_reg_list_9[reg].reg_name,
>> +                                                          adev->gfx.ip_dump_compute_queues[index + reg]);
>>                                  }
>>                                  index += reg_count;
>>                          }
>> @@ -7379,9 +7411,13 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
>>                                  soc15_grbm_select(adev, 1 + i, j, k, 0, 0);
>>
>>                                  for (reg = 0; reg < reg_count; reg++) {
>> -                                       adev->gfx.ip_dump_compute_queues[index + reg] =
>> -                                               RREG32(SOC15_REG_ENTRY_OFFSET(
>> -                                                       gc_cp_reg_list_9[reg]));
>> +                                       if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
>> +                                               adev->gfx.ip_dump_compute_queues[index + reg] =
>> +                                                       RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME2_HEADER_DUMP));
>> +                                       else
>> +                                               adev->gfx.ip_dump_compute_queues[index + reg] =
>> +                                                       RREG32(SOC15_REG_ENTRY_OFFSET(
>> +                                                                      gc_cp_reg_list_9[reg]));
>>
>> When value of (i != 0), arent we reading same register i.e mmCP_MEC_ME1_HEADER_DUMP 8 times, how are we making sure when we read it again its reading for another queue ?
>>
>> Regards
>> Sunil Khatri
>>
>> I am assuming here also same explanation applies that when we read the same register again we are getting the next value in the queue but why use this value of offset mmCP_MEC_ME1_HEADER_DUMP but read the register mmCP_MEC_ME2_HEADER_DUMP ??
>>
>>
>> For i=0, we are dumping mmCP_MEC_ME2_HEADER_DUMP but for value of i >0 we are dumping mmCP_MEC_ME1_HEADER_DUMP ? Is that because mmCP_MEC_ME1_HEADER_DUMP belongs to MEC1 i.e for mec0 and for i > 0 i.e MEC2 we need to read mmCP_MEC_ME2_HEADER_DUMP ?
>>
> Yes.  There are different registers for each ME.  ME0 uses
> mmCP_[CE|PFP|ME]_HEADER_DUMP, ME1 uses mmCP_MEC_ME1_HEADER_DUMP and
> ME2 uses mmCP_MEC_ME2_HEADER_DUMP.
>
> Alex
>
>>                                  }
>>                                  index += reg_count;
>>                          }
>> --
>> 2.49.0
>>
