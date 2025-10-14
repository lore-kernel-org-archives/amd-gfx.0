Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37137CCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 21:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE59110E24A;
	Tue, 14 Oct 2025 21:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ydPgSje5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB29510E24A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 21:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d766a6CkhXZ27wOHg2qfBPcbvGv0Wbt4CHbmet3v0VyebBGa/k10Fw3BCRkLrJKvtb5M1HP/FGxYWtxrfzCqPuJ4wChaD7zi3cHhwG2D4ZVq/Aicb+sCsG67BpDi+6uQyTPUE/J3DPX/MjEL83qibOn/gB5YGH30dCTX26GMdr6EZcSdllGyjaq9Gtr2ng6k50UlhvbFbO25z0BTqweAR+DXbFhoLztiuBec0WkpeL3Ts/pONnNhbu4ciYMB+K0ApFRTharglAU0FPYVXAZXgM3xNEjiZIK5sbecGBvRd4Nsvv9LP2Y47IVJuPsnIk5JdrUk4vXq7LEwnF/qUjvGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4H+4SxvLSStB1f4YsjkJPDGnt6pB0aN7hyydxOZt2A=;
 b=NqU4+5slWKf3vqfQOwsz4hRb+CCKT78OVzFRxfA7Eqg0j1EbEnYfRLPUUtOrhl9mwwIyGsjOzUO3Y0j5H22LZ7ZcnF2puXNPnhpL9pw1Ij4v82iDTQExgpxmFJC4fZ2vXyZXfmAqDokc1gEJySOXFVWbgGJrEfUr6ftVd+6aqvowsJpeYV5k+NMlpGop0NhWVo6LAnUuLtJmmw8l5DBa1NmwmvtmVLYm04m+UWlgwh4RU2VRHyUMNY8HH+mg9+1Y3jWfb2g3wxqapvN6v3OoFYWNNayX0mSzWCZJCaj6Zj1N2rlzRIIMeehEZTTo9Ux0nvJHmYZtEJD5xE+vEfLEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4H+4SxvLSStB1f4YsjkJPDGnt6pB0aN7hyydxOZt2A=;
 b=ydPgSje5Nb/LBuL6ff4pj9Ge7TPYQhl9Y42Ito2SqRchPxCpTQa5+JkcpeUNJGE4PDc4kNBdr37Zg3pvbp4OBm8GbZsfTIFYzKH4/4mlbjPspXD9ZLbqXKxaII8m8FlRZSvQNpEcQOc9X19eOLdWmFhuzrEYQwqF9MlePzfSGm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 21:38:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 21:38:12 +0000
