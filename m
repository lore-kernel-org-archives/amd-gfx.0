Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A3BCD98E1
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 08:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F02E10E29D;
	Mon, 15 Jun 2026 08:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=live.com header.i=@live.com header.b="bqlHyzHU";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazolkn19010019.outbound.protection.outlook.com [52.103.13.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA34110E0A0
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jun 2026 14:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cn373EiMRH0JcdXwK//J8gLjCeunCNyIv0hu/Tifu28Ht7bUxmC1JR7n+bsAS8aTu6HA4iPrttY++RkhveQhpUCwHOURYVcVMCu5tp7TkBQdk/HzB6VAjt20WNnI7JFdkqGS4dP6Kma/qusG9Y761yTZunLLK0F0Kp4uTzzXsdpe0M59zKMMDxslbEsrsPVohrC7AiUh/k/QVgYlyGVpwaDdSp2GdbfPIVs1UgpFaaLSvv6esoFQAyVJIvwO4ZprHJQf2URJQFZej2UYVAuZOzBDWMoFY4NPtEZea7gMCy+xnYlwHW8sDt24NPPiSXkmgXQYq5+m5ivBrZzGbou35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tlk+i7KUZNQVW75cg8PVK0F0HnGuB4TTHpNia+wIh7c=;
 b=Y7mEEFJxCs8a9JF+ELc9j0bsr1WhCoti943+O5UxhwFdx270pLhuIPyV+15R0f4DOP6ym2HaXjwDDEIAgfBxc4Y8As3DwQAbV58HBPcGx5WrfbOlw3R6PySCq0SPyzQ+OBPzpEOtnq+zIwAsqzt0hQrMWllhihBVuihF+XKeSqVFaZkaiLr7BQkS09Pa1slpLxCw53RycNRUQEpAljppkfX7+kp8A8uKtWoqDlRoB4BySj5xM5hblbtY7z5jb4FSddyDQsNpncp7+h6k3K0BRKkMM0VIP3JKpP7TKApvSVcif2hjWJL1+ZgdKU7QW7iJTqVLNDXU29y2aclz3F3elA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tlk+i7KUZNQVW75cg8PVK0F0HnGuB4TTHpNia+wIh7c=;
 b=bqlHyzHU5WjExxRO43bBKDEWWs0f+HDBNnq51Z0pW0fvKAv28XhXgSZZbasN/wcHcgX1DHL8yL0eVQzF7+rdnhQ0mn7uaU/acZ05kvSKaDWwGFhXXh4586/3S8fEf/UVl9zAQFAvVTq7W1sCiyKzusaHTiYWVb5hHzb5ZkgcNrxRZWl4CfN80MPJIoqdav3Xk0qBzvveltUJA8zH1tGZcSVnyQD5FS50aKaeCSFIQtnk6h984h1F2fXcfnqeKYrtYIxot8tEJYLINIAqTdlTd6IPtaHeC4uXk0gVomknjak2T5oH7zzJHyyguFs7HmCXhxHrgiMnrgvoylai8dSMdw==
Received: from PH8PR20MB5193.namprd20.prod.outlook.com (2603:10b6:510:1c4::20)
 by CY5PR20MB4843.namprd20.prod.outlook.com (2603:10b6:930:24::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 14:11:13 +0000
Received: from PH8PR20MB5193.namprd20.prod.outlook.com
 ([fe80::2391:5532:6873:5446]) by PH8PR20MB5193.namprd20.prod.outlook.com
 ([fe80::2391:5532:6873:5446%7]) with mapi id 15.21.0113.013; Sun, 14 Jun 2026
 14:11:13 +0000
Message-ID: <PH8PR20MB519310C4CA59E83241D0C6CED2E72@PH8PR20MB5193.namprd20.prod.outlook.com>
Date: Sun, 14 Jun 2026 09:11:11 -0500
User-Agent: Mozilla Thunderbird
Subject: RX 7900 XTX (GFX11/Navi31): "Illegal opcode in command stream" gfx
 ring timeout, worked around by amdgpu.user_queue=0
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
From: Miles Margetts <milesmargetts@live.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::21) To PH8PR20MB5193.namprd20.prod.outlook.com
 (2603:10b6:510:1c4::20)
X-Microsoft-Original-Message-ID: <d3f9b09f-193a-46dc-929c-d0a1aee5652f@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR20MB5193:EE_|CY5PR20MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: e4981ef5-0ee8-4ecf-8bc8-08deca1eca88
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|39105399006|20031999006|6090799003|23021999003|5072599009|15080799012|24021099003|19110799012|8060799015|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUtVd2NLcFk0OGhIdEtWVkVvMzFPdXozZVJJZ0hHMEk5TW9oblMzaS9Rc2JE?=
 =?utf-8?B?S2ljZ3g5eEc0bjlieGU4YW1YcUxnaWRwYWRZd0ozODY3SEpBRDdZUVlKUlRH?=
 =?utf-8?B?WmFVNTlYdUI3U1ZDbmhTMGlRVGpYODluRHhaOUZTdnhCOVNBRzh2WXJMMXp5?=
 =?utf-8?B?OVNHRzhRN1JlZjFxcWJ1VWFYZU1paUkyV3dHdVpYRFBwWUM3b0xQVFl4ZGNH?=
 =?utf-8?B?MnlTUTQraHozWkZ4clZrc3pwbTRoYXBFSG0yVTZvQVZWL2hJYmt3ZG43UVNE?=
 =?utf-8?B?cVlINWJlcUtEeHlhMkY4ZyswZGRwSnptTHVMSVdQRDlSZHkvNFJzQktaUkNt?=
 =?utf-8?B?NC91VDdzYXdkWHkrNEJuSnREYUtGN1pYVHJDQUp5c2tJMituZ0NQZVViWEhE?=
 =?utf-8?B?blZyYTF4S2hUWUNwYmVqNlMxUHFQanJPaDN0SCtLV1VTS1hBUVBST2wraGxW?=
 =?utf-8?B?Q2VJTVpvNmhEU3RUQXYyZkxPS1VtaktOUHVnVVBRMmEyR2xvZ2xMODVDRWxx?=
 =?utf-8?B?Y3NUTkptVGxNQmtGcUUxWFAvQmI2YlVMdmU3L0dDS3R2VEkwZXN1OG95T0Vy?=
 =?utf-8?B?eFFjaEZkWEw3dUpBUjlxVENsYytGQXZzZDVSQ2dCM1hoa1orMXJuSTM0MUVm?=
 =?utf-8?B?azJlRDZLS1Q1TW50NTcrcnRDUk1tYk1wTS9sMjU0OEJWL0xQU1VBNGM1QXV5?=
 =?utf-8?B?SlJBOUZjV3pKU3RhRE53WStzWGJkU2krd0EyVlJ0dC9jczNIUWlKZDRVUUVa?=
 =?utf-8?B?WWFaQUxzSUtzeE5xaUpEUHpJaFJmNjBrVDA0djBlQ0pWc05GOUR2cU1FWFVj?=
 =?utf-8?B?SkdtYkUrY1hGUTYwY21OVU0vU1VvNXd3VFFuZ3A3V2VWaDZRZFVCT1NRb2xU?=
 =?utf-8?B?YWgvejhxYzhmdndqOTEwQmQ3S1JTZmpGNkwvVzBWVFJXMDJHT1Z6MCt5Z1FO?=
 =?utf-8?B?aVZKTHM3bVFkdjRIQTB1TFBndmdBbTlpUHIvcmV4cHRTK0laYzZmTmgwcE5q?=
 =?utf-8?B?ZDhNTTZ4TDZ0azgxdm1Ybmkxb2Z4Z2JLZkI2US90NzZaM2FKRkVHQzFnYjJi?=
 =?utf-8?B?eHk4eVppWXZHbEZCWWVmUUVuMmlMTWJzaU4yVFU2cVRCbWVRSEoyYVMwZHpM?=
 =?utf-8?B?SDM5ck8zbkpJaVVCR2lDeTNuQVUzckVhYk9EZ052aGJ5TDFqNWgrUHpHTFF6?=
 =?utf-8?B?SXAweXlLcWt4dGdZc1pCYzQxU3JNemk0a0Y0V1lsOUxaejRUOVQ1VjZSWlVl?=
 =?utf-8?B?cDV5RHhEcnlKdFM0MlhZdUpoZ0ZDTXA0T3BQS0NtTHpRNXdzZGEvQ0FxcmJw?=
 =?utf-8?Q?+Rg5b01/7HqBjRo1W54TVYN0lxaUItrr41?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFE1UVI4MWFMUzVZWCs4YnljZC9wMzVuRC9IOHo4eDhpM3ZhOWx6cWU1T3Bi?=
 =?utf-8?B?M1ZmY29PQVp4aGV2VmFFRzVFZzgvVFBMOEtRRnJ5M1AxbHlOTkg4UzhpN0E0?=
 =?utf-8?B?ZUlGVnNxZThsZkRmRXZiaSs0dDJQa3RSM3hZQ2xWb1dZdnk3Q1prZzVhS0xF?=
 =?utf-8?B?UlVVZmFmanE5SkxSRy8xamNpMHVuOE5ZemVyM3NhaERUdVYzRFFZMUQ0czRV?=
 =?utf-8?B?NVI5azRJVi9zbzdMZ3M4ODkxYlpwLzBxbWtXbEwzbkNJb29xNWU2eVdFY2ZK?=
 =?utf-8?B?cEE2cHpLc3daQlVsMnJscVRRaitzcHBRNXpBTXFrYXdQT2lOS2JTTGR6ZFZv?=
 =?utf-8?B?QzV3T0IrZ1VTY3VCQ2ZDMkpnMTU1YW4xMlY4MlhmWkgyZXhQcHVjbm9URFgy?=
 =?utf-8?B?N2dmc3VvT05vN3V2Y1Y1YktRK3lSVExYWkZnSG1MOTlZL3JUMy9ZY09OdUln?=
 =?utf-8?B?Q3pKVGdBaDJMa0V0R01OdlBidUpqdmd6ZEtlMXFmQ2J1RFF5U3BIK1Vvc0xH?=
 =?utf-8?B?VnRTWklFbGpUT1QwaUZrdGxLK25QSStnNEtBcVlUVjFpNHk0NUsrei9XZkZl?=
 =?utf-8?B?VlpWZThWQk9rc3gvMVNIVktCYnc5VTAydEsxSzZQNTVGeUNHLzQwVWhJWHRN?=
 =?utf-8?B?ZDNyMGZmSUQzVVQxbXp4OU9CSE1rMktDWWJaaWRxMnJsT2JGVnVHNXBENm94?=
 =?utf-8?B?MnpoNXBxbHdqTHJYeHFMcUlqM2labHpRZjdNQjhVbWQ3V3VQekxWdDF0QzNM?=
 =?utf-8?B?UktuRmJjMWRJTVFuM1ozMnl4TjVTSVludWtZbEhhMzlhQTc2TE5aTmFpMVBw?=
 =?utf-8?B?K3JpaGNIZkNvSTBvYWZzanh2SnFkandLTzJ3SlpvTHBBL01hOFpCRGhSdGN1?=
 =?utf-8?B?Z2xzZDRINVU0OFlVK2EyQTRGRjB6aFNsaGYyaFhrWTFlbUlBTDlkenBTZGIz?=
 =?utf-8?B?bndQcGUxanNmSENmY2N6cHd5UVNxekZBdXF6WE5jQ3BQQjVCVHBPS3ZLSEp1?=
 =?utf-8?B?SkthRHVySFkwMnZpWW5rcnh4ai9iR1JrRExhRDdZY0FXOHJoN1orSFRUeGlK?=
 =?utf-8?B?d1BVSS9rOGRxMGFCVnhKZWNkWlB5eWJXQnBUblQ4N3M4S2gxZHhseVdhNDNO?=
 =?utf-8?B?Z2N2aU1XVXBHUHFIWk0rTDhpRWhHRTFpc2NRZTgwNVJtQUNUMzJvVVpIckNt?=
 =?utf-8?B?Uzd3NUFtdERwRXVDK3BySkFsMXZyNm9LU0lMaDdBY0FDdmhEVFlTcGcySDRn?=
 =?utf-8?B?TGM2Y0hyVlY4QU9QSGViSkF2ZjhkU3d6Ym85UWNwUHpwZmhFYXZrTm9RWXd0?=
 =?utf-8?B?UHZ2Q2kxSkplYnpGYlBBVURvYnp1Y00wNEhEWEo5NVdEbkRKZDMrRmU5UGF6?=
 =?utf-8?B?U3g5YmN3emljWk5kWGtwR0w1ZW8xeE1vWlNQeHU0bzNHZWRKaXltbnFyQjJW?=
 =?utf-8?B?NjVnY2RRdGpwYXJtdFRDMEVJcmx1REpreHR4bytwRTBhUGhUTURjTHZ1WFNW?=
 =?utf-8?B?aCt2T2FjRy93blBrcGxtczNaOUc4VXB5VFNBY2NMQmtPaWxtUTBLbUlqTitz?=
 =?utf-8?B?alEwRjhwM1liUm1jajZmRmZsd2I4VmpTVWxaZXJCeGxUZFlkTjJUVXBNdFZK?=
 =?utf-8?B?cEMrSkRjN05xZVZNQ3Y0U05GWFZvVTJsa0xVZVBDUVRxeUxQVStIbnlkdjc5?=
 =?utf-8?B?a1lPWVZlb2NlTVFGRXVhNUh6bFFSS2xCTVdjY1VTWHpQei9QdmZVZmozOExR?=
 =?utf-8?B?dmNUOWxGOWUwQUxpSHdkeWtQaExTaFZnNVpUVlI0bVFBeXBjS1BZeC9HeEJU?=
 =?utf-8?B?TjlGaHpZMWJaODU5NnJPdlV3Rjlmck1QSUFhVUJJQzA0eUt5YVBUVjVnUEpF?=
 =?utf-8?Q?ZxYYFe6jOvp2U?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-6d936.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e4981ef5-0ee8-4ecf-8bc8-08deca1eca88
X-MS-Exchange-CrossTenant-AuthSource: PH8PR20MB5193.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 14:11:13.3679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4843
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:22:58 +0000
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

Hello,

I'd like to report a reproducible GFX11 GPU hang on an RX 7900 XTX, 
along with a workaround that seems to point at the user-mode queue path. 
I'm not submitting a patch, just flagging it in case it's useful and 
asking whether a devcoredump would help narrow it down.

System:
- GPU: AMD Radeon RX 7900 XTX, Sapphire NITRO+ (board 11322-01-40G), 
Navi 31 / GFX11 (PCI 1002:744c)
- Secondary: Raphael iGPU (1002:164e), not used for display
- CPU: AMD Ryzen 7 7800X3D
- Kernel: 7.0.11 (CachyOS, Arch-based)
- Mesa / RADV: 26.1.2 (vulkan-radeon)
- Session: KDE Plasma 6 on Wayland. The failing client is Xwayland: the 
affected app is the native Linux build of Baldur's Gate 3, which runs as 
an X11 client under Xwayland.
- GPU tuning via LACT: Overdrive enabled, core clock capped at 2600 MHz, 
voltage offset -20mV, framerate capped at 71. NOTE: these were unchanged 
across both the crashing and non-crashing states, so they are not the 
variable (details below).

Symptom:
Intermittent full GPU hang during gameplay. The gfx ring times out 
immediately after an "Illegal opcode in command stream", the ring and 
MES resets fail, and a MODE1 reset recovers the GPU but loses VRAM and 
wedges the display, requiring a reboot. Representative dmesg:

amdgpu 0000:03:00.0: [drm] AMDGPU device coredump file has been created
amdgpu 0000:03:00.0: ring gfx_0.0.0 timeout, signaled seq=38937911, 
emitted seq=38937913
amdgpu 0000:03:00.0: Process Xwayland pid 1063 thread Xwayland:cs0 pid 1071
amdgpu 0000:03:00.0: Starting gfx_0.0.0 ring reset
[drm:gfx_v11_0_bad_op_irq [amdgpu]] *ERROR* Illegal opcode in command stream
amdgpu 0000:03:00.0: MES failed to respond to msg=RESET
amdgpu 0000:03:00.0: failed to reset legacy queue
amdgpu 0000:03:00.0: reset via MES failed and try pipe reset -110
amdgpu 0000:03:00.0: The CPFW hasn't support pipe reset yet.
amdgpu 0000:03:00.0: Ring gfx_0.0.0 reset failed
amdgpu 0000:03:00.0: GPU reset begin!. Source: 1
amdgpu 0000:03:00.0: MODE1 reset
amdgpu 0000:03:00.0: GPU reset succeeded, trying to resume
amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
amdgpu 0000:03:00.0: GPU reset(1) succeeded!
amdgpu 0000:03:00.0: [drm] device wedged, but recovered through reset

Reproduction:
- Occurs only in Baldur's Gate 3 (native Linux build) when playing 
multiplayer as the CLIENT.
- Stable in single-player and as the multiplayer HOST, with identical 
settings in the same session.
- Onset varies from a few minutes to longer stretches of client play.

Things tried:
- RADV_DEBUG=nongg: no effect, so it does not appear to be NGG-related.
- The undervolt/clock settings are not the trigger: the system is stable 
as host and in single-player with the exact same tuning, and -20mV is a 
mild offset.

Workaround that appears to resolve it:
- Booting with amdgpu.user_queue=0 (disabling GFX11 user-mode queues). 
Since applying it, client sessions that previously hard-froze have been 
stable.

This seems to point at the GFX11 user-queue path (queue evict/restore / 
MES queue handling) rather than RADV shader codegen, but I have not 
root-caused why the malformed packet is emitted.

I can provide a GPU devcoredump from a future occurrence (I have a 
capture hook in place to copy it out before the ~5 minute expiry) if 
that would be helpful, and I'm happy to test patches or gather 
additional data.

Thank you,

Miles Margetts

