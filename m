Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B1CD185F0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC1610E70D;
	Thu,  8 Jan 2026 13:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2VVtkRy/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B1810E70D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 13:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVlF2CRNG7B4mr6LGwO0Cf0C84dOSqFffF1yFXBWHCwMjV6W7CQl8IyT8OLYxjmLbVia6qiyGEZd3hyRmypY1rO7KTkjA4Q8vg1qY8XhVH+cUhbHBsp8Bp6nuMBANxTpH1lp0f0sFig+5f8n/6OKAJ0029MPpMuwm3hPn68ObUZr9S9M3Sxy4OC3QI8b5t3+FaGopxGASSiS59i8JlPimj16lRTQO/rok8phgBZi7f1U/m7MwlY+W2CiyXCvRlgd+pLA2MkX9tYgISCQK6jyU3pZw/H/8tmrPqhcn71rUD0iux7RtYagttfKNHeyDD+LQEVKxdi+RoVGIMLw4GMV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WlpknQSae7N45zSrydE5MiD3pQJkqVkK89mfDwbLgg=;
 b=JlRKYFEyvof7ALxDf0u9E12KLs9qZnW9PRtcaokdEAfLsh22u+7l4QOkInPEfY5cfv/4vDsRiO5151Hktt0VAgWSM/fcfAKhCyk9gIC15ktRdjNZrlghNcMJxkrtZ1+6JwAybyDP/2E5iXRIC7/2wF2HloLzk7XvdIzWavvTK+su+MtdO05r/IhC7IOP4bcBYfs+j5b+iLQqPp5VGPhQ4QPho1zP89RG9jHiLcBMRxffOhkFQU4d/Jv2RP9u7s8zxZsdKeyoWacdbvnh+NYisZtI1SYvVfK1rxqUxfdvRyHaKRELBOGsjv2m7DSYwf+JaGMxucCiHujaPfqZ6bEpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WlpknQSae7N45zSrydE5MiD3pQJkqVkK89mfDwbLgg=;
 b=2VVtkRy/P3U8LNVVziO3iD3mxKpKaHPk/nYloq0Bx/T2s+w0rTfwmd8djKcryy6otOFfa1y9UsPvbeR6CBbxLQhbNNh8hp18VHhhd7uPHlIODNCZn8Rfpxx0vEagHAA0gLdUqbvlPJSkFj+lSdJtalMe1upTi7u0v3r5vf6LCXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:24:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:24:35 +0000
Message-ID: <1e27a702-2a76-4c61-8fc5-50a9187fe7e0@amd.com>
Date: Thu, 8 Jan 2026 14:24:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com, kent.russell@amd.com,
 jay.cornwall@amd.com
