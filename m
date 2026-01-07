Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC44CF6C16
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E93110E566;
	Wed,  7 Jan 2026 09:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1RLRWTD5";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67CB110E3F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONSf9WzznyxJfwfedLUSFfrrIyi0X//aHHQWOEWaRAwQR0+LYOe9CVIsNm/Lyo89WwcXFRHQ7zT3bWxr1I3HaCeQq62PVcd9FxKW2y1IDQQ9UfvL0zrpiyUPVSGyYRoQxjXf/ddjjEQQWaNPvtv3GZsM7zsn1VlUFgh1gBPjJUQKBhQ8Txj8FWKoJBW5Jb21Eh9hqgUO5Hyc4NItNvHi661ifzrFmRetnLvy8aGMbQRrsXUhTYhOkSGAzVZapPBWpOu6B7UDkVS8ikLwDea9vFiJF3IZrc4c/nhV5pWEvoS2XBP+KODZ4XVQACfzg2xHP4JdcyX4vLhP37JzI3idQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0VOJCqJZYUomLuwfeBZzbOGQHqrp1C66F3JZS3RGgc=;
 b=W2iqyZdLU+e2BsyCRzkMDb41JuVgcdzK/LBQSIVtN6Fy32p//xpsHbTpwcl6g9sDtcscdyHrYRtHS49K3CY7c1JkVPUffXwYgCs5we2aoeNuHTSZFKQGkhzQxRqZLo1NukHem8CxIsc1+6+pzBnaTatWW++/P2R6I0bOnUye8jleqz7DYNvlSGqCKN7aZFzoFHnl8N5WhMEI3yUFcnfDndD7Lwua+S6nJtToZqAXyauYmjFNo3HBWHQfQtmpZIbnNXYZxSaGoIC/OpK4dwVImdZD87JA2Vx6zoy1FRoHHyb8I5rJ4m7YZzkZToMQLL5VcF4Hpi4lPOD1x68djqdgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0VOJCqJZYUomLuwfeBZzbOGQHqrp1C66F3JZS3RGgc=;
 b=1RLRWTD5Hz/f6Jwdkqfud736i2yqBh16vVANVnbX2KKKOox6Ot4Ybl/DYajpSlOyfgSIoVXsYEC36DUSde6NHgbzN1B54qKNVxNJ6NK+xLmWEBZ28e90yX5gY6kdHtDCqTZ96v2BbgjNZTTZ72wkMbAfbNf+XTDrv8cvfVVEHrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 09:09:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:09:19 +0000
