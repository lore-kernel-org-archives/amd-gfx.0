Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88982C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 13:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C37010E84B;
	Fri, 21 Feb 2025 13:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MnK6NVYt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66DE410E84B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 13:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecfSLwUHKNqRVeCwcFzgtlDYWFFdUEUzTpeHcusid8sqYsN0zYMy+ZizMDw9QXiWFSYqsFW2MCWYU+Uu1c3NViRd8E3A6mzsoGrDsgIQrfAZjuzQ4J8QT9w+YVgw14mJGEC7MlZRJI8CXKTHY3lHMXMDiNHPtkF1w8M7ZOuqL9k6pyWQR6t3fnmktPJbuIevlc0BZWA5OtFl49aKLF9OD1jLqF1uIgTf96UIdAxIkObUK1s31fFTIKzyVffwbP72pVHLL/xhAMIRNGexo6MeAG8M2gXPlW2kwZH1Qq5o6OBOm7iOhRTURGMBhngCUvo4oxyTNFWZq8903rg7Wiwc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuL9I9hF+GjDOKT8xwhr6MDEFwF7hh2Mv2UBNSm4xhA=;
 b=NxmDrbcs7kO6VVmegx/gIl2BdTL909Kw9sl76v3wM1I0sc5MV90udbSckbNiejmN8OY3ysOA2pfKMFbQq0vLKUsa9XnYvthGdmCCeM4TdSzFe4W9KSLr/PtRmiCqXLWALTWI+/c6u15ZV7LZoV6zwuq/dPIdorvX6FA8Vf68H6MQOtUJBTaoCMhIAK9xA5aq+XbZY616E1KNcSSjkli6wPoavaXyiuuBxnukTIUOxTN0qLPwVDHkWaGzNKuFph/B+JxLwWLWl2sFA7q3V/4HNaN1Bf4+tvq9ZjmV2wdZQCCyNXpDDWheTekWzWkUqv2vaUAPY9e1Dy65XAc07bcQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuL9I9hF+GjDOKT8xwhr6MDEFwF7hh2Mv2UBNSm4xhA=;
 b=MnK6NVYthPy09ZQDNPUXsnFDzeXlpEBiwf7TSap+VMpQzutcz9B2mUVMkesEygzX3/jlroOY9bSs0bjQXtp78dg9rDferOSphuHY18D0PBmpBec7HBH3mHRx8Z6BwGMqW2gGBfR8+8bfF5yXx6h/1bpQrd0kcbu6S+XVW7e9z0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 13:35:07 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 13:35:07 +0000
Content-Type: multipart/alternative;
 boundary="------------KMYazwN90w8mNb1USKnkeXiT"