References: <20260107192341.3521748-1-Philip.Yang@amd.com>
 <20260107192341.3521748-4-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260107192341.3521748-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 907818bb-d965-4370-5946-08de4eb9446d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVVzVUY5bi9qTWo5V1pobHVGTE1iV2p5K29EOENxem0vLzVzL3RBUzZZUDMy?=
 =?utf-8?B?Z0MxRGZ5bHpOL0R3bEQzbExtdFVGV3QxZEpVZlliT3kyKy9acGFHRzRJNXps?=
 =?utf-8?B?SmxuV1lOb3U0RGNHSGFPbXhwSkg3VEMvbUVsRnp3bWRDT28wREhpUWkxSkRU?=
 =?utf-8?B?ZWhBRlVXWWVlWlZmK3ZCc3UrN1NsMUpORnNBWnk2RW1ZZjlZZVltSndiYlU5?=
 =?utf-8?B?R1dKcW8rMDlicUkrQU5zN25yTHF0WmU0aFJtTjRyVDc5ZXBLUzRaUFlzVHBy?=
 =?utf-8?B?bExtRHNsMHRKdUxTZHdkUjQvczh0V3RCZW95TC9jWEJ4V3VVL3Y1Y2EyUG5G?=
 =?utf-8?B?QU11U21WdS9ya0JCM0J1N3BHbUJ3MFE4TkxXUG80Z0FSUkxwSDU1YU5RV3Zu?=
 =?utf-8?B?dkVvYWMrY0l6U05idlhMYnFjOGZseWdiRHBxeVZ1a2ZCQ0p6bWtoYk1KckVD?=
 =?utf-8?B?V05SWTNKa2h1cmIvU2dVTGU5YllqRFl6Nzh6aTliUzdoS2RYd3dYaTlLV2R1?=
 =?utf-8?B?OWNHYjFMbFhUWTdhd01LWHRaTzNOd1Z4YVZhY0VtQmdXRVFINjdjZTJQZkZs?=
 =?utf-8?B?cjgzLzBZd0tJK2tnRzkrTG1NWUxoMlBxanVxZXVqWUo0K3RyMWFWZ3pvL0Rq?=
 =?utf-8?B?Zm41TTN4RHAzR1hkV21FRjhIdEZaT2xBcEFTRi9tRHhmemJkaDlNWnF0MXRB?=
 =?utf-8?B?UUtOdDFUb21GelJ0NlNHRUZySjZ0d01RdGNkRDh1UmlKQWNhOERZcHVPaWln?=
 =?utf-8?B?ZkRYOC9ZSnUxMldrVmU0ZWwxQWV2empFOG1PbHo3MEQ1WWgzZ041T1FzSm5j?=
 =?utf-8?B?TG85TkVyZXN3bjhEeGhtQ3B4N0g3RHF4eDUvZklCckZWVWxyZXE1TmhTaDZH?=
 =?utf-8?B?SzZETUpVdml1MmNGb3IwZkQxeEpaUHAxWS9hVmMwbEdqV1NObDVra0c3MzV0?=
 =?utf-8?B?MDExR2NBbGRVSStFK3Qra3VGUW1hYTM0UnR4Y1lVMklvb2Y3VEQ2UGlxdGor?=
 =?utf-8?B?TjhZQmRQMVF6NlR0V1cxVVI2d3FLNzlxT1VmNHZSWGIxaFpvQy8vN0p4Y0xD?=
 =?utf-8?B?NzZJU0tOS2tvbXhNY1FPSXpTcTE5VFBpSUw2VGZKUTd1MGdETG9ONlRSTUVr?=
 =?utf-8?B?Z2wwbjFMUE5PdFd6Ny96TmpJR2lvZGowMDFtVC9SdThuWEZqdWh0MW9yZ3FZ?=
 =?utf-8?B?VWdCemI5R3Fvdm9pTnhTSzVDdVBBUkVhaHpnV0I1b2ZiMFdKeUF2SS9YWW5m?=
 =?utf-8?B?N1lLdEVPdVJMS1F1UHdGeWFXVVA2R2g1ZG1kak4raUx5UWVtR09FdWhTZUpy?=
 =?utf-8?B?bU5iZ0ZDKzY1ZjdHb0t1QXF1RjQyYlY1cnJWUDZXQlp4eFgwbGdEZzBHck9X?=
 =?utf-8?B?Z3Y5TGR0ejFXdmZWQ1lLWjZjeEdpSzhMWjI4Y0Q0U1dNSlFybFlyS2E0MUZm?=
 =?utf-8?B?TFNIaHZ0L0tZOGhMNXo1MTVYdHdNVzJyL0hhRWM0UGo2UTBjb3lLMXNOWkNM?=
 =?utf-8?B?c1BONGxCRktLblltSWdxWEhBaW5kWkw0WnJYaVRjcFFYdHhuZWtRTXdWSjNC?=
 =?utf-8?B?elpuOWVLSzNaVHVVWjBWblAwb3JaUmUxTFlnY1hDU3dScE9YY3BNNHdxdEtD?=
 =?utf-8?B?ZXRrTm5CY3RNcG1LMHFrYWNXVjlwWHpvcFpteWZPUFR5Ri91cm5iTXB0alRq?=
 =?utf-8?B?QUJmR0U4YnR2T1pvaTVRZEMrM0RlaXJyUHlKelM1cWEwRmkzUVV3K1JlUFoy?=
 =?utf-8?B?THM4RExGVW1jOWt4VmZiSWhpL0Y3SzlxWHNOeWozLzQ3TFl1TXhsYW1WSVlj?=
 =?utf-8?B?aXdkejhVbEZnS21sLzFDMFZ0WXhiTDhBUzF2cVdOUnRQYThpN1g5VjIvVWJO?=
 =?utf-8?B?MEVIQndyb0laWXNtTHFCYWtPNnpRdE5tWThhSTEvSDF0Y05IWlpVSy9CT24r?=
 =?utf-8?Q?CY1WGtrkNcyZz/Bx92xs66RYLmHZ/BlL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUlITXZuMytGQU9QNHJDZmhFV3hsUjVFRHl3SkJWL2RQdzQ5UmRhSFRUeUpm?=
 =?utf-8?B?UExzbWxzZXhkZzMwdVB4d0tmOER3Y1N1dHM2WEhDTXlQdHlhUVE4ZFhnTVdl?=
 =?utf-8?B?M1Y3ajFsa0NsMzNDK3JRYTVuQVkrSmNIQ3VZQldIdERWTmVoaEF0eFRmRW9k?=
 =?utf-8?B?SElIeldSdC9JMkdqWGxIREVIRWxqUEUzQk5zeEMzUUNEcWpZazFKa3pOVVBE?=
 =?utf-8?B?ZlRRV0RPa1labzdvMUxVU0xUWit2WDNuaTVUQ3Qya1J4ZXBWOTF6eitRSFlu?=
 =?utf-8?B?UnNsSERaNjc3UUQzSDBabndtU25BVnBISTJweEdGR0ZxNWF1RG1GMUNiUTkv?=
 =?utf-8?B?NjgyLzdUK3pKdGhtZndreGpkUlRPRGVOSTV0UVA1bGRqalFHbXVBSjliMy9y?=
 =?utf-8?B?TUlsWm0rckx3RWpvMUpZc2lsN3lyNXJBZXU5R01CRW5obUxYc2JyRmxLM1cz?=
 =?utf-8?B?bHU0UFNpdWY4bm1CbXkxRzFCMk1pc0N4Rll1aXUvY0JLeEI4dmhhSVprdkZQ?=
 =?utf-8?B?RDQxUkFTOEhKYVpXMEF4TUl6cUljQW9HaU50OEFORmFhV204WkRab2VFZU1S?=
 =?utf-8?B?Tk1qTmVNMTFtblhZeW5iQjNCOG5ieW9MMk5vRFlENCtMUVR4dUlCMW9iM0pm?=
 =?utf-8?B?VUNmSDBndWgwc3FrOGxEVG9QTit5bjRNZ2k2T0ZHNFBTRGJRMEJhNTFyTHgv?=
 =?utf-8?B?SVFNMXo5QVI1Vzdad1NBMlZOejVMNEh3TjZtNXZyTHg0MmdMcWNQbW9aWUtV?=
 =?utf-8?B?aVRKaHJXeFRXSUtUbjBaNGdUdGtTVFluM0xIWm1oVENWenprVmRtT1V4bjBt?=
 =?utf-8?B?OUMzUGxvb21Nc2orbTRadVRjbVBKS2ROQjlidk5Td3BOc2RHUzBWbkJhclBv?=
 =?utf-8?B?V3NFejhiZi9majNxOEtHUEM5U1B2cjh0OTlJQ2QyUEpKc0UvZFBQR0FjRkpS?=
 =?utf-8?B?Z1BPWU5KODVjMmwrMzMzNHBCNnA4ajhOeG9RZVRqeDUySWdyb2puWUVobWJJ?=
 =?utf-8?B?cEtkRUlaTTZZaEhNNWhVdlR5TU5HVThLbk5tcU5nenVQVlJWTk8yYlFINWtG?=
 =?utf-8?B?YWMwdEh3eDYvV1cvdTU3bEZpK3Jxc1BocTJweXdJcDFwM2UrOXBHV3R3MW9T?=
 =?utf-8?B?UTlkK0NzVDhlR2hLTGZZN2d3c1U2MGw0aDJNU3J1aC9OYVBnTndPWURJZEFF?=
 =?utf-8?B?NG0wcVluZXhaOHRvUExqQU55VWlCVUNWNmdkby8xdGcxQnkzdGNkSFpoTGxp?=
 =?utf-8?B?QTZxUENNeUdlcmNhV3VqNlhnbWRrRndENkw3cExCK2VWVDdwOUt6MGNTZWNG?=
 =?utf-8?B?ZEFqYzVWcWYyOEp1cjE4RFNVVzVCbjlJZGh6eGNXOGtRU2lsNnlOSis4OHpP?=
 =?utf-8?B?T2s3RlE0QWJnazU2YzZDYlRQRzRZakZjODRwZTRSWHM5MzhtZ2tHbXczSGZR?=
 =?utf-8?B?eDFDcHVxV3FrRkNWZ3FOWjNkWk9sa2lYK2xiVkk1RFNxWUVHMDdUK01TVFha?=
 =?utf-8?B?RDhLNXlwMCtiYWtRN1hFalZNRUNpZUV5MVlLckovMUJyY3VuZHRFRXI2cmdK?=
 =?utf-8?B?ckpFVy8rYkJmRkU2QXZtY0xyYnZKTXhNRUlsU290Y01pRG5mckQ0NTZtWEwr?=
 =?utf-8?B?a0NYZ3NJTHJiWnEwMmxFSjJiWmh0NElTd3lSUW1Da2ZWQ1B5OGIzcUE5TTVw?=
 =?utf-8?B?K05TUXlZamRMVXRXUEROTDhsVkxUalUwdWlsa3JFLy9uNjEvakhkeStaRWRa?=
 =?utf-8?B?QUYwNzVVVkdDWkhIdEtOcW0zZitPTjZjaHBoQmZidFBUYS9vWXpHUk4yd0xR?=
 =?utf-8?B?RldyRFZjeEdNcHk0M0V0M3hYb1d6U1A5eG1tblIwdDhpMzRDQkN1WUp0ZHl1?=
 =?utf-8?B?U3VVYldMb0JmL2dQR2hMbVp2Q3hNZTZYSEFBRW1XOU5VZXlDNFdNWXRRa285?=
 =?utf-8?B?enhueEhnSVhVa21XK3pSL244dG1Za2RhNW1FdjJuTkNUc0djbFJCMjJneFV3?=
 =?utf-8?B?cDZsM3hRVXpNZnYwYVhuM1RmelpHMzVjOUFhc25hcFhrbnF6d0NrcktEQU1D?=
 =?utf-8?B?bXE4Ulo0aXRFcjVxWE5WU3pDeVg5TzZ0QjB5eEsyOTlpaDAya21YbzEyRnRZ?=
 =?utf-8?B?eU00dFI2Rk5KNzl0U21PTnNpRFJzcTNtK3pxMHZLbHFBMkNGb3pKM2hrOWhD?=
 =?utf-8?B?SzdGVktDSDhFL0owWUowSXgzS0R6YTNkMHRudlFjeVRXNmtkcjVvNjI1Q1ho?=
 =?utf-8?B?OVhRTnR6bnNsSm0zQWFkaGIwMUh0MFFFRUZUZHZzOStTd0wxVEN1Q2MwYVgv?=
 =?utf-8?Q?vDtLfHVYp40jyJfYwg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907818bb-d965-4370-5946-08de4eb9446d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:24:35.8480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXC8KRwT+FEfCnF1N7nMLouvxdKbMav7J9i84k+17MTBTOmlgeYBjrHo7utUlxLw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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

