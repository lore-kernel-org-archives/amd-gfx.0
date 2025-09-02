Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99E0CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9DC10E5B7;
	Tue,  2 Sep 2025 06:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BiGT2iXa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F5D10E5B7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 06:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IawXMsUFTpaI2JQNK2FqmrKwita7cB6pznrZ+Ia/Jwu08rQpzsSeT2v8GMGJXbU0gJXhLNpJ+LkAcONVIZeSY6orVTw41b2BBVhSZrBkK4nyT9ny7X43K5FQGfbvlieD1hIEf/zGqiz9ZUO/72YjbH1rAMRyydd4nhBCOahkcOlpibkhx85fmyMxplGvoeWJIq0ngxVFJ5A2R4L+0ogynm8KLYPDF2QX+usMg26sdwAL+4MBruOT/fyTq3LOTJ+U+UDLU+Kt95XGbpDW9Vad9YiDh5wHxKBQ/fBKbqNmXd0YYwyQStvATg1dt1I9fD3v9GdbHdcYYjOAnkKVk5tXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u0Hcxv4ZWyCor17Umy+tRxZYo1DnQoXaD7gSe7BQw8=;
 b=i5MXVjAyOxO5Lmt6WHNHP5gmrMIvjE0QtIq9dcXz/3vRpLdCAe2cfBk/qV95AWNhu4mY8BadTWHCkg8jilbDX6rqYiFUekkYBdG5WWReG+bwUGJhRs6OnPRZ1IrHE5k/2v5SYxCK8zx7X0gi7OBwI4QD7xB/mVoMml1OWmlSfQ0JP/lHftkiMpkANV4Au/mz0U6pGo6Rb5qkYJreqn2vKvd3VFhJjwDWGhRYGgLEEGomqjgF28e8leDxPYbCTctrWC7nKr7A0kMxEOUYBPX3k+GOPXOug5ICSAxIsV1CaL7+KQW6+p1DuIWwv+ggM66yRSA+dSuCSZcMCPqFHuuV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u0Hcxv4ZWyCor17Umy+tRxZYo1DnQoXaD7gSe7BQw8=;
 b=BiGT2iXarQuxW4w/38fjnH2szfHSpR0h6sq+cqoXcS2rxwwpc5tjddDEKscvjvSX7RVe/HVB9K5uQaoiTAOepBE5/8y6FFMQJsW/Aw42bt8BmAdJT+NndkDqk+W3u2koBmh1xOCD/L62EBcxhD9MshfH5isLvshQdQruMf4+Pow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 06:45:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 06:45:27 +0000