Message-ID: <e14c9f8e-f05e-4340-ba83-367a2dbf576f@amd.com>
Date: Fri, 21 Feb 2025 19:05:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes: keep enforce isolation up to date
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Shaoyun Liu <shaoyun.liu@amd.com>
References: <20250214173522.2373211-1-alexander.deucher@amd.com>
 <363007c1-064a-4017-abaf-a2b69bbc4679@amd.com>
 <CADnq5_OmnYXoc94h0LjG52wqwkOCAaB6eefYoqiJZY3k-hVm2Q@mail.gmail.com>
 <789dee33-a962-4824-b82a-375a36168420@amd.com>
 <CADnq5_Pm=epLrLRd842rsVriOo0ttTtB81_PK+BWHXkLwPPJfQ@mail.gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <CADnq5_Pm=epLrLRd842rsVriOo0ttTtB81_PK+BWHXkLwPPJfQ@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::16) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c77230-f9f0-4ef6-338c-08dd527c8e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFlQMWM3cG56RjQ1WDAzY2cwMEJZN1lwa0s3V1pWSDVIZXF4Znd0R2orakcx?=
 =?utf-8?B?TG5paURXZjBFVTYyZ2srei91TkJLTHJ2LzVmdnRHUkR1bmtkcGVFaERIaCt3?=
 =?utf-8?B?bHVXSCt1VWxPT3NLWmZWY3pKL2V2c2plS0RmbDFna1BjL2xmNk1wWG44eW9a?=
 =?utf-8?B?T3duVHlpRjM2aVlUMndHdCtNbUJBN3JMbHIyaEtBaC80WUhaaDd5MUk1RWNy?=
 =?utf-8?B?VlM1ZXFBK2wyL2dycEhhR0YzeDh3S3p6dmVOdFBsN0tLb2xZY0NhSzFWTGdG?=
 =?utf-8?B?TG15b1hhbTh4cEpEdFN6YVVYdjVQM25ib2VzTGhCaGJEWmE3TEtsS0pLYVZW?=
 =?utf-8?B?UUV0c0YvWXMvZ2lkK0EwQ0hZTjdweHFYUVFPY1o0bG5RT3ZkL1V1dmtyNzR6?=
 =?utf-8?B?cmJHOXhjNTR1bUlkclpVQkgxY0V5MU1yWkg5RzUxbHhqM2xxYnp2UmoybUR5?=
 =?utf-8?B?ZHZ3RHR5WmxZcEszL2xPUkZPenZldEJYMHd0K3ZrVUNKTWEya3JkZGIra0V3?=
 =?utf-8?B?TmY3QjdwaWx4Nnh5aWtCOE1DSXQ2T2lRSzBoc053TXpYelJFRjlBQXpvdDI4?=
 =?utf-8?B?WkRTMGFmRmxsUk8zZFpHeDU5ekZyWUxiVXBxWndBZUhFUC9KZ1FuZ1FpWEJo?=
 =?utf-8?B?U21ycUZpMlpFNmRXVldjMGR1ckpGY1pOc05LOTFvREFZMnduYUFPVnBQR2Nv?=
 =?utf-8?B?ZWRUSWxWdDhEdDJXU2NXdXdBaE9FcEY3VU5vVSt2S2E3NXl5K3NWMVBPaFFx?=
 =?utf-8?B?ZmxDTWhYazZQa0JHWTVQSjliMzY5c3NreVRqdDlWaEl0S3BoZ3I4MFV1OGtH?=
 =?utf-8?B?dEJUQzNOWlF2UFZEK1ltYkZzaWh4NXQ2R3h2WTY0a0htWiswRWt5OHN3azVR?=
 =?utf-8?B?SVp1OVNuWi9CNjlFTU11cm5RbzJJNWttcXp4Z0pPYzdtd2o5S00rSWpDMnB0?=
 =?utf-8?B?TVdDYjJHaDMyZHhEbUlmVlU1Zis3N2d2K3l4S2ZmQW5MZjFTelpKckVqN3VX?=
 =?utf-8?B?UVNpOEN5SU9Jc0FHT05Md0lWYW1MOGhQUzlzWHdXc0crYVNFdytmRU0vWDFO?=
 =?utf-8?B?b0RWUTdyMEJpcE83OUNURFhJNlV6THBIaDVqR0t4SVZKOGlaYmttSmJFZnRP?=
 =?utf-8?B?QUxrN2MwUGpkNnJrNi92c0tlekVPM2VsZDFob29kQTA3RkwwVHA1ZlJNWmRS?=
 =?utf-8?B?L3NCKy9HQzhJdEJhOWpJa09KeUNyT0JDSXJCVG52Nkx3TGZidjJXWHIvVWVr?=
 =?utf-8?B?a0hDc2FHRC93djhVbWpGMzgxaWVhSk9BR3RTY3lxRGR6d1UrRGxKcDZIUWhF?=
 =?utf-8?B?VlNXQmM2aThySzdTMkxJMGVOZGhhckZRZnFrN0gwZjRsTUdCdmxmRXgyVmdj?=
 =?utf-8?B?QUJDQ0MzRXQ1bkFaY0JXa05qT1pjTVVFL0g5NW1QbTVzYUF6VU5Qa1k1Mkxa?=
 =?utf-8?B?dWR2SVlVcUZOaHN3TlRoZjhiRm1RMm1iWFk5R210R2VJYVQzMENlTFpCOHRj?=
 =?utf-8?B?bDlsQUJNdnFpeVNVaHdydEpQdmlLWmp0bmhBMVMyUE50SnZVRHFNM1NyK2Q5?=
 =?utf-8?B?VTlBbWhyaGx4VEhPWk51TTdOM3h3czNSc0VBZS9ydEdMNnpBT01tcjk0enA3?=
 =?utf-8?B?bnFObDJoKzNZZnB1WG92RFliUVhPcjVzWXlRWW5hT1Z5TnVQcUxvM1FzVVZi?=
 =?utf-8?B?SmU1ODgxaDkvQm1VVktLZ2poRFFMZnRRd0wzd2ZhemtNdVQ1cnFDYTNQSkIv?=
 =?utf-8?B?Y3BzNGhaK0F6aUltYllwTVRZQ0FETS9FOS80ckptSXRUNTU4UEpvZThtRlRK?=
 =?utf-8?B?M1UzZk81YlZjM2U1bEpJRk5sMDMxT09FU0dabkdTYlZFRDhsVU1JVHU1cXJD?=
 =?utf-8?Q?jRSJ7snDbEji7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFJ6dzFPaWJaYXhUcGNFd1pXL0VGRTA1NGhvM05NVllYajhjNk9OQ1Era2tR?=
 =?utf-8?B?Zk1XWUo4Tit5STFXdlM1ZjNDL0R2M0JrNXkzR0lFazgwbUhXWFgwUzZRbEFC?=
 =?utf-8?B?eTc0Qm43WTNlMGgzYkh4dUZCRVkwYWJzYjM3NkVDWTZiR05lNHFjd2tJM0hl?=
 =?utf-8?B?NXlqa2RreE1HUkI4LzV6NE1MRUc2R1hQR0JVejlZVFUrWEdjdGk4bEtkRVJY?=
 =?utf-8?B?UnEvVWRuSnh6ak5UNnI0RTNrc2NLdVJFZEJVTDVscGpnbG1sMlhhaGtHOHdN?=
 =?utf-8?B?bUxVL1NlSFFSanI4S0x0S1B3eS9pSTNtU245Yzg5OVd3cW5EcTBoSy9lOTFn?=
 =?utf-8?B?REEwU0dvazYwaHVJeW5aU1h0Yzdkd1REN2JodjRjR1N0dGFFakNlcG1hcGw3?=
 =?utf-8?B?bFRWRjRnU0RWK05yZ1poMTA4UU1rNWVvd0g5cjJDSTV2MXZnRTdLSXRrRVY0?=
 =?utf-8?B?dlUycDNZUHp2T0dhell1Umo0T2ZPdlNOVWV3SHFZbVpzUHByUlgrTWtDN2VE?=
 =?utf-8?B?bDFWSXEzemxOK2w4dzFsUkJpR1NTeWlTclE2YUZXZHlGTkc5NVdaZ1EzYWw5?=
 =?utf-8?B?c0pTVG00bzd2RHJsSXl0czkvamU2R0xLVHhoSmlZbTN3bzJMVWc3MjZnOHhG?=
 =?utf-8?B?azVyZ2dxR0o4dUV6a0VEVy9qaWYvdVVBQzZ1bnpiMjlNM3E4ZmRMM0tpa1BI?=
 =?utf-8?B?dkpvQXJuV1dHaEcxdzRmZ1YzWGI5b2k5T0dVL1RLQ3lDVlFpT3k5b3JaZWRW?=
 =?utf-8?B?RjFUcCsxQmhFTTR2ZU5LbFlGb1IxbHFBSzhWU1JUZGZzZEticzV5QTFrK2tC?=
 =?utf-8?B?VnhXU1l0Ykd6RGNBRUkvT2IrM0s0M1dqaHAzdSt4Q2hNU2JWN0N2ODNPNy9x?=
 =?utf-8?B?ZGdoS0xsNGdQL0VYTi9qYXk5anVjYVdHZXpFeHhQUGNtWkhMSGI4dFJUNXVp?=
 =?utf-8?B?K081TEg0ZVQ3M2VRZGtLTWtzQjV6TVh2b0FkU2ZSNXhMZEx2SktMaDBXRU1n?=
 =?utf-8?B?c3djZ0FwQk5hVEFwM1Vwb2JOd2lqbHdVN2l3Unp0cHY4RzFScHJZWEZuR00z?=
 =?utf-8?B?RVJMUHpwWlBjN1JmMkZyTWN1TC9HZHRlajZGSFVqWUZIOHhhMUVDdlRrRktI?=
 =?utf-8?B?Q0NGekpIS1phckY3cmhiSlREa09XMWM5Q0Rhc0hoRkVQaGxlV1JVK0tDanpB?=
 =?utf-8?B?Sm5OS0VLMFd0VFV0eEpPVDZDV05tL0F2TWRtVUdpOWMxWG9SVjdXZzBmK0dx?=
 =?utf-8?B?b3VUVDRoOE8zeHM0cCtOT084dGJBSDVHdGlNblRnMGNMNXNSM3N0Tk5QK2xZ?=
 =?utf-8?B?SGdFQVk4blBFRE1FUTJLK05vWTRSTlJXcUxwMnFFQVpUbFQrUXBYZG9UaGN6?=
 =?utf-8?B?Vi9CZWlIQkFKUXlsNGZlR1pZUjAwU05vN3crMFlZSnVObytPRHZmbERXMWNI?=
 =?utf-8?B?WDVDL0ZEY1BEWVRwL1Y1aG9DSEsrdk8zVmxjTGFISm1tbU1wWUxlcEh1ZXFl?=
 =?utf-8?B?VXp6SVRZMTZxRkxRZC9zL3VCSlNYWFB5bkpFeDl1eW9jbHkvK0hPMDh1ajJQ?=
 =?utf-8?B?OVhCdGU5MTNDME53M3l2TnhUK3lIUUgvTjZ1MUtiNytsbWxDbnZIdEMwdk8y?=
 =?utf-8?B?aitzcWt3U24zYTZmNk9VcVhqNVk0SURVUmF3enNnNmNlbDNWTllVcFJkSFdP?=
 =?utf-8?B?dTFjTUUyRVdTYkN5dlF3KytvcllVbk1LRzJmWUNWdUNNWGE4RnA0OEhadTdY?=
 =?utf-8?B?SFhibFFLZUNld05EZXlZV0JmVjlGSU1xQUthNUlINmRLSStJWW9xbzBBSDIw?=
 =?utf-8?B?dTFGUXUraE5CMFplZ1ZTeWF1dEY5S0pNdVNHR0J5Q1grYzNBZ3g1Y0Jwb0pU?=
 =?utf-8?B?R3cvdFJTemw0S0tmdlp6SXFTd0NLL0czc0QvalpZczNSczEyZThPVVk2M0k4?=
 =?utf-8?B?TXd3cVNadGR1UmJSazlZaVFkTDdGbmFsUnlrWlo0SEV6YzN3ZStiZVk2NUVq?=
 =?utf-8?B?ZTVhWG1ZcDkzdUc1TW4vRmNXTDBCa2Z1NjduNklFai9hSTlZdnJQdndxdndp?=
 =?utf-8?B?ZTJBSVk2OE1JUXdVQkxQMCs3d2ZOaTlTVXUrYmFaSlMvTVlFQjF2L2d1czZk?=
 =?utf-8?Q?p47bTgM+yDIHDVmeXfcxCzuwv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c77230-f9f0-4ef6-338c-08dd527c8e22
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:35:07.3581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alFf0vj90SZPCFZKviD9FJ/1+VygvGWKR3WXZXsKQ0QnqgJVfB7C/JKixQPzC2fiPz8Nh9xu9KlyUkslXc9q8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
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