On 1/7/26 20:23, Philip Yang wrote:
> To reduce queue switch latency, alloc GART entries and map MQD with
> MTYPE_RW and control stack with MTYPE_NC on GART. Before invoking
> get_wave_state, debugger unmaps the runlist and at that time CP writes
> back TC, so debugger will read the updated state.
> 
> Add GART mm_node to kfd mem obj to free the GART entries after MQD mem
> obj is freed.
> 
> Use resource cursor to handle VRAM resource which maybe on multiple
> blocks and use cursor_gart to handle GART entries.

After the discussion I don't think mapping the MQD to GART is necessary any more.

The default NC caching should be sufficient for both parts on modern HW. If it isn't then we should not move the MQD to VRAM in the first place.

Regards,
Christian.

> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 74 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 12 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>  5 files changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index f27ffe64aafa..92a21af789ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -875,6 +875,80 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>  	}
>  }
>  
> +/*
> + * Same function and MQD description from amdgpu_ttm_gart_bind_gfx9_mqd,
> + * except this is for MQD on VRAM BO and use dynamic alloc GART entries.
> + */
> +int amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
> +				       struct amdgpu_bo *abo,
> +				       struct drm_mm_node *mm_node,
> +				       u64 *gpu_addr)
> +{
> +	struct ttm_buffer_object *bo = &abo->tbo;
> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
> +	u64 page_idx, pages_per_xcc;
> +	struct amdgpu_res_cursor cursor_gart;
> +	struct amdgpu_res_cursor cursor;
> +	u64 ctrl_flags;
> +	u64 total_pages;
> +	u64 flags;
> +	int i, r;
> +
> +	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
> +					 amdgpu_bo_ngpu_pages(abo), 0);
> +	if (r)
> +		return r;
> +
> +	/* compute PTE flags for this buffer object */
> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
> +	ctrl_flags = flags;
> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
> +
> +	total_pages = bo->base.size >> PAGE_SHIFT;
> +	pages_per_xcc = total_pages;
> +	do_div(pages_per_xcc, num_xcc);
> +
> +	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
> +	amdgpu_res_first(bo->resource, 0, bo->resource->size, &cursor);
> +
> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
> +		u64 start_page;
> +		u64 npages, n;
> +		u64 pa;
> +
> +		/* MQD page: use flags MTYPE_RW */
> +		start_page = cursor_gart.start;
> +		pa = cursor.start + adev->vm_manager.vram_base_offset;
> +		n = 1;
> +		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
> +					   flags, NULL);
> +
> +		/* Ctrl stack pages: modify the memory type to NC */
> +		npages = pages_per_xcc - 1;
> +		while (npages) {
> +			amdgpu_res_next(&cursor_gart, n);
> +			amdgpu_res_next(&cursor, n * PAGE_SIZE);
> +
> +			start_page = cursor_gart.start;
> +			pa = cursor.start + adev->vm_manager.vram_base_offset;
> +			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
> +
> +			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
> +						   ctrl_flags, NULL);
> +
> +			npages -= n;
> +		}
> +
> +		amdgpu_res_next(&cursor_gart, n);
> +		amdgpu_res_next(&cursor, n * PAGE_SIZE);
> +	}
> +
> +	amdgpu_gart_invalidate_tlb(adev);
> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
> +	return 0;
> +}
> +
>  static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>  				 struct ttm_buffer_object *tbo,
>  				 uint64_t flags)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 143201ecea3f..3751f010f14a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  
>  bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>  void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
> -
>  int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>  				 struct drm_mm_node *mm_node,
>  				 u64 num_pages,
> @@ -189,8 +188,11 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  		       struct dma_resv *resv,
>  		       struct dma_fence **f,
>  		       u64 k_job_id);
> -
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> +int amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
> +				       struct amdgpu_bo *abo,
> +				       struct drm_mm_node *mm_node,
> +				       u64 *gpu_addr);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index f78b249e1a41..edb72f4ef82d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>  	      struct kfd_mem_obj *mqd_mem_obj)
>  {
>  	if (mqd_mem_obj->mem) {
> +		amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
> +					    &mqd_mem_obj->mm_node);
>  		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>  		kfree(mqd_mem_obj);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index d867dccae675..1893dabb823a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -160,6 +160,18 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>  			kfree(mqd_mem_obj);
>  			return NULL;
>  		}
> +
> +		if (mqd_on_vram(node->adev)) {
> +			retval = amdgpu_ttm_gart_bind_gfx9_mqd_vram(node->adev,
> +						   mqd_mem_obj->mem,
> +						   &(mqd_mem_obj->mm_node),
> +						   &(mqd_mem_obj->gpu_addr));
> +			if (retval) {
> +				amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
> +				kfree(mqd_mem_obj);
> +				return NULL;
> +			}
> +		}
>  	} else {
>  		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>  				&mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 042b8e747b5b..7c95cc9e2f0d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -253,6 +253,7 @@ struct kfd_mem_obj {
>  	uint64_t gpu_addr;
>  	uint32_t *cpu_ptr;
>  	void *mem;
> +	struct drm_mm_node mm_node;
>  };
>  
>  struct kfd_vmid_info {

