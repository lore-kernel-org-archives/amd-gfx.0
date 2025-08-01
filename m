Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054A5C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 07:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D2910E131;
	Fri,  1 Aug 2025 07:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A/LAZw0Z";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE4D10E131
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 07:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWMEoBYgElOtMl5853xVI1GfbiyByCMhSbh5tKKWZNyaTnp7r5CfzkI4Xj/QH6ExHNgVdweuDaNXqiuHqDW7dYh3/5dxQgiA3Unbw8kXSM5lqzaWNGg0NupSQWG8KuWlFs+d0sxvN1QsO9/RB4/IBV8bJmz0N8qDOCg4fQdfvXnnxR6NYtjo9KwlmczMk9g5DysDXqA/vJq0Ao3CZ7UJX2mW9tDMb6m6LOL+xX5BIpIhcnOvqU5qez32ZL0kfjOzvIpSvkDfqDTWUwF+UQePm1qHuyqDo7iKpvgxXN8NNkDft/KO0s8DAl1itBqLLxOtcmNN1IEpX192CJhZBiINpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ7/208Hwb7O/wHfuLoxTStUfwDo1uKsy2skW5bKK6Q=;
 b=h9Zu8+ZUW8K+ZBNjfrNFumhFBxyQ11pYCwj4ZOK4kdckkgG+SdQ1y3cmRMCvlRne0kLcts92zcBJOT1rJxEqPv9KrUDI7Jp3qs9FVDYs89MIRk29PmFV8EGzXSzHjJ6Vxy3XMU2XduOjX/abpvv4gJG9dAOxWDJh7ZpWfULemp8KP4ywMqyze2GuyVyTj6lJa2KQ+M3WdeHExZjpAO3UGCWYWcQkHN8sYVx67/kgC+/iU58Mvsp5d5x/xEOdpviMw/piATAaPIbXudj1Zwq29Rq93ctaIprx7Wk7I4LwljfLbBj72zazxa8fpE/LDXKbk03hBSB74809XQNtjWE2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ7/208Hwb7O/wHfuLoxTStUfwDo1uKsy2skW5bKK6Q=;
 b=A/LAZw0Zu69fr/CREdTA7qQTZdV08sp4XJu9hwcIIHFk/dE3762W1sh02PLK4St7SzwdNebCh7eaKYpId3LkqVI5fyXj/b5pXKweKVAnlg1MlRoe6bPCJDYkp9t/YkxUvTZLuZdliWYPceValbq8sdtI4+qV9yxuR5Uz8W9QXDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 07:43:21 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8964.023; Fri, 1 Aug 2025
 07:43:14 +0000