Message-ID: <7c10ac6d-93a8-41c9-900c-50261893d482@amd.com>
Date: Tue, 2 Sep 2025 08:45:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-4-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250901100012.439155-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: f07e387f-e564-40f4-1dba-08dde9ec4d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGVuZzFhcm56OFdPZ0V0TExOTm9uKzhSRnNHVHMvNWVoYjlPMWhXSW5HL3lC?=
 =?utf-8?B?ekExZ3BlaFhLNmtvd1VuaEFvVnNRWGRBOFFPVTB4RXJZTEk1ZjhGVUlnemVT?=
 =?utf-8?B?TWFnem02RUVWTG1UVkcyYXNpWUt1MHFxcEpqbnF4VmxyTmxJNjMvOS9wcjFE?=
 =?utf-8?B?bTNpNUsxY1NIaFNGQXRZRHFydVFGRS9GUDkwWU11WjNVQmg3amp6d1kxSCtm?=
 =?utf-8?B?TlZsOGRQUGhZUGF0MjgxMERSR25uQ2V0OFJMWUZyMis5MGI0Z3JTYytjUjBD?=
 =?utf-8?B?TjREMkRiV1poVXluVXlxNGE3dmNDV2gvUkdvdUdCS09Sem1PeksyMnF3WFd2?=
 =?utf-8?B?SDhSZ1NqcWlFUlBSaWlCanZVVFRlQlpSdldUNExhVFFNdmFDanF0TWx0c1M0?=
 =?utf-8?B?VHdPQWdFTEtBZTZXdHphZ2diY1RCcm5zQjc5ZmdTLzZ5MXRoWEdHOURIWDhm?=
 =?utf-8?B?bkkxZFRXS3lNTS9uY3h4N012YytybXBIUm9oZGl5K3M2RlNYenUyZUhqdjlt?=
 =?utf-8?B?RDNoWU0wZ3FpNmVHZ0VzbFJ5bEpvRDF0OE5XVVYwS1ZBT0VvRXREcERXZDNF?=
 =?utf-8?B?Q3QrazRhanJKd3l2c2QwYmdZODZFcUpkb3BJYXd6cFozQXR1ZlVZc05kOWlu?=
 =?utf-8?B?dkpGYnpKdTNjSDVLa1oxNzRiMk55SUNzcFRTUEVBRXhWeVQ2NVduSGRrc1pD?=
 =?utf-8?B?bERQWEdQRUlWbTFHWll4MkF3NFFSQ2NVMjNwMitxMG56ZGZKSHlYbGFRY3Vq?=
 =?utf-8?B?SHNnTm5YbGVKZ2dPR2pkQ0ZLMzR3bVdBZWt5MmdjdUN5U3F1ZlZ5TTVXYkpq?=
 =?utf-8?B?VHdPT2h4OC9uUWZjTCtPcXB6MHBRc0V6NDhFMU5nODh0bG8yK2YvSVJPQk5F?=
 =?utf-8?B?UGMvSnJMUkJmbmx2eTZ1THdJOHNFVUJYMzFUcTZYZGpqRUQ0RW9hams0VFBl?=
 =?utf-8?B?SkN5STlUOHZnelZtMnlHZzR6aGZKaXhNTkJUTFF3TjBuOHpOWXU4U2thUmln?=
 =?utf-8?B?WEh1SEU2ODM0UWlGazVIeXIwUE5oSHF1QnpTNTFFTzNsU2JxUVlnSEhVZmpL?=
 =?utf-8?B?bmMzVGhCTDYweEVaZTVjUndJM3I4eFBXZm1rR2ZrYzBXZ21YWGhuVTFZSVph?=
 =?utf-8?B?YmRGSGhFRW9FZEdSMlZiSkxsa3BITTNlT1AvM08vMkhDZ0lHSnBwZXBsZmZR?=
 =?utf-8?B?bnN0U1dGRkEvQTJrTEpPQWxGaERvaTNremVzdDZmdzh5dlZTQS9XQkdVR1Q5?=
 =?utf-8?B?QWxMOXozNEs3T2ZIZjBUQ3p2VlVtT1JsVTdnMFRkM0dtek9oZzFOeExKYkgw?=
 =?utf-8?B?UzJEc3Q2cGtTVmFaREV6THFaaWVUYnZFNXpxb0EzMktldXBLS1pUVEM4dVNB?=
 =?utf-8?B?dzdmbXNRamMySkdNZXozZzBncUxTSXFTd1R3UmhhOWg2M0g5R3paZFE1enUr?=
 =?utf-8?B?SXVFY3dMVkx5MHRsVjNSZG00WnhDL2lNc0g1SGxoV2NJNXBEaUpwcTlRQ1hi?=
 =?utf-8?B?M3lpUFNBaE9YM0lLaU9ySU05TW1GRnRpSjVVQXVLMlFrNFg5VHJ0dTB4MWNO?=
 =?utf-8?B?dzdSSHpXUXRteFVYRXZrNGp2alAycGJ2bG5XZUNTQUJsblEwRXUxdWxsVSsz?=
 =?utf-8?B?b2RvQ3VoaG9HTUlBcXBJS29nY1JORlFKT2M0eldHMjRiRzdFWnFTRWRaeXdS?=
 =?utf-8?B?UUZmcWhFVVpRV0d6aWpWSjk2dW9lbU5Uc1RUWmV3alArRnZFb1VvNUN3cldn?=
 =?utf-8?B?YWNObE9RWjN2MnRlZkQ0ZXpuWG12TU9tRGxBVFBWeGRhV1lOYm1lVithSnFt?=
 =?utf-8?B?QlZGMTJrbktCNk5HZGU4a09IR0pXT3BkWkVpNWpnRHNjNW51dlQzUExONmJ1?=
 =?utf-8?B?a25YbjhsRG1hQyt3OXk4VFpaTG0xK2JDaXRNajJmYUVrMkpZaHlCVkNhcWdI?=
 =?utf-8?Q?t/SfkG0RfHQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGo1TzdyelRVNVd0YklMZHk3L0dFZ0EzMFhRL0s0UzAvSXhQVDhXZnNIRWlp?=
 =?utf-8?B?ZzNhN25wdWhoVWZwSU02YXdMR2YrRktHZVVRdnN4OGJtV1NCQ2RuNGI5a0VS?=
 =?utf-8?B?bVdXNCttYlV3N28zbkNUcU1CeVhFRHdOMWVhK2hiWjZZUTZRNkJvRHBkdmJx?=
 =?utf-8?B?ZkpWd2pvMjVIMjQ3amZpcERycXNYNlY0OFk1Ykhtc3JKM3VkZEp4dWw0K2hH?=
 =?utf-8?B?QVFpdTFLa0xlMWdhUHlLWDlvbVFFczdIdk02REtrRjRSQVVlajF0aFc0dFg3?=
 =?utf-8?B?K2tMTmlKVHBRdDArdEp2QkVrVW5MSXdFSVlxOEpkbTUvT1JOMTEydmxaNmNu?=
 =?utf-8?B?Tk9ldkhHa1hqT00rOTVDZEpIKzdqV0o0Zjh3SHM3R05VNVg0dk1mdGpTeDd1?=
 =?utf-8?B?V1BwWWwxVUxJK3VTbHNRMUpVeDh6TlJJQWJHTnc2bGk4TGVDT0kwRFNZV0NG?=
 =?utf-8?B?NjBjRnloc0lGRlFEVU5zVDhZZHVpRjZ0eDhzaE1RbEpIQ3k1bzRKT0lzZ01D?=
 =?utf-8?B?K1dMTW4vWmROV0hFZFhKMVVDdy9pVHd0RFM5c1kzamNsNHNlS0owa2lsNHRu?=
 =?utf-8?B?amFTS1ZLV2VaSWczdDJraVAyYWVDUE92Z1hjUEtRc2QveTIwd1ZGTEJtbGRX?=
 =?utf-8?B?M0RlNUFZYjB2YzZDRFFnWGlUbUVGelY5c3grZlM5YVovQ1BCaEE2dFZ3Y1B0?=
 =?utf-8?B?QTFMSE01enNRNEVDeWVHUXI2UU9QdjBjd3AzRVhXbFVZWjZFNE9ORUF5ZjRW?=
 =?utf-8?B?eHN1aDZCZ0E4YkNzTEFyVGFyWUpiNDNxRzdhakZYSGNwMkFNRk9RdDZyamlW?=
 =?utf-8?B?d0c2cldtYVBUd040QkxIdWNjWU15Vk4vc0JKZllsUkpJY05QRGZHQzN6L2J6?=
 =?utf-8?B?VG0vQ1RJeXZkY3hrQWZFV3pQU2hCd2ZYNUVHbklzMVMwMjZHSGRQUmdRUHdt?=
 =?utf-8?B?OW96VjFCcjBZVnhsK1dlSTBZMXBWTEdYaWc1bTUyOTRNUlo2aXVCay94aWtR?=
 =?utf-8?B?ZUpSV09LWmJHaDRjRXlGZVlUNEpUU25MS3NPKzNCdlNvR0dGalNlNkRGK0VB?=
 =?utf-8?B?RHp3SEE0TzcyZ2U3V0pPcHJLMGJIRndYNHI4bDJwL0dwc01mSGU0aGh5ZkpF?=
 =?utf-8?B?M2VOM1RSbTRNdEozNUUwc3FWOHh2WnF2RVhKZ25jbW9rQ0JOSEtPZi9wempm?=
 =?utf-8?B?RzJWZ3JERGtGUTVZVzFDT1BEQWFML0kvV0dYNXVwZmFxZ2ZXcW0yK1IwVjdH?=
 =?utf-8?B?UjJSYUg3OHpPOG9jOGdrbEVOUFUyVkJJL3lKcXBQa1dsK21mUDc3U1FLWm82?=
 =?utf-8?B?emdQK1ZqOGsvK08rQk1sUGlCSlpLcU9WNTdwVEpVenFDeUFBQlFPN2J5UXk1?=
 =?utf-8?B?dnpuYXl5d3BKZmhXUlhBUU4wOGZ0MXZhbkxNZjkzamhQV3pobktWWWQ1ZllZ?=
 =?utf-8?B?UzQ2T3Yrem5oeDZQSHZYRVRCVUYzRnp5NjA4Z1M3RGY2enRucElFWjFlRWZX?=
 =?utf-8?B?YXcvVWVJY1laZXArd01VclplVWZNMEQzV2puTXMvVWlUSFZEUk94ZURFQTFG?=
 =?utf-8?B?WkJsRHdlMFVlakV6L3NtN1YveW9UUE1HQ251T3A3YW1MZEJDWVNET3V3T1VY?=
 =?utf-8?B?WU15N1JpMXM4Tzl3U2hWbkFDM010REc5TmYzS2ZFZlRWdGE1V2hJTytWUEVF?=
 =?utf-8?B?WDhNaXB3a1ZDcC9SMkRPdTFVVVhMUXRRRXFkM2dQU29qVWJ2ZmZOc1Jjb1lo?=
 =?utf-8?B?cmp2TFNpVVVpUVpGTWhmQWo4eVcvejBrdGJlSFVBWGhiU2xBa2l4RVd1eTNZ?=
 =?utf-8?B?b3M2d3ZFSmlUQ0hRODdQajJTdkdOY281TkFYSXkwNmVJOGNoVHJqa2FZV0kx?=
 =?utf-8?B?Rm1ndUo1aW84YnZUeXBvVStOTytEcXcyNDdnVWtBcDdnTVdTVDBnc2dTcGZI?=
 =?utf-8?B?bjdYbDVCUVovM1ZQSnpsK1ZqN2l0U1VyZDF6Rkh4bU5KZ3pnMlZsREl6VlZS?=
 =?utf-8?B?QWV3SXpzZlEyR0pwWlkrR0hqVWdsSld3WGx0VFFSY2NzQzFTNUh4NUwvcTRI?=
 =?utf-8?B?V3Rwek5iOTdtVTNCOUNVYVJDaExjVHJKWDhSclorNFNOMnFRSDZVWWtKcmVY?=
 =?utf-8?Q?yJLy+8LPiVCJ37NIbrFupyEp2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07e387f-e564-40f4-1dba-08dde9ec4d00
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:27.2864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFueezwGNmgV1R3lp+k1NVDNtddgXpMWb8l4WxVe50Gp1KaU73Itcu8rxjgvpX9q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