Message-ID: <4d8e8a48-e160-4157-ae80-4715e74b0f71@amd.com>
Date: Wed, 7 Jan 2026 10:09:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] drm/amdgpu: Remove live context error log and
 skip
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-10-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-10-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0284.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: de69a0c0-4c41-4165-2e8c-08de4dcc7093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVhrTE05UWYzbEpTVCt4RkFTNy9JU01zTndwSkFPd2JxSGFOamN5T2Q1bTJl?=
 =?utf-8?B?YTU1U3VSeWlRVU9ENEdUNkJ4L3o3L0ZBbGtZYU9uTXJoTDg5UTE1dnNPeENp?=
 =?utf-8?B?b3Q1YkNpNW5aVVk1VzNzVGZZRFMyM2VlbHdIT3FCaUk5K1JmWkYrRXVHcjNB?=
 =?utf-8?B?bUxVdE4xL3RvT3lZdnBaSFNpK0VMMy9PcGZocWRDMDQzQzNFWUZzd1pHNHZ4?=
 =?utf-8?B?NHVTVjlyYUJNTjF2bWJDTWs2NHJsQlUybW5YaHZ4aWQ4RzJrZFZkdVNHL01y?=
 =?utf-8?B?WHlBYko1K01PbU1kMmlkSVh0QVpwYmZodzlma1RMaWVYVVlVemVscm11VUxs?=
 =?utf-8?B?RGpGNHhQRG9CQTAwT0gwUmVOK1E5dXZnS1VJRFVLZExxU25zQ0M5U2hJMFkv?=
 =?utf-8?B?ZXBqQkw4NTZtRzkxNW83bFl5YlZjWFd0WkRMUjlhVGxhSEcrNGRCZGEvZXky?=
 =?utf-8?B?QWgrdS9obG1pUlNLR0dCUnFsa3pMakk5VnhuUjY5ZjdHb1JyWjFrY2FFaU52?=
 =?utf-8?B?bGJ0ZEExU2M1ZlJscjIvTWxHVGNZeDhBZXBuOHY2cEpCMTN1SWw1djgxajdF?=
 =?utf-8?B?bHI0MDVZMjJTNGJBT2Yxb1hFUmtxeXdMZG1NSU8rcHorWnF1Z0ZZUE9aVW82?=
 =?utf-8?B?N3N5YS81cWlMa3pKMFl4bytjNXdDWHIwUW5GY0wrZDJGYk9EQTBFdVgyOGtE?=
 =?utf-8?B?cENQSVVJZTJpZjVpK2duWDNQVGN4bGZCTTN4cU1vcXdqamg1dzZ4aDM5ZFNZ?=
 =?utf-8?B?aGhnN1VvTjlLajFiSC9ockpwR3FMUkxGVmh2b3NQODA2Wm9ZcGJPOENqYTFk?=
 =?utf-8?B?OXhLZE1UdjFFbDVaSC9SZnRzQlc4YWtkcjU2VVJwb3dsYU1QU0diVUY1SmNT?=
 =?utf-8?B?ZFNkaWF6cnRISkd6RlhVZzlXcG4vSGZqQnlOTVdPbG4zRURYemNEd1I1eWpt?=
 =?utf-8?B?Q2VSaXVncmM2RXpMZVNMOC8wN2xKZkZVdG1wZWdCZEQyb0RxV1lKaWJvVVFt?=
 =?utf-8?B?TDRtVmI2UlJBSU95R0Rpb085K0l4WlZ1SmRiTHRlcjlCVDhYaHdLTUZpVEJ4?=
 =?utf-8?B?TDdBQjVoT2lsVkp3SklsaGdoRG1kaUZCRWpFYkQ5RUtJSURUaC9sU1BGQjZ4?=
 =?utf-8?B?Z2hpZkxqNUZ4WXV2emFkUHBaUE1xdE9hblFwS1Y3QlN5bDg4YzI5Wm85RHNv?=
 =?utf-8?B?a1NTUkxGYnV5UTlYYlR5cEZoWFd0bUtqOVVxZ0p4ck5ubzBSbi90YTZXcGpO?=
 =?utf-8?B?RmhkVG5yZEZlMFR2KzVVaXo0cjRYcDkwK21MSUIrUkJGczkvaUtrQVFTVVpI?=
 =?utf-8?B?VE4zNFplNkNQVnZqRDk2NXlFWkpjOURKNnJYcmFjeDFGaEFIUzN2Y1FWWUF0?=
 =?utf-8?B?eEx2dllOaDkvMk1yWGZvcndSQ01XNFVGdE1BUmFhNHZobTZtMEEvcTlYRFYx?=
 =?utf-8?B?RTJ3eW5VTk8xc2lyV1ovSm9zTEwxQzZ5U3UwcVpHMVA2WXlkQ0FBaDRCWkZz?=
 =?utf-8?B?NlRrUTBGdVlkUDJtbFdHcWJybkF3bHBIbXBWOWJPSXAyRVhDdVpEa3VmdGpZ?=
 =?utf-8?B?d2ZlUGdNalQ1d043MmtjR0hPbjVIMytiL25GMkd3c2JRYk9zN051R0RHRkpL?=
 =?utf-8?B?dGovZ3pCckkyem9rVFVCb05pZGpYR1lXZCswK09hVzhMRk5BakYreVFheHhX?=
 =?utf-8?B?ZUhVSGtQcE9oQjYyZVdHeUF3ODQzby92RU9hdzFsZDk0ODE5TktEbXRBdUhz?=
 =?utf-8?B?ajkwK3EySS9MK1AwUXoxNG4xOGYyMUtCbTZCVWQ3elA0UjN2OVhDT09BcEE3?=
 =?utf-8?B?SmRjZzZQSVZzVFVRYjdrY05YNG5objBvWXd1QTZEZDdwZm5sSEkxZVFkcGRj?=
 =?utf-8?B?dngyZXlVZlFSdVU5MHNSNU5sZnNjMWdRMktKSVFuSzZ3b09TYzhsSHFabndG?=
 =?utf-8?Q?35fhjKKPk63m9Us6AIsOOpNcCLL0ejEL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjNONVlNY1JjR1BFaXNWaVhEcUg4MjZ1QVpYNThlYnBkOUJSdHpIcldhZW85?=
 =?utf-8?B?WFNmU3pNWkh6OE55QzdtTkNxVTlxb2Q3OXlIcWM2dUdoRFRRNlk3bTdBMENP?=
 =?utf-8?B?MFNibmJJVWl5VytSUWo4d2NWdlVIcXNIbzdrdUFPSnBzbkdFYnBwYTVmQk1l?=
 =?utf-8?B?WXYvcXl5bVZmcEhMa29UYWthc0dhcUEwa0hDS3BGbTJXZXpLZUptVm5oL0lE?=
 =?utf-8?B?ZmdMZGRLWXZYNlNFSmVSQ0dqVUpkczEyWkU1UG96VFFuMml1cDNTcTU2QnVk?=
 =?utf-8?B?cklZcHNCNUNjT2pqU2V0bUFtR1lNNzVsdmg1N01KeVlsQVZaZHlVRUFHZkpY?=
 =?utf-8?B?ZCsxRldqWitEb3hKK0thSU9ndVdHRUlMNmVhV1dwNGJaMmtRaXFsaW93OW56?=
 =?utf-8?B?RWZSL3dTYldjbmp6MWxRaWxSQ1lScStxNUlSMjJJL0NiRWtkSlhwa3BqZGVy?=
 =?utf-8?B?aTJWV1hlcGhuTHpIbExSa3RtL2NSRzNzQjJJY3N2Qk5RTXdITTF5Rk9STEx5?=
 =?utf-8?B?eGNpTzNhckxZK0ZYaTBvc2ZObEJLbkJDenVMcmgyeWRod2dJeTc3cUUvNHJv?=
 =?utf-8?B?TzU5bnNJYUpGcjRhcTh6WXJ0VmlJMW9LS05ibEx4ZjFieUdNdjNEbnBHWUdB?=
 =?utf-8?B?QjE2Mm5JREd6RnNOeWlmVzlYbzBHKzAyOEd3bGZsRHlsdFNoNU11TjNJSkhY?=
 =?utf-8?B?NEEwL2RNckFMYWxpSEd3YXQxVFM5cUIyK05vWkxRL1VScm5PNlBzK0srcGhC?=
 =?utf-8?B?UmlSK21ZVTBWMVYzd0g0djBjaUh2WkdlNXBwOHNackFURUV0LzY3WS9XSkFp?=
 =?utf-8?B?TnBMS2phZkNjRDQvWW5mZXdZR2JPMVZabnBsbThpNTNpVEVlSzd3czhocGFS?=
 =?utf-8?B?a29KUGx6VDJ5VDFyeXFta1JnM0VNbFdXVUNhSVl2TnIxelNmQndSb0dRdnY0?=
 =?utf-8?B?aTgvSE5tcXkxZlJsb0hjb0VCOXM2Q2ZkVUZvQ2l1T2xNcU9ad29FK3Vrc1NE?=
 =?utf-8?B?d2lDcGo4VUFSUExvRjJhSFhIUksweXRneWxMV1NKaEI3QzdBazc5WDJvMGpi?=
 =?utf-8?B?UTBRZTBOWk9wYXVvR0N0aE5SbUdwSVJqcmVsckp3NmhUb0huWk1Tc2Z2aEpJ?=
 =?utf-8?B?bTdtK0JHN2FxeklJcE1zUDlLMWFKQlZQNTBoTGhQYjFWckJUNmNZcEJaMFh4?=
 =?utf-8?B?RlFuQndoZDdWS21oOGQ1V0U4eHZVOXdPYjBSeWJtWnR2SlNNY1pHNXJ5dlM1?=
 =?utf-8?B?RFhNWXdJbHEwS3JuRElDTURvZjJKbURmWkRWU2QwMTVidGRjTHJ5a2pGZUsy?=
 =?utf-8?B?WHpVZDc0MEdha2J0MDNkWEtDQmJPcHRtVGxObXRrUmpjclNncGxxcjlKdTZw?=
 =?utf-8?B?WkJDczBMRFB3ZzNxSTZoZVRzc2UrWDRSZHJRZVRXQTBlQ1VTaFUxRlpFYzNO?=
 =?utf-8?B?RndhL2lkRW9KQTBsQlgyekhHZVJMU1JQeUpxY3FXQVVaRXpGSXpTazZDN2ZP?=
 =?utf-8?B?cGhQYmp4bW9GOWFxSTV6V1B4Tk53aDU1dC9OZk5qckVJeFFGZG9QYlJQUk9z?=
 =?utf-8?B?ZGR1U1c0RkhiVmx5Vk9KYnZ2RzJuOEUrQXhza1hyTVlnU1MxZHhtMXNFeitF?=
 =?utf-8?B?NUJwQWEyK1F4Sko0bXJNQWxnVnozaUEzTU9zSFhqczkvNGtPMThLSzNvRWJs?=
 =?utf-8?B?MEpSS044SzA4RWM2NHBLcnpJcUdDMk1LNnVCZzNqdlFDUU9sTE1MdFF4M0VL?=
 =?utf-8?B?bTZmSVcvclV2TG9TZXJ6VVFQMGtBVkdiY3NlV0MyVnBiZno3aENhVUptaWto?=
 =?utf-8?B?cWl3RUJiVGJMdGJEYXdobmhBaEY0aS9zOWsrUzFTQjgrVHB1OHJ1QWRtMzJS?=
 =?utf-8?B?eGt3S0tEbjJVdUJ5MWw2VjBkZnhlZmZzemRrRmpCcDFHTE9waHZuaDZQN1Nh?=
 =?utf-8?B?M00rREQ0dUJCY2U4U0dneDUvUVQrY1hmWXQzWDZ0RkQ4d2JTelBKcURkMTBx?=
 =?utf-8?B?V3EvdkdHTnAwYmVXemk1T1hXTTF1QWt6eWtDKzZENVd0cDZFNnNXNCtYeTI5?=
 =?utf-8?B?cTZhMlMrdjVaOUk3UXp3d2MyMi9nRDh2WmM5eFkvYnZ2UFN0SjREanVlUFk3?=
 =?utf-8?B?SFB4S2F2M3p3LzFOaFgzQ0FBZGNaM0RtK2dnZ3BqSkZhM0c4dktHcHE0OVg0?=
 =?utf-8?B?YU9wcGxiR1JyZ2U1TUovRFYvcGJTOUd5QktuYkR0a3hoN3R0MVpXL3VCbXBv?=
 =?utf-8?B?a3ZBRXRRY2VJd0RCMFp2WjE5NHBPN1FDd0NLNzAxdXRjcllsWWExa1E2c0RN?=
 =?utf-8?B?ckJKdDltTlk4WWxFV0pmS2VoWjE2aldzOWlkd2pSVm1IRXZRQXVFdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de69a0c0-4c41-4165-2e8c-08de4dcc7093
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:09:19.2616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sR/7OKe5OfzC/PKd2RZaHs/9p5nqw9+JNeN9AlQim49LElg+viVL+OqOGHpTiVCY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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

On 12/19/25 14:42, Tvrtko Ursulin wrote:
> According to Christian the skip can only cause memory leaks if it would to
> trigger, while it does nothing for the fact context manager will still get
> zapped with live back references from dangling contexts.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f3d5a7180bda..b69dd3061e2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -894,14 +894,8 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  	struct amdgpu_ctx *ctx;
>  	uint32_t id;
>  
> -	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
> -		if (kref_read(&ctx->refcount) != 1) {
> -			DRM_ERROR("ctx %p is still alive\n", ctx);
> -			continue;
> -		}
> -
> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
>  		amdgpu_ctx_put(ctx);
> -	}
>  }
>  
>  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)

