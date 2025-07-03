Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053DAC83030
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jul 2025 07:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E59B10E7D2;
	Thu,  3 Jul 2025 07:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wa2X4t60";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C52810E7CC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jul 2025 07:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtLUuddJcD9POf70S3wXMG+4JfkxlrdwGxogSiNH+H2daO09rg0SENtgMZqNeHe2pAD8BeImIW0N1JRUAqIAL/8KvEQJtKn4lz+THPh6Zc/dt0ARJEZamsnNUiuapM/6aKNwsjsSYOslFF5O+ttHyLBxBDKhACYk9VZGcqUFlezAkxwMsr9Ntkt4q50/oGD2tCUG9Wtr1ueZpw0kqjDpsfv80YVPJEhExUesF2jKlXbtX7KP+eTRRDQGS6UAFAaeU/RoKlQF/6CDCc4N0zzTFj8eaGE26IgEhrsXD/1IbJ3vUxX9yiCCrBSKs0PQSDnw2FxogBdlX41Xm6CiFpulZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9y8WGq7/uZMZJsEqldP1h5183LtDSBhlkiMKkPV+QU=;
 b=GGXJ1fC1BPQtzDJ91EjHG7IGhpZfuog/J9ZiNQGGul/F6v+ZecPAZn14TPZm408x2sEG5vBebbWJXrn2XeXMo9uD112BtmivfC37Z3BZpbkYsgv69ibLrAIop+3jI8VN3rnhRMhJduUCMYDUgr7eoUOGIA5qcsUdDW1FB4LKTCExUiTemb0DwuvFTbXQHPEmOtMxcBYXde6o7mDWOtmb0UzbZYQWVpwcFI204CfBKZzVnJufCXn8Y7y5PtGcgIYRZoraxLrI0HfaStnIQyKLSnpsy6nQKnak2il1xe1dd+JCsafo0K6eWtxY+S2xTRjyMsLzjDTGGmNYH9p9gUhhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9y8WGq7/uZMZJsEqldP1h5183LtDSBhlkiMKkPV+QU=;
 b=wa2X4t60/0z+QSGkK2EOr6BOWWd9jZslG+Nuj1V2h5paJuRN5JyUBUULjQyQE/AvzKQyfor1KVxubytsvOXqvjdHjbIoreERJLR093B09Q/6tBHKTXsuffd1bHH9KTSnBEbg/FoAiGMG4x2JUugkmMudjKKn9pDTpkN/ARs9Pkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 07:17:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 07:17:00 +0000
Message-ID: <b5dce677-5aa6-4323-8aaf-99593dd3c5ea@amd.com>
Date: Thu, 3 Jul 2025 09:16:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: delete function amdgpu_flush
To: Philip Yang <yangp@amd.com>, "YuanShang Mao (River)"
 <YuanShang.Mao@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