--------------KMYazwN90w8mNb1USKnkeXiT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/17/2025 8:05 PM, Alex Deucher wrote:
> On Mon, Feb 17, 2025 at 9:18 AM SRINIVASAN SHANMUGAM
> <srinivasan.shanmugam@amd.com> wrote:
>>
>> On 2/17/2025 7:44 PM, Alex Deucher wrote:
>>> On Sat, Feb 15, 2025 at 3:02 AM SRINIVASAN SHANMUGAM
>>> <srinivasan.shanmugam@amd.com> wrote:
>>>> On 2/14/2025 11:05 PM, Alex Deucher wrote:
>>>>
>>>> Re-send the mes message on resume to make sure the
>>>> mes state is up to date.
>>>>
>>>> Fixes: 8521e3c5f058 ("drm/amd/amdgpu: limit single process inside MES")
>>>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>>>> Cc: Shaoyun Liu<shaoyun.liu@amd.com>
>>>> Cc: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 ++++---------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 +++++++++++++++++++-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  4 ++++
>>>>    drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  4 ++++
>>>>    5 files changed, 32 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>> index b9bd6654f3172..a194bf3347cbc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>> @@ -1665,24 +1665,19 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>>>>     }
>>>>
>>>>     mutex_lock(&adev->enforce_isolation_mutex);
>>>> -
>>>>     for (i = 0; i < num_partitions; i++) {
>>>> - if (adev->enforce_isolation[i] && !partition_values[i]) {
>>>> + if (adev->enforce_isolation[i] && !partition_values[i])
>>>>     /* Going from enabled to disabled */
>>>>     amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
>>>> - if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
>>>> - amdgpu_mes_set_enforce_isolation(adev, i, false);
>>>> - } else if (!adev->enforce_isolation[i] && partition_values[i]) {
>>>> + else if (!adev->enforce_isolation[i] && partition_values[i])
>>>>     /* Going from disabled to enabled */
>>>>     amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
>>>> - if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
>>>> - amdgpu_mes_set_enforce_isolation(adev, i, true);
>>>> - }
>>>>     adev->enforce_isolation[i] = partition_values[i];
>>>>     }
>>>> -
>>>>     mutex_unlock(&adev->enforce_isolation_mutex);
>>>>
>>>> + amdgpu_mes_update_enforce_isolation(adev);
>>>> +
>>>>     return count;
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> index cee38bb6cfaf2..ca076306adba4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> @@ -1508,7 +1508,8 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
>>>>    }
>>>>
>>>>    /* Fix me -- node_id is used to identify the correct MES instances in the future */
>>>> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable)
>>>> +static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
>>>> +    uint32_t node_id, bool enable)
>>>>    {
>>>>     struct mes_misc_op_input op_input = {0};
>>>>     int r;
>>>> @@ -1530,6 +1531,23 @@ int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_i
>>>>     return r;
>>>>    }
>>>>
>>>> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
>>>> +{
>>>> + int i, r = 0;
>>>> +
>>>> + if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
>>>> + mutex_lock(&adev->enforce_isolation_mutex);
>>>> + for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
>>>> + if (adev->enforce_isolation[i])
>>>> + r |= amdgpu_mes_set_enforce_isolation(adev, i, true);
>>>> + else
>>>> + r |= amdgpu_mes_set_enforce_isolation(adev, i, false);
>>>> + }
>>>> + mutex_unlock(&adev->enforce_isolation_mutex);
>>>> + }
>>>> + return r;
>>>> +}
>>>> +
>>>>    #if defined(CONFIG_DEBUG_FS)
>>>>
>>>>    static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>> index 6a792ffc81e33..3a65c3788956d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>> @@ -532,6 +532,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
>>>>
>>>>    bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
>>>>
>>>> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable);
>>>> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
>>>>
>>>>    #endif /* __AMDGPU_MES_H__ */
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> index 530371e6a7aee..fc7b17463cb4d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> @@ -1660,6 +1660,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>>>>     goto failure;
>>>>     }
>>>>
>>>> + r = amdgpu_mes_update_enforce_isolation(adev);
>>>> + if (r)
>>>> + goto failure;
>>>> +
>>>>
>>>> Hi Alex,
>>>>
>>>> Should this also be moved to mes_v11_0_hw_init. Please let me know your thoughts?
>>> I'm not sure I follow.  This is in hw_init.
>>>
>>> Alex
>> Sorry, my mistake mes_v11_0_sw_init pls?
> There's no need to call it in sw_init, plus the hw is not set up in
> sw_init so you can't call it there anyway.  The whole point of this is
> to update the firmware with the current sw state after a suspend or
> reset.