On 01.09.25 12:00, Timur Kristóf wrote:
> SDMA v3-v5 can copy almost 4 MiB in a single copy operation.
> Use the	same value as PAL and Mesa for copy_max_bytes.
> 
> For reference, see oss2DmaCmdBuffer.cpp	in PAL:
> "Due to HW limitation, the maximum count may not be 2^n-1,
> can only be 2^n - 1 - start_addr[4:2]"

Is that public available? If yes better reference AMDVLK here.

Apart from that looks good to me.

Regards,
Christian.

> 
> See also sid.h in Mesa:
> "There is apparently an undocumented HW limitation that
> prevents the HW from copying the last 255 bytes of (1 << 22) - 1"
> 
> Fixes: dfe5c2b76b2a ("drm/amdgpu: Correct bytes limit for SDMA 3.0 copy and fill")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 1c076bd1cf73..9302cf0b5e4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1659,11 +1659,11 @@ static void sdma_v3_0_emit_fill_buffer(struct amdgpu_ib *ib,
>  }
>  
>  static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs = {
> -	.copy_max_bytes = 0x3fffe0, /* not 0x3fffff due to HW limitation */
> +	.copy_max_bytes = 0x3fff00, /* not 0x3fffff due to HW limitation */
>  	.copy_num_dw = 7,
>  	.emit_copy_buffer = sdma_v3_0_emit_copy_buffer,
>  
> -	.fill_max_bytes = 0x3fffe0, /* not 0x3fffff due to HW limitation */
> +	.fill_max_bytes = 0x3fff00, /* not 0x3fffff due to HW limitation */
>  	.fill_num_dw = 5,
>  	.emit_fill_buffer = sdma_v3_0_emit_fill_buffer,
>  };