Message-ID: <d462f951-1b9d-4390-800f-9af09a7282d5@amd.com>
Date: Tue, 14 Oct 2025 16:38:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>
References: <20251014193036.595453-1-mario.limonciello@amd.com>
 <20251014193036.595453-2-mario.limonciello@amd.com>
 <CADnq5_P-9F0NsOK_5HG06YP98vqJH+1RXxfEnhnAhQ_U1Q=DNQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_P-9F0NsOK_5HG06YP98vqJH+1RXxfEnhnAhQ_U1Q=DNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:806:127::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 552df782-333b-44ac-1f30-08de0b69f988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWRCY1hBb2ZHMFBtU240S3pWbDZJSHBJWDZoUnNNbWNwMkI1Y1NjZXkxY3R2?=
 =?utf-8?B?eEttWDRYY2ZWVjlRYkJyM1ZTQmNlSm94WVNiaUxXdUlKd0NyL2FpMzBubjh5?=
 =?utf-8?B?ekVDQ1ppTG8rQ3dKZUx4OEZNai9EM2hlbXMyUGZYVTVDZEwxeDRQbHo2dUhU?=
 =?utf-8?B?cTcrRkxKQktCWkFDQnZ2cWFpdVZQMGVEbXVHMk9MU2VvYS9DemtkbnJpYVB5?=
 =?utf-8?B?bTdCWWFjN3ZmTjg0VkxaU3ZhRk80aXRGL2RzcnZFQXlSb2pPSkJrOFlNQU9J?=
 =?utf-8?B?dm5mTGJkQzZCdlQwbk1nelVqV2dJVitvUjFyTloxVGlnVkt5QlJXT1VJSU9w?=
 =?utf-8?B?T2xydnhyUE0vUmVkdEwyNms1WjhIYzJ2R3NkSVR5SFpGd3hwOENlTXNHMUx2?=
 =?utf-8?B?M3pyUkJ5S0lsaGh0QThvNmxMVlp1ZTNxaVVndW1BYlVlSW5JU3I0dGNIWGhk?=
 =?utf-8?B?MWNuREZYYVFQaDlqT3pQMlJqSGdaYzdqTHVzVGZaSFpwNTYvNzloRXBTbnF4?=
 =?utf-8?B?OE1zS1MyaXlIVjh6L21hbkFnNklpK3BJS2hYbDdROGxpczVuM0w4WDFNZ0FG?=
 =?utf-8?B?dVdXeFRLbjJxNVVFSWQzRUQrZ1c0Z1BnMVo4WVZ1bWkyQmN2d1BqM3FSN0M2?=
 =?utf-8?B?Q0VWSm0vVXJpL004N0JSVFZTWHVOYUZJbVpqZU5MaEc3aVlNTkNxWGpQZzRt?=
 =?utf-8?B?ZzI4MlY0Y3FpMGZpN3IvWUZ1a2pHeER2RVUvK1ZVQ05tL0xqYXdaTm5Hckx1?=
 =?utf-8?B?eW5RUitPcjFWNmNLdFRUa3Y5OGZrTEU0Z0kzTDVUK0dTR3ZlZ1o0SnAyaXNk?=
 =?utf-8?B?QnlWREdCM1ZSeStLQUV1UXVOY3F6djM1eWRSdHFWVXd2NU1pNTBHVjRWNnF1?=
 =?utf-8?B?cDFoa04zWnVmTTNBR2ZpRHBLQkxUNGM2V2t2R0MvdVcyY2ljSmpxZGFqYUxp?=
 =?utf-8?B?WUIvTm5RdEFRN0ZMbHVFOHlsbDR5dXhMQ3VxTUMzZVBhV0dMcE54NDl2L2My?=
 =?utf-8?B?YlZSWktaZit0Y0R5WXRLQUo1RFhYTFZkNGNkdEh3ZzV4Um13Mi82RERwLzdB?=
 =?utf-8?B?emNRQzZtSTA2RWF0eHF0bUNnRW54ZXBrR01LNXFmUG13Vk0xdVdxMFYrS2VX?=
 =?utf-8?B?VUdzZUtVaFMwSFBhN3czUW9mMHdmUE1LS21Fa3N4bGs4VGpicXFHdWhMcnpZ?=
 =?utf-8?B?MjEzWC9SZkVYSVl0RjJhYVhwbmoxNnNWZ1NUQmo4aFVwSVVubGRFek1oVjdS?=
 =?utf-8?B?VEoyUVNzUEJib1FXSTA0OE5MRjBMMitGaW1zY3I3blBXOG1xN3hLQnRiZzNB?=
 =?utf-8?B?OVhLNnVyYzRGSndXOUZmV3pidDVjczNnd0RMaFlUeDJqTTYxT0Vlc1VrL21z?=
 =?utf-8?B?TGQyUUFjN1VOb2pQZUQ3aGhEalh0cVZtYW5EdThkSi9XSGpFeWFVeUhYMUVG?=
 =?utf-8?B?WDNqZ2FCcnFnemVsQ1pHRkJBcExMNDMzUkJIU3JEdURPYXVPUldEdnptZmZ6?=
 =?utf-8?B?d2FBenVJN2U0aGJxcmlQVnZKS1E0V21QNWwzaU10eXJKVGFpbk5WU2I2VzFK?=
 =?utf-8?B?VkRJN1p1TTBPTWpZN1c4RTltTWVFb0VJcDNNN3NGMXVmMERtdHpORDdkejkv?=
 =?utf-8?B?SzN3dy90b3VIbWpGQmQyeWh6NW91bVBMcWNWalFjVGpjTFZXbVBRQ3ZWR0lp?=
 =?utf-8?B?eXpOaktHMWlzaUpDaWpkbDRiWDdlWitia1ZvM2pmM3Z3MmEwTFp0VWhRczB6?=
 =?utf-8?B?YUFGQW9TU21uVmY3OTBMaTNZQUpxNCtWdmtXcU00NGtZOUxQR21Zb3l6MVgy?=
 =?utf-8?B?VTBvK0orNWc0T29jQlpoVk51MmgweFY2RWZOaFY4bHBBaWZmVjIvQjdWbHJL?=
 =?utf-8?B?RFNRVThHODBLZ2dhcjNuK0d6MWp0WnM1RE1FMG5XNk8xOHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRzOWxZL2dzWTUwNzlPQVJYZ1YwN0dJUkNLQVQzeFpsemNObFVjcHRtWm00?=
 =?utf-8?B?QStUVkJTc2lZcDNSY2JnTjBiemEwMCsrdzBjZENUMmd6eDZRMG5xRFloYy96?=
 =?utf-8?B?eU1ZTUY4aG9YcnZYQUw1UGJZZEMxTHBTRUhiblZ2UkJ5VjVwMWtJNlBDeGdq?=
 =?utf-8?B?OHVJOUcvaFppaWpNRUxwZ3MvTlFqV0Q4WW5wbFNiUklkNXIrTzBlTUExNDRC?=
 =?utf-8?B?VjNyM0laZU5velUzK005OFNJaXIydTA4dkxaUXF5QXZ5Q29rNzVRLzN0Sy9Y?=
 =?utf-8?B?V0R3QkpmSDZ1c2IwK2RYTGFaZFUzS2NOdjBuNk1tMVFoSVZKaU5aeHdaenNs?=
 =?utf-8?B?ZjFVNklaQ3pEODB2YTYxQWpyQVZSWlI1UU9JcWtxZ0p1aS9QWEl2aVFFLzBK?=
 =?utf-8?B?a2QxTkZaVVAvVldGTGFwQ3dBQXBFWWVFK2VqTXBuVmRsYWdCdW9lcHJjRWx1?=
 =?utf-8?B?MlFPOWREa1pYdlpCcEpqNXlBUmUzSm1POERobHc3SUhDNmlCN2JCSE9zM0hi?=
 =?utf-8?B?WG0zQlczaytNQzdmcFUzelVYL2hQUUtuYW1YSmNpYUZxQWZqRWUycXpQenph?=
 =?utf-8?B?THM1Yy84VC9jMHE5UXFVNUhhZm4vMG91czhyeG5HWDl6aHJmQjZmV1Q4M3pF?=
 =?utf-8?B?eStpZCttUzI3bk4rb0RuS3lvUjlkTFhEbVNkSkpFbWJjU2g4VUZkZkhZZ0h0?=
 =?utf-8?B?c1V3L1BnV2pjSkhLNkhFZHVVdTk3SVJCM2dCOFNOTWZMYU9lVnBQZXFFTUdl?=
 =?utf-8?B?SlpiVmlNT3Nad1NlbGd0VTg4UFVWM2ZoRTFieVhjYzZQVkdoY0IzUG82MEFa?=
 =?utf-8?B?V3hYeWJ6cXJ4akRZVTF0S1B3a1lNenZtMzMxOHkrL2d4NW14TXBoZWJMQ2V1?=
 =?utf-8?B?ZHQwSk5FZGMzcGNXZlJuaFp1SVJUOW5jNlFqQ1V5dFBsNHhjUmJaSURVdlJN?=
 =?utf-8?B?R3ExWWxUTkZtNHJnaDl3Nzd1S1dMV0dtY0g0S0wxNmdzRmtsY0RacFFBZ250?=
 =?utf-8?B?cW9JS0x5OE5BZGdoYnQ0UU1JdGdIOHpwekhwNjVMc2RPZ012a0F2bGMzQVY2?=
 =?utf-8?B?ZXBTQUNMNHEwVEdnK2krSWZlU202M1RJTkxRdEJSalRvVXpwYTJuN3NIQzcv?=
 =?utf-8?B?aXQ2d0F6OTBpOWV4KzVSWVFIcWtqZnhkeHdTQW5yLzdLa1Q3NnNIK1Z5WC9D?=
 =?utf-8?B?VDhxeHlhTFpUeC9nZURVNzFOZzlqUCtWRFpuN0IyaytIS1lmS0ZmK1I1cnRs?=
 =?utf-8?B?cUttUm9pcmZDTVZyYkZCWnIxOXZUSzQzdUN1elJUTjl5K0M2QUxMRXZuNSs1?=
 =?utf-8?B?MlhLRGF4N0JqM2h1TVQyNkwva1l5RU5yZ3RURW5iV3BxNlFJTTBSV0pXcXNr?=
 =?utf-8?B?K0phQWs2WFJ2YVhES1B4TjBwZFQrSzl2TitmZWZvVGdjNXhmTHFjZitrR1I4?=
 =?utf-8?B?SVpXY1gxNVZwQmFjcHBBczh0amZ1eXVjekxSN01LNTFYNC9TQjFZNldTbTR0?=
 =?utf-8?B?V2U5VDlvMDVDQi9XbzhjVitRclBwN25zZXNDM29SMElCS1F3Q0xvakZmcDFz?=
 =?utf-8?B?dWt6ZWxVZkd5VUpkMW5GNi8rdnduRmd5U0xEeXRGMWU0MVFQeDhGZDNWUUNW?=
 =?utf-8?B?bFVIRmtjNGh6UkZQTFBMd2wwa1k3aGxaUDRuTTBkUEl0a25yU1djRFV2enZW?=
 =?utf-8?B?c05IbWpqT29HbGlVbjljZTlhdk5aWVhpWWwwL2NubEJBOWpOSnU3amNpOWdE?=
 =?utf-8?B?MWFxRjNybFU4K3g3MlV2ZzhPajJYclFLMXhTTkFRbGgrQkdHSUNBVlY4dDVS?=
 =?utf-8?B?bnYzdzN6ajM0OHA3dTJIVVZIUE1mR3NnYVMycWh6NExxYXd6U2hYK0JwSCtM?=
 =?utf-8?B?Q0wxRUlJRDZBeTVDZVJEdytQS1huRlN2Wms2WmN3Z3hmR0VRdlJyQ2ZLUSth?=
 =?utf-8?B?N1FHK05xVHdNYWoyK3pidE1RYzVuNHZHc3hLT0kwY081Vi9TaDBiOUxCNjZk?=
 =?utf-8?B?emJRV0k0bTdTOUtRWU9xNUYwRTc0L0tzcEtnLzVac3c2Y1UxKzdZZUltQ25R?=
 =?utf-8?B?MkIzSkFjd2taTitNV1prb1FwUHdwQ1FsQk5aTkIwNEREaHNSY0hMY1M5WHQv?=
 =?utf-8?Q?8mQ9QEqbqAKmbUXDSe4Vjw64q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552df782-333b-44ac-1f30-08de0b69f988
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:38:12.1377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpM9dAU/TGAItXbAOsvGneefBIkLaXgGTUwQEYvpSxYs43zs+yojiS0D9ewQ3be6gySPmuju0Y131uJ0psLgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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