Message-ID: <c182e36e-e8ef-4507-a6c3-8441ba8915fe@amd.com>
Date: Fri, 1 Aug 2025 13:13:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
References: <20250731060920.1694915-1-lijo.lazar@amd.com>
 <PH7PR12MB59975C7A637B78C04BAA82C48227A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB59975C7A637B78C04BAA82C48227A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 7859f431-f137-421e-b641-08ddd0cf1224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWZ4YWVNVXUvMXJrUlZ0R0xRdll2MXI4dHZBRnR2MXh0a1hkc29hNGNtdnhO?=
 =?utf-8?B?b2dlMmU5WUNlNTZPcDB2UXBsVGo3ckNpUTN2QzhmZEhaM0hOZjdUM3dUU2Vm?=
 =?utf-8?B?OWt5RHJxckNWdlAzY3VyWnNPcm9qcnE0NnEwTDc4K253VFNjWEhHbE9Idkk0?=
 =?utf-8?B?SnNwa21OK2tEM3RISE4wWEtoeXU2eFJGS1pGd1A2ZHplSGNMQllXQ1RKT1V3?=
 =?utf-8?B?VGl1RU5WZkYwVUxtWjZVYmtlUERXV2JsenFoOGp0MVVIUVk0QVZLSitqVTRN?=
 =?utf-8?B?VFl6SEliNmw3VVh2Y2hoa3hEOEFYMFJhYmFDTC91RFo4cEhpTW53Tk1VeUF2?=
 =?utf-8?B?dXhTaEYvaG5aSEF5cVJ5blhjcUNNb0FzWTc0ZUoyME9PWXhqelBOYmlQdkRz?=
 =?utf-8?B?dm1USXJ5a2JPRUgyK0RiWDVFM3VyWGQzNlhIK284czVtNmJoTC9hTExiMDc0?=
 =?utf-8?B?ejdzTzRUYlZObVhiL0VLdGN2MzZqY0R2Y0tIbWRtc3JUVTFDL0dyYWQwMjkz?=
 =?utf-8?B?c3o4NlpvQk9KeGpzOGI5anhScE1qY3pWaVpWempGWUtXcHF0MjJnTUNQZnhm?=
 =?utf-8?B?VUp1VHMyNEl4RTVOVzc0VGkzaXdmQmw0U1VocHJjUzRDaExRTXRoV29VMHM4?=
 =?utf-8?B?UjV0cVV3aGYwOXRLeStvUjU5Tm41ZVdkcDREK2VIRzl5TERuenhwYVh4dnVh?=
 =?utf-8?B?N2RuNzdMWEc3ZWljc1p0dDExNEE1TDF0VEVEN1lRNExuaUNOcEFZTW9SdXdz?=
 =?utf-8?B?ZEJKdFBwOVRLZEk4SVhkOTZ1ajhsYTlQQ3E1TmViR1BwOFdKdE42TDhrazdk?=
 =?utf-8?B?a2Zqem92L1VBQWVpdVRTN2NTMVNqa2k3dWlRNXppWUJaaUpTQURyV3MzaTJW?=
 =?utf-8?B?Q29Lbk52azlxaldNMEU5aGthai9WOGpMRkIvaURrT1hiSkorTmhhdjFSWG5z?=
 =?utf-8?B?RFNlUE9RTGFRZG5IKzlUSXZ0bDdtY083TENKNEVUU1NLc01xS1pRalY0eW0z?=
 =?utf-8?B?dEROYmJPYTY5bTBEL0dqQ3Zock9ZODBaako3YjFIeEMzZlROaExBWm5ZUEZC?=
 =?utf-8?B?K0NhN0N2bThGc3VlYVRITldFK1g2ZzJUMnZBcUtOS2didWp0ZmE2WVdaNGcy?=
 =?utf-8?B?bjM1ZjZvMmtYYlBhRmdIMHlWcnlsVWk5QmY5N1orSUJUQlhDck1GL2FCcTV3?=
 =?utf-8?B?WklNWWN4K0hyZy9sS05ONFBRdDZVem1wY1J0cDgyTDZ0YkcyQndHelF1R2xi?=
 =?utf-8?B?aWNpMXFLbCt0WEFEWGwreFVZeFFCb1grWXQ5M0dEQVBBa2xTV0Z3WWRwQXp2?=
 =?utf-8?B?SEpoSGdKSVNlcFVhQTVTbjlydnVoU0dJeGpBZk5zRVpaWUZBQlhOUGkwVnF4?=
 =?utf-8?B?Y0czQ2Z0MDBIYVdZS3hzdllNY2ZSVXRtc1NvejNhNkFEcnhjZzJWS2c0YUM5?=
 =?utf-8?B?RWhiRklFMW9TODhlVlJjN0poTllpNC9QTmlWZXZSdWRMSkRUaGFGejBkS0dl?=
 =?utf-8?B?NStxZWg1L2NIOUsxSjBBYVlST1RtKytMd1RvSmZCTi9hR1ViM0t3cU4zQ2RD?=
 =?utf-8?B?K2d0bitrcnlYZ2YzSWZ3Z2RNcnZNM2JpVHdrQ1NscjNwcXZrVTZzRmt4TkZG?=
 =?utf-8?B?R21QS1BBRTdpeEg5eG9XTGVBN2tvc0Zuc0kwNGY2Z2lJejgrdEZIMjNSMjlX?=
 =?utf-8?B?SS9GdGFiQytjc2RCenArOWN5YXZJUHMvekpnS3NKbHdyRDN3WVpIek55QWth?=
 =?utf-8?B?RmFVaUV1amZldllVUG5JVjM5akx1TExFZ2I0K292c1dpUktVS29PMzBFUkNo?=
 =?utf-8?B?T2s0Yi83Uk12TnhsaVI4YnB4THZyTDlJYUVaRGR4UUJvMWh4WFUzOXk3NFVE?=
 =?utf-8?B?SVBCZXRaRjZobnVVOUlYV05BcGtxSGw3YnN3TVRBNFZDbkY5aGJCMGx0OVZp?=
 =?utf-8?Q?uruutVAm2Bw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1nSFRrOCtyUjMreWZMc0xJcVdLUTJDYUYxQWd3QVRYdmRLbkp3aXNjN2xx?=
 =?utf-8?B?K3BIYk5CUHROd0lFWWVWWmdrYVRTMEk1bUFOR0tadHVDMTY2dWx2MmtVbjFO?=
 =?utf-8?B?SWFqOWpNNHRwK3g3aHZDbzc3TjUzMFhkZ05BZXhmQ0ZsZWNxbkI1K3prOWhq?=
 =?utf-8?B?RWpibzZmMU90SXpqRnIvZUxESE8wbnNmejZjZ2tYVm50WU1aWktSZi9Senow?=
 =?utf-8?B?WXYxeHNLaG1BOEdURUx0enBEQW1zS2Z2bDJZY3NMYURyUHZoYWxXWDdibWxI?=
 =?utf-8?B?UnJNdE8wZ1owNFJQeWlmTTBnK3dXeDZXQ1hITFZSeVo0RjVhOGlTMlI4ZStx?=
 =?utf-8?B?SEVqYWs3aHBWQTV2Z2ppNGxjZllqbWlzbTBsVFFxMlMzUXBnMFc3c3pyOGI0?=
 =?utf-8?B?RzRuOE9YK3hhaEtPckEyZ2I1aUkyajh5QUE1bld2ZzQvUGsrWS9DdlhjVmxP?=
 =?utf-8?B?L2w1VGZqOWVNZU5xZFBMS1U0Q0haQjR4WU9YMjJkQjYrZW1qOTk3WlFZMzJY?=
 =?utf-8?B?eEE4aVJwaE53d2dPa3FnV0hJTE0zdVo1Vnl1UEdEeWZneWVMSm5jUlA3TmpH?=
 =?utf-8?B?ZTI0QmZNQXBSVFRqYlRobnRleE4xaFNmUHhtSzZPbDZNSGdNUjc4SGF0YjQ5?=
 =?utf-8?B?RU9SWFJsWUVhbFZuRUZ3bEVBVFBFK3N2QUw1TktZMkpzZGJTSXNhZWQ4K1A5?=
 =?utf-8?B?TmZSUmE5ZW51OWdDWHo0M2pxUVR5dTRuN3RZdWtVQXI0OEViMlU2TEVqN2RU?=
 =?utf-8?B?UTB5ZDV0dk4vTEt4ZnVxWUlVbkd4TzBWcGZYbG1SSUtkSkp2YkVwMUd0eUlr?=
 =?utf-8?B?Y1dmRk9vTE1BMkNuRFlFSUpZcStlRmFBN0FKQXA0VG90elBvMVMzSldLZm9v?=
 =?utf-8?B?NE9tNnZTenUzcTdqQWF4ck51WWhNWXRiTkpnalAvUmIyYW1qbnU0ZFp4VnF3?=
 =?utf-8?B?WjNBb24xV0NIOHJSNGlCRmo1eHlMOXAyWGRnUmw2TzhRVk9Leld4RTFYM0Vm?=
 =?utf-8?B?c3BhVm9VRUU5M1VqMC9aRHE2Y3BkYnhRdFB0UFFlRzc3T294dFM4RlFXdndK?=
 =?utf-8?B?Z25XOEZWcEFmajZWdVlaZDVDeWJpVWZ1TzZtdVQ5bjRPbEw2UDBveHNxUFlp?=
 =?utf-8?B?M0sxSFlycW9uNEVyZUgwREVDYVhIV05rU1U2R1o0VEUyZXNBSjFvM0FiUHo5?=
 =?utf-8?B?dmxmTE9SMElteTc0c1FaeHRvVm5RYnBBaDRodW1yK2dGc04rNmgzN29nMDJQ?=
 =?utf-8?B?aC9RVTFZWnFvSExERFVvQjVXWlZ6anh3SWN2aFFGZHhCTUdLNTZOZ3RUTnov?=
 =?utf-8?B?dng0L0xobTQrWGoyOGJkdWlaWHhZSm9jbW1td2RvRlBrYU5lcGJwbkZ6Wm1i?=
 =?utf-8?B?aUxySnRBVkZtR2xQRWtMMDFibzdUZE56TjJNSi8vUUV5ejN5MzhFK20wNTFq?=
 =?utf-8?B?ejFLWGE3VFozdUo4ZGhTR0R4cHlrQm1vb2haaEJETXpQak1rUnFDcEZycjlm?=
 =?utf-8?B?YWE5UVNkRHgwdXhwODVpR2ZQaTE3YWlQS3p4WjVLdHJVRFdKbmhwYWplOTZV?=
 =?utf-8?B?ZWFRVEhxU3FpM2FONkNuYWN2eVhSQlFJRDFaM3Uvck85LzVxQXJURnI1TUJ0?=
 =?utf-8?B?VUpqZnUrREQ1TDRKdXErYm40SHFGditlTExuWVlwb0JoUGlnUzRyYWV2dFR1?=
 =?utf-8?B?S05SYjJkT0RPcFRBZnVlTHB3a1RoM0dBOUpWQWZmZDBtSXhBeDdNVkdlam9H?=
 =?utf-8?B?SnZiNzVVTEFtNGxwWFhqWmtWZkM5UGNFa091THpqUWpkZmFHNExTMVpJUVJT?=
 =?utf-8?B?NkZvU3dYVlBpRkdIa3RCd1E4Ni8wZDM4YlNhM1ZzREl6bFRZQlZFbmRwZHdP?=
 =?utf-8?B?YTU4U3BHV3RvYmN4US9DaVgrU3NLQlAwK29PR24rTURBS2ZRblVHZ0tyR0ky?=
 =?utf-8?B?M3BPbFBMSlVZRzVteVlrY2RhN0ZJN0ZkOS9yQ3pNY2xQbGxsQUVEb1MrdXJE?=
 =?utf-8?B?NnpwdktwT0lZalQ0clBXWjcxWmhxQzhwQXZqemt4RFJXczExT3dSVGFSbW1u?=
 =?utf-8?B?YUROck9VNS9RNW04cm1kYmNuYVZhclk0UVF4T3Q1UzI1V05YRmsyVm1meUdv?=
 =?utf-8?Q?ORtTv2LQakb6OJ0vHbzPd84OF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7859f431-f137-421e-b641-08ddd0cf1224
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:43:14.2004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tShUhtcH+HDTHxZmjrWiMs59yCTGnULRdzRRJHZ6GgTn7Fmsx/nsJISvHqiGrh0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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