Based on this understanding, at resume time - it is just the message 
that is needed to be sent only to MES, to make sure we re-enable 
enforce_isolation workaround after suspend.

Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

> Alex
>
>> Thanks!
>>
>> Srini
>>
>>>>    out:
>>>>     /*
>>>>     * Disable KIQ ring usage from the driver once MES is enabled.
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>>> index 6db88584dd529..ec91c78468f30 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>>> @@ -1773,6 +1773,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
>>>>     goto failure;
>>>>     }
>>>>
>>>> + r = amdgpu_mes_update_enforce_isolation(adev);
>>>> + if (r)
>>>> + goto failure;
>>>> +
>>>>
>>>> And Similarly here also?
>>>>
>>>> Thanks!
>>>>
>>>> Srini
>>>>
>>>>    out:
>>>>     /*
>>>>     * Disable KIQ ring usage from the driver once MES is enabled.
--------------KMYazwN90w8mNb1USKnkeXiT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/17/2025 8:05 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_Pm=epLrLRd842rsVriOo0ttTtB81_PK+BWHXkLwPPJfQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Mon, Feb 17, 2025 at 9:18 AM SRINIVASAN SHANMUGAM
<a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

On 2/17/2025 7:44 PM, Alex Deucher wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Sat, Feb 15, 2025 at 3:02 AM SRINIVASAN SHANMUGAM
<a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">
On 2/14/2025 11:05 PM, Alex Deucher wrote:

Re-send the mes message on resume to make sure the
mes state is up to date.

Fixes: 8521e3c5f058 (&quot;drm/amd/amdgpu: limit single process inside MES&quot;)
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Shaoyun Liu <a class="moz-txt-link-rfc2396E" href="mailto:shaoyun.liu@amd.com">&lt;shaoyun.liu@amd.com&gt;</a>
Cc: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 ++++---------
  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 +++++++++++++++++++-
  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  4 ++++
  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  4 ++++
  5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b9bd6654f3172..a194bf3347cbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1665,24 +1665,19 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
   }

   mutex_lock(&amp;adev-&gt;enforce_isolation_mutex);
-
   for (i = 0; i &lt; num_partitions; i++) {
- if (adev-&gt;enforce_isolation[i] &amp;&amp; !partition_values[i]) {
+ if (adev-&gt;enforce_isolation[i] &amp;&amp; !partition_values[i])
   /* Going from enabled to disabled */
   amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