On 10/14/2025 4:27 PM, Alex Deucher wrote:
> On Tue, Oct 14, 2025 at 3:46 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> [Why]
>> If userspace hasn't frozen user processes (like systemd does with
>> user.slice) then an aborted hibernate could give control back to
>> userspace before display hardware is resumed.  IoW an atomic commit could
>> be done while the hardware is in D3, which could hang a system.
> 
> Is there any way to prevent this altogether?  

The obvious way is that userspace should be freezing user processes. 
That's what systemd does.

> This seems like a recipe
> for trouble for any driver.

If we want to uplevel this kind of check I think we would need some 
helper to report hardware status into drm and drm would have to call that.

Most distros use systemd, and this only happened in an aborted 
hibernate.  I guess I'd like to see how much this warning actually comes 
up before deciding if all that plumbing is worth it.
> 
> Alex
> 
>>
>> [How]
>> Add a check whether the IP block hardware is ready to the atomic check
>> handler and return a failure. Userspace shouldn't do an atomic commit if
>> the atomic check fails.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> v2:
>>   * Return -EBUSY instead (Harry)
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 6446ec6c21d4..f5cd9982af99 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -12010,6 +12010,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>
>>          trace_amdgpu_dm_atomic_check_begin(state);
>>
>> +       if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_TYPE_DCE)))) {
>> +               ret = -EBUSY;
>> +               goto fail;
>> +       }
>> +
>>          ret = drm_atomic_helper_check_modeset(dev, state);
>>          if (ret) {
>>                  drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
>> --
>> 2.49.0
>>