References: <20250627051204.62029-1-YuanShang.Mao@amd.com>
 <PH0PR12MB54205C1B34B693720538A914E045A@PH0PR12MB5420.namprd12.prod.outlook.com>
 <a3b5cc3a-f863-b845-989c-ddd6ac953a52@amd.com>
 <CO6PR12MB5409AF9DD130FFD6323C1A49E041A@CO6PR12MB5409.namprd12.prod.outlook.com>
 <ecd7b192-84af-4e3e-82d9-4283ca14fe4c@amd.com>
 <2ee49f02-e7cf-197a-a6dd-e66b22c57f81@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2ee49f02-e7cf-197a-a6dd-e66b22c57f81@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a12fb7-0870-4195-18fc-08ddba019a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGN4R2tGcVoycXV3S3htemJJb2NUT2lWTkJxdzlnTDVXVDQvaU14Y3p1Rkd2?=
 =?utf-8?B?KzRQbmI4di9ybEhwQ2tyMVdyVW5FOG5aUDVFSkNhSUxwcTFRUU9qZ1JmTXRN?=
 =?utf-8?B?eEFUeUpxcWt5OWhMeGVWTzNiaUJkY1pIVXBkY3R2SlJqOTFUM2U4dFJqVU9N?=
 =?utf-8?B?ODEvbzJyaHozVDNrZkhJZ0lKWHNpb1J0cmFBc0Y0R2M4S3FicUE2ZlNWeGQx?=
 =?utf-8?B?bGthZm9rbkJWUHgwSjhTWTRjeGhuS1lpbEFiOWp0RkUzVFUwS3AvVUJ0SFhB?=
 =?utf-8?B?bWhwZnV4b05uZjM2b2ZreDBuVnl1TnNlMFdqVWpDTE92OGtyN0c2L3hjbmlv?=
 =?utf-8?B?Y0hWQTBuMjJBdzVNd2JUMGxSTWY5STV0Nm9OTzd2VGtFUk5vN2o5bytKSE5F?=
 =?utf-8?B?MXQwdTgweVhSS1dIZWtHRE40T2Z6VTNrV1ZGb0x2TTZNM1RCK29tS0poOUZ4?=
 =?utf-8?B?b2FmeVhIRlpzbXBrYTBvWjR2Mkg4dktOSi80VFhVTWlncnlGZjZyMlUzeFhG?=
 =?utf-8?B?RE8vVVRjRXBjeUg4c3NlUkdIdFRuZDBDQlpiUVBuNHNOd09zamd3MUVYSENp?=
 =?utf-8?B?aEZ2SnQyUnhCSEVXTHhoakJrNWc0cTdGTlJVSXByUnVXaDFIZDY2SnRSQ2xy?=
 =?utf-8?B?NkN5ZDdkU0htUklhbzFtanZVdkVZMDFyRzV0djNTbjRqbC9HZzZGYW5sdzlk?=
 =?utf-8?B?UGRZeHh1RUU5SEJUZUtxMDRmNzVKT3pkYkZlelVObHprOVlQMlhHYWxJaHZ5?=
 =?utf-8?B?U0FTTldVb2pHTUVLV1hoaE9LWVAvQ2pWcnBCNVJ3aVEzZzR0S2V0K0hiYnk0?=
 =?utf-8?B?bDh4Y25oOXBuMU9hb3BtNXRiTXRIMVhOMGFhMVlwWjRTL1BrRmgzTHcwTkVS?=
 =?utf-8?B?cGtZcXdPU3hIMTk2bjZzSks5M2NVaEd6OUpTREtYRUFXTXJDR1Jwc0tsU2U3?=
 =?utf-8?B?Ykt3Vnl4eXQyWGpCRlAvM0ZXMnNiUmh3dEpxSVB4Q0hFbXBjbThyVHB6UG9D?=
 =?utf-8?B?SFhNM1F2RWpSQjB3Q2FlZnpGMy9EYkw2MWt4cWxXUkVkcUR0Ni9NaGgwK3dD?=
 =?utf-8?B?TVBXbnQrekJaVW1NQUFydEQzSkdWS1BzMEx4UEd2RHBtYWN0SUI5Z2RGZHVJ?=
 =?utf-8?B?NFhJMzE2dWhqaTJXVUdnQ2ZYeitwVFFHM2NTNnovQzVaamNhbkNKckgxM1dE?=
 =?utf-8?B?TUlqbTRZUzN6MTFCbjRoUkE0cW0xTkZBQWgrby9BbWdTZytiVytWVk5YUyt0?=
 =?utf-8?B?VWFYWEVQR3V2QlBDQUlhYlgya3ZNVDJWZEN3NmNiL0pWVlV6QVZEWWk5cG96?=
 =?utf-8?B?Y1VGNi9XbTlYUlN6US9XRFVCRitpTG44UnYxQlJxRCtBQjVTTHVidlVHbkZq?=
 =?utf-8?B?V1ZWbkNKYWFSb0l3ZUM3b0ZIMldTbHpLbjBOZ1VIMENXdE1DU1JpRXl3K0sv?=
 =?utf-8?B?WW1WM3lPbk52bW1zUndBTTh3Y0VlYS9KNGxPTVljTU81cUp3Q0lBR3lYSVIw?=
 =?utf-8?B?czhNQjlkazJBb2grUWZQZGF3ZFBjUlVkTnBLYkhRbXNDbTdSY1BuaWpSM2Mv?=
 =?utf-8?B?WnQrLy94WTFPNTY3YkFKbUg3dExmb29EcmNCdFBCWEVTK0tIanJVZWF3Ui84?=
 =?utf-8?B?aEM2NDdJckpqRzE4ZlRUV0dwVFpPcVdpU0NUTFd5V2drRkkyUWFPNTJCU2lq?=
 =?utf-8?B?L1REZ2FGQVUzRUhMekdSMTdOaEJBR1dCNVJveWwrZHN2QXRzZkEydUZMMFZQ?=
 =?utf-8?B?OHBFZ081SGh0RTRiOUgzL1Y5QlZmK01aeHc1Vyt0RkEvM2NlcU1LV0Ixbkkx?=
 =?utf-8?B?TjdxaDVKL21uMlhxWGRLYUtFQ2xodE5Qdkx3VVE5cGYxcUY5L2hHK0lwUXJa?=
 =?utf-8?B?ZjNsUm9hSHdFd1BPWlc5dTlHUjRwYXRrUnE2K2JRRXhVY01SclNlQms1Z1Fq?=
 =?utf-8?Q?F4WHXT5EIBs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFsMXdSMkhCZEMzK1BPTmhQa21sY0xRakZzWGh0V01mUkUrRUdiN0xmVXNU?=
 =?utf-8?B?WDVmSmFhVXVCeGpWQjFOU0JSaXEvK041UHc5cG9kMTQ5RVZGM2tsaFByKytn?=
 =?utf-8?B?WC8zUGdKSys3eCt2eEZjaWM4OEZjbVBlT2ZlMnlQSmR1Um9HTm9hR2ZTcXBH?=
 =?utf-8?B?WmRWeC9ua3Uvei81NitGN0JmOExvMnVwcEpOQ1pTOEdveUpEWDdaRW9INjBy?=
 =?utf-8?B?V2FpSnYyZTNwc3NnWTNGa1U3SmF2bFdTYVlESFIrY2crQXQrZWdZOFZYK2tj?=
 =?utf-8?B?OG1OaDB5QVNoOVJOT1hFbVpsbFZvTEQ1eTB6dU90OWJNK2J6cGd1OHgxWVND?=
 =?utf-8?B?TERBcmRNWTlMU2Vwam4vZFliMUFWZUsvYXpaUnRGcXoxbEtHUGNXR0NuSUZL?=
 =?utf-8?B?R1ZwNCtrVFdCRnNEcm1tMWlCU0VlWHVSUnAyd0pwODEzOXNROFduei9UMlZR?=
 =?utf-8?B?ZkE1MXB5TzlLWjF4a2ZMV1RnNkx2Y1F5d3RVUUhzelNPRlBYSnk4c0g1Z3F3?=
 =?utf-8?B?S1RwenlUVzA3NklGSkdRNm5xVWg0ZXNzdUk1am5xcENsUkdMUEcrbUs3ZW5h?=
 =?utf-8?B?S1VBM2pHN3ZScTVGdHkzOXpWZ0lMOUN2ZUxJN1dBcmFzQUlHY3pZOGF0WVhq?=
 =?utf-8?B?NlRZTEQyYmpjY29lYlR5S2Nsb2szSU15K1lENHRTeUVtbjZVaG5SajBmaTZj?=
 =?utf-8?B?VU9YR3pBQzE1TVBWWmh3R3J6ZGxTaTIySWdmdUd5WExqUW50blh0ZUd3Wlhz?=
 =?utf-8?B?UTQzVlA1YzFQQVpNZGxoQytBSDhZQVJzSHllbEF6LzZocUFrSFJ3SnlKbytk?=
 =?utf-8?B?YUxNNm92NjlOMDBzcXJkNFlWSUovZGI2MHlDa0Z4a0wwV2ZiSmNtVlNqWlVl?=
 =?utf-8?B?ZVFhbWNlZThHRjNLdVBhUmVHU3U3MmZITER3cTQ4R3BQWHFJZ3h1b0MyWk9h?=
 =?utf-8?B?T2ZDRlA3ZHZGR3hROHJXdGYrNzZuWmRDVEM3RTNrdHFvY3BJRnF0NTQwYXF3?=
 =?utf-8?B?NmMvUFR4QkdmOVJtNG9rQlhpTklDbkJxK3o0QkVlM25TK0VqM0ZvR25rOEVr?=
 =?utf-8?B?cFp5aVlqVDR2cmtWQlR6ZnQ3NHJSRTlpZ2lrUStoN0Z4RUw4ZlFEMGd0aUIz?=
 =?utf-8?B?Qit6T2ZCTk1nNGlNZkE0Uk1VOFZuOGc4K0FzZmtabDlHY0pIcXg5dTVHR3Y1?=
 =?utf-8?B?Zzdodld4K2VoUWxWeTgzQmVxTE1qSlljczNGQTRvRFIxQVFqMmRYWE94eFJ1?=
 =?utf-8?B?TzQ3L2htNVpwYXM4RjVTK2E5ejhMSWN6UE80MnU2NEFZSTBROWtmMlJtQmRo?=
 =?utf-8?B?aDB1Qm95SlFkdTdZVkh0V1BNY2xLMmlkQWg3QjRWaE11cUZPbnFFZFhtajlu?=
 =?utf-8?B?NERkU1AvTDhyTExzcm9VUEljVis3OWRqeVRvMWcvdEFhTjIrWnpwWjVjS0Fr?=
 =?utf-8?B?UFo0VGV2amJ5SmpuL0VWNWpHZi9wSEJKdko5dlRSSkNhalo0ekszVHhqNDJm?=
 =?utf-8?B?Z0lBNitVZXlQcHR1ZEFIdzJrODlpaXRZdjZvM09pN092ZFVmVWkvaEIrV2Nq?=
 =?utf-8?B?SXBmc1VUeERXeEJqZjV5dkM0N0M2ajJLc0R1bWIrQTFFY0NwTHM3VWEvM0tF?=
 =?utf-8?B?UEg1N29QdzlUM3FXRkp4REU0U1BGbjlZUHBzRWpXcnpCZVNRYloyd25ncnU1?=
 =?utf-8?B?WHRGSW5OOFdrcHFMTEtCK1ErMFRwSjlNNG5UUFB1VHQ1N1ZkeVZjeHl2bzlp?=
 =?utf-8?B?Q0NBTld2TkVkUkVQZ3JrVlVXbzM3VlAwSGxJcVp6eGRnSFpWbllzNS9Xb2tF?=
 =?utf-8?B?ZEIyNWxVYjBFMzNnbEFkdk00akV5bWJodFNuVFRTOHZocEVzY2g2UDVLTHZj?=
 =?utf-8?B?OFc0THZCNTZVZjdXOGtoOXlvY0dYRjdMZ2JRc1BtNTZOTVR2ZWJob29mR3F1?=
 =?utf-8?B?YXBOQjNhemc2OUc1RmkydE5oK3E4Y0RxMUpJOW0waXJSR3BHaUlOa0M0VWlw?=
 =?utf-8?B?VkdGYzU0SDkyQnhianFCR09LK0NDUUJ1cW5RWU9zWjUzSjNHcitQc1ZmdUlh?=
 =?utf-8?B?eDAwczM2Y0s5Qlg3QmlHN1VFdm1ob3J4Ykk0Q1BVQnlGQWZoQXMwQTlCQnc3?=
 =?utf-8?Q?aat4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a12fb7-0870-4195-18fc-08ddba019a1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 07:17:00.3408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD5PgQsgdVt0CPoXXxVLDyF+spuxSbzANAuEh8EzKv/okYraopCx/zqjkwPzI1iM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
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