- if (adev-&gt;enable_mes &amp;&amp; adev-&gt;gfx.enable_cleaner_shader)
- amdgpu_mes_set_enforce_isolation(adev, i, false);
- } else if (!adev-&gt;enforce_isolation[i] &amp;&amp; partition_values[i]) {
+ else if (!adev-&gt;enforce_isolation[i] &amp;&amp; partition_values[i])
   /* Going from disabled to enabled */
   amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
- if (adev-&gt;enable_mes &amp;&amp; adev-&gt;gfx.enable_cleaner_shader)
- amdgpu_mes_set_enforce_isolation(adev, i, true);
- }
   adev-&gt;enforce_isolation[i] = partition_values[i];
   }
-
   mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);

+ amdgpu_mes_update_enforce_isolation(adev);
+
   return count;
  }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index cee38bb6cfaf2..ca076306adba4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1508,7 +1508,8 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
  }

  /* Fix me -- node_id is used to identify the correct MES instances in the future */
-int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable)
+static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
+    uint32_t node_id, bool enable)
  {
   struct mes_misc_op_input op_input = {0};
   int r;
@@ -1530,6 +1531,23 @@ int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_i
   return r;
  }

+int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
+{
+ int i, r = 0;
+
+ if (adev-&gt;enable_mes &amp;&amp; adev-&gt;gfx.enable_cleaner_shader) {
+ mutex_lock(&amp;adev-&gt;enforce_isolation_mutex);
+ for (i = 0; i &lt; (adev-&gt;xcp_mgr ? adev-&gt;xcp_mgr-&gt;num_xcps : 1); i++) {
+ if (adev-&gt;enforce_isolation[i])
+ r |= amdgpu_mes_set_enforce_isolation(adev, i, true);
+ else
+ r |= amdgpu_mes_set_enforce_isolation(adev, i, false);
+ }
+ mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);
+ }
+ return r;
+}
+
  #if defined(CONFIG_DEBUG_FS)

  static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 6a792ffc81e33..3a65c3788956d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -532,6 +532,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)

  bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);