On 7/31/2025 2:00 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Patch looks good to me.
> 
> But I prefer to add a flag such as "link reset" to indicate that the response register may not accurately represent the execution status of msg.

There is nothing wrong with the response register status. The message is
simply not processed since the firmware is doing link reset state. Hence
the response status is actually correct in the sense that previous
message is not processed.

> And mark this flag in the necessary case (such as reset/flr). And the check of the previous msg response can be ignored when the next msg is issued.

A similar thing is done for RAS and there we allow a certain set of
messages to be sent.

In this case, we are marking messages as priority messages which are
expected to be processed any time regardless of the execution status of
the previous message. Reset is considered one such category of messages.
 > Additionally, this should belong to a global state of an SMU/PMFW,
and it doesn't seem very reasonable to bind it to a specific MSG.
> What do you think?

Though it is related to state, only specific messages will be processed
by firmware in that state. Here, this is only having a single message.
If there are others too, those will be flagged as well.

> 
> Btw, the msg of GfxDriverReset/FLR both can cause the response register to be cleared.
> 

This is only bypassing the checks before sending reset message, not
after sending reset message.

Thanks,
Lijo

> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, July 31, 2025 2:09 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
> 
> Certain messages will processed with high priority by PMFW even if it hasn't responded to a previous message. Send the priority message regardless of the success/fail status of the previous message. Add support on SMUv13.0.6 and SMUv13.0.12
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |  2 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 14 +++++++++-----
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index d7a9e41820fa..aaf148591a98 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -469,6 +469,7 @@ enum smu_feature_mask {
>  /* Message category flags */
>  #define SMU_MSG_VF_FLAG                        (1U << 0)
>  #define SMU_MSG_RAS_PRI                        (1U << 1)
> +#define SMU_MSG_HI_PRI                 (1U << 2)
> 
>  /* Firmware capability flags */
>  #define SMU_FW_CAP_RAS_PRI             (1U << 0)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 02a455a31c25..17e0303f603b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -106,7 +106,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
>         MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqByIndex,               1),
>         MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,                     0),
>         MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit,                     1),
> -       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,                  SMU_MSG_RAS_PRI),
> +       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,                  SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
>         MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetDramAddrHigh,          0),
>         MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetDramAddrLow,           0),
>         MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetDramSize,              0),
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 9cc294f4708b..c22b3f646355 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -145,7 +145,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
>         MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqByIndex,               1),
>         MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,                     0),
>         MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit,                     1),
> -       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,                  SMU_MSG_RAS_PRI),
> +       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,                  SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
>         MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetDramAddrHigh,          0),
>         MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetDramAddrLow,           0),
>         MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetDramSize,              0),
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 59f9abd0f7b8..f1f5cd8c2cd9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -256,11 +256,12 @@ static int __smu_cmn_ras_filter_msg(struct smu_context *smu,  {
>         struct amdgpu_device *adev = smu->adev;
>         uint32_t flags, resp;
> -       bool fed_status;
> +       bool fed_status, pri;
> 
>         flags = __smu_cmn_get_msg_flags(smu, msg);
>         *poll = true;
> 
> +       pri = !!(flags & SMU_MSG_HI_PRI);
>         /* When there is RAS fatal error, FW won't process non-RAS priority
>          * messages. Don't allow any messages other than RAS priority messages.
>          */
> @@ -272,15 +273,18 @@ static int __smu_cmn_ras_filter_msg(struct smu_context *smu,
>                                 smu_get_message_name(smu, msg));
>                         return -EACCES;
>                 }
> +       }
> 
> +       if (pri || fed_status) {
>                 /* FW will ignore non-priority messages when a RAS fatal error
> -                * is detected. Hence it is possible that a previous message
> -                * wouldn't have got response. Allow to continue without polling
> -                * for response status for priority messages.
> +                * or reset condition is detected. Hence it is possible that a
> +                * previous message wouldn't have got response. Allow to
> +                * continue without polling for response status for priority
> +                * messages.
>                  */
>                 resp = RREG32(smu->resp_reg);
>                 dev_dbg(adev->dev,
> -                       "Sending RAS priority message %s response status: %x",
> +                       "Sending priority message %s response status: %x",
>                         smu_get_message_name(smu, msg), resp);
>                 if (resp == 0)
>                         *poll = false;
> --
> 2.49.0
> 