On 02.07.25 18:40, Philip Yang wrote:
> 
> On 2025-07-01 03:28, Christian König wrote:
>> Clear NAK to removing this!
>>
>> The amdgpu_flush function is vital for correct operation.
> no fflush call from libdrm/amdgpu, so amdgpu_flush is only called from fclose -> filp_flush
>> The intention is to block closing the file handle in child processes and wait for all previous operations to complete.
> 
> Child process cannot share amdgpu vm with parent process, child process should open drm file node to create and use new amdgpu vm. Can you elaborate the intention why child process close the inherited drm file handle to wait for parent process operations done?

No, that goes to deep and I really don't have time for that.

Regards,
Christian.

> 
> Regards,
> 
> Philip
> 
>>
>> Regards,
>> Christian.
>>
>> On 01.07.25 07:35, YuanShang Mao (River) wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> @Yang, Philip
>>>> I notice KFD has another different issue with fclose -> amdgpu_flush,
>>>> that fork evict parent process queues when child process close the
>>>> inherited drm node file handle, amdgpu_flush will signal parent process
>>>> KFD eviction fence added to vm root bo resv, this cause performance drop
>>>> if python application uses lots of popen.
>>> Yes. Closing inherited drm node file handle will evict parent process queues, since drm share  vm with kfd.
>>>
>>>> function amdgpu_ctx_mgr_entity_flush is only called by amdgpu_flush, can
>>>> be removed too.
>>> Sure. If we decide to remove amdgpu_flush.
>>>
>>> @Koenig, Christian @Deucher, Alexander, do you have any concern on removal of amdgpu_flush?
>>>
>>> Thanks
>>> River
>>>
>>>
>>> -----Original Message-----
>>> From: Yang, Philip <Philip.Yang@amd.com>
>>> Sent: Friday, June 27, 2025 10:44 PM
>>> To: YuanShang Mao (River) <YuanShang.Mao@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; cao, lin <lin.cao@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: delete function amdgpu_flush
>>>
>>>
>>> On 2025-06-27 01:20, YuanShang Mao (River) wrote:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>> Currently, amdgpu_flush is used to prevent new jobs from being submitted in the same context when a file descriptor is closed and to wait for existing jobs to complete. Additionally, if the current process is in an exit state and the latest job of the entity was submitted by this process, the entity is terminated.
>>>>
>>>> There is an issue where, if drm scheduler is not woken up for some reason, the amdgpu_flush will remain hung, and another process holding this file cannot submit a job to wake up the drm scheduler.
>>> I notice KFD has another different issue with fclose -> amdgpu_flush,
>>> that fork evict parent process queues when child process close the
>>> inherited drm node file handle, amdgpu_flush will signal parent process
>>> KFD eviction fence added to vm root bo resv, this cause performance drop
>>> if python application uses lots of popen.
>>>
>>> [677852.634569] amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
>>> [677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
>>> [677852.634820]  dma_fence_wait_timeout+0x3a/0x140
>>> [677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
>>> [677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
>>> [677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
>>> [677852.635208]  filp_flush+0x38/0x90
>>> [677852.635213]  filp_close+0x14/0x30
>>> [677852.635216]  do_close_on_exec+0xdd/0x130
>>> [677852.635221]  begin_new_exec+0x1da/0x490
>>> [677852.635225]  load_elf_binary+0x307/0xea0
>>> [677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [677852.635235]  ? ima_bprm_check+0xa2/0xd0
>>> [677852.635240]  search_binary_handler+0xda/0x260
>>> [677852.635245]  exec_binprm+0x58/0x1a0
>>> [677852.635249]  bprm_execve.part.0+0x16f/0x210
>>> [677852.635254]  bprm_execve+0x45/0x80
>>> [677852.635257]  do_execveat_common.isra.0+0x190/0x200
>>>
>>>> The intended purpose of the flush operation in linux is to flush the content written by the current process to the hardware, rather than shutting down related services upon the process's exit, which would prevent other processes from using them. Now, amdgpu_flush cannot execute concurrently with command submission ioctl, which also leads to performance degradation.
>>> fclose -> filp_flush -> fput, if fput release the last reference of drm
>>> node file handle, call amdgpu_driver_postclose_kms ->
>>> amdgpu_ctx_mgr_fini will flush the entities, so amdgpu_flush is not needed.
>>>
>>> I thought to add workaround to skip amdgpu_flush if (vm->task_info->tgid
>>> != current->group_leader->pid) for KFD, this patch will fix both gfx and
>>> KFD, one stone for two birds.
>>>
>>> function amdgpu_ctx_mgr_entity_flush is only called by amdgpu_flush, can
>>> be removed too.
>>>
>>> Regards,
>>>
>>> Philip
>>>
>>>> An example of a shared DRM file is when systemd stop the display manager; systemd will close the file descriptor of Xorg that it holds.
>>>>
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: amdgpu_ctx_get: locked by other task times 8811
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: owner stack:
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: task:(sd-rmrf)       state:D stack:0     pid:3407  tgid:3407  ppid:1      flags:0x00004002
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __schedule+0x279/0x6b0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  schedule+0x29/0xd0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amddrm_sched_entity_flush+0x13e/0x270 [amd_sched]
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_mgr_entity_flush+0xd6/0x200 [amdgpu]
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_flush+0x29/0x50 [amdgpu]
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_flush+0x38/0x90
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_close+0x14/0x30
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __close_range+0x1b0/0x230
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_close_range+0x17/0x30
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x1e0f/0x25f0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __count_memcg_events+0x86/0x160
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? count_memcg_events.constprop.0+0x2a/0x50
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? handle_mm_fault+0x1df/0x2d0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_user_addr_fault+0x5d5/0x870
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit_to_user_mode+0x43/0x250
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit+0x43/0x50
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? exc_page_fault+0x96/0x1c0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x762b6df1677b
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffdb20ad718 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000762b6df1677b
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 0000000000000000 RSI: 000000007fffffff RDI: 0000000000000003
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffdb20ad730 R08: 0000000000000000 R09: 0000000000000000
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000007
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: current stack:
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: task:Xorg            state:R  running task     stack:0     pid:2343  tgid:2343  ppid:2341   flags:0x00000008
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  sched_show_task+0x122/0x180
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_get+0xf6/0x120 [amdgpu]
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_cs_ioctl+0xb6/0x2110 [amdgpu]
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? update_cfs_group+0x111/0x120
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? enqueue_entity+0x3a6/0x550
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl_kernel+0xbc/0x120
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl+0x2f6/0x5b0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_drm_ioctl+0x4e/0x90 [amdgpu]
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_ioctl+0xa3/0xf0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x11ad/0x25f0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? ksys_read+0xe6/0x100
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? idr_find+0xf/0x20
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_array_free+0x5a/0x80
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_reset_ioctl+0xbd/0xd0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/0x10
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl_kernel+0xbc/0x120
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __check_object_size.part.0+0x3a/0x150
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? _copy_to_user+0x41/0x60
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl+0x326/0x5b0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/0x10
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? kvm_clock_get_cycles+0x18/0x40
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pm_runtime_suspend+0x7b/0xd0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? amdgpu_drm_ioctl+0x70/0x90 [amdgpu]
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __x64_sys_ioctl+0xbb/0xf0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x250
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x250
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? sysvec_apic_timer_interrupt+0x57/0xc0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x7156c3524ded
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffe4afcc410 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 0000578954b74cf8 RCX: 00007156c3524ded
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 00007ffe4afcc4f0 RSI: 00000000c0186444 RDI: 0000000000000012
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffe4afcc460 R08: 00007ffe4afcc7a0 R09: 00007ffe4afcc4b0
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000578954b862f0 R11: 0000000000000246 R12: 00000000c0186444
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000012 R14: 0000000000000060 R15: 0000578954b46380
>>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>
>>>>
>>>> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
>>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 -------------
>>>>    1 file changed, 13 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 2bb02fe9c880..ee6b59bfd798 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2947,22 +2947,9 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
>>>>           .runtime_idle = amdgpu_pmops_runtime_idle,  };
>>>>
>>>> -static int amdgpu_flush(struct file *f, fl_owner_t id) -{
>>>> -       struct drm_file *file_priv = f->private_data;
>>>> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>>>> -       long timeout = MAX_WAIT_SCHED_ENTITY_Q_EMPTY;
>>>> -
>>>> -       timeout = amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr, timeout);
>>>> -       timeout = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
>>>> -
>>>> -       return timeout >= 0 ? 0 : timeout;
>>>> -}
>>>> -
>>>>    static const struct file_operations amdgpu_driver_kms_fops = {
>>>>           .owner = THIS_MODULE,
>>>>           .open = drm_open,
>>>> -       .flush = amdgpu_flush,
>>>>           .release = drm_release,
>>>>           .unlocked_ioctl = amdgpu_drm_ioctl,
>>>>           .mmap = drm_gem_mmap,
>>>> -- 
>>>> 2.25.1
>>>>