-int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable);
+int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);

  #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 530371e6a7aee..fc7b17463cb4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1660,6 +1660,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
   goto failure;
   }

+ r = amdgpu_mes_update_enforce_isolation(adev);
+ if (r)
+ goto failure;
+

Hi Alex,

Should this also be moved to mes_v11_0_hw_init. Please let me know your thoughts?
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">I'm not sure I follow.  This is in hw_init.

Alex
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Sorry, my mistake mes_v11_0_sw_init pls?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
There's no need to call it in sw_init, plus the hw is not set up in
sw_init so you can't call it there anyway.  The whole point of this is
to update the firmware with the current sw state after a suspend or
reset.
</pre>
    </blockquote>
    <p>Based on this understanding, at resume time - it is just the
      message that is needed to be sent only to MES, to make sure we
      re-enable enforce_isolation workaround after suspend.</p>
    <p><span style="color: rgb(51, 51, 51); font-family: &quot;Source Code Pro&quot;, &quot;Courier New&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Acked-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></span></p>
    <blockquote type="cite" cite="mid:CADnq5_Pm=epLrLRd842rsVriOo0ttTtB81_PK+BWHXkLwPPJfQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
Alex

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Thanks!

Srini

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">  out:
   /*
   * Disable KIQ ring usage from the driver once MES is enabled.
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6db88584dd529..ec91c78468f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1773,6 +1773,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
   goto failure;
   }

+ r = amdgpu_mes_update_enforce_isolation(adev);
+ if (r)
+ goto failure;
+

And Similarly here also?

Thanks!

Srini

  out:
   /*
   * Disable KIQ ring usage from the driver once MES is enabled.
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------KMYazwN90w8mNb1USKnkeXiT--
