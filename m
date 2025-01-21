Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13CBC02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 05:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633F310E4C3;
	Tue, 21 Jan 2025 05:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fbOjt13f";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3953210E4C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 05:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phQ8q878yPj5kxD6OTvTljksymjnVSa/F7x0anuXcYBZyCYuKpMVDnvax6DIW3GPaAmT8k90cURueoz+YG7K7U5b81oUlItmbQQgPkDQ73QEZd7CFZs7ubY7hOokgM/XOMOEbwmUoMF0bWKxwhuCxON4SlO8Y5Y6KfNcPwHGQDvJdhjwuJrDva8Df8W4Ql7mS/I1p6votKwEP/8o6bS9LNAnLjd2MNPp78M5d+79F1rHqFPi0Ydnpt2J04k2IJyBpnc0mjXgluSivFQ8xnyx9QgqwOr0TP1lDNcb4qpkelccyA67xJCTMtFaFW2qYSrLYg9Vyi59eJ7THiR8vEjA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TPoZJRNZtBu1hliAopsMpKvlW1KwC3yyN7Pko3OufQ=;
 b=mUMK2rT/oxTRs34ZVTdYeJ4vAcEkZLEglpEFyzczQ2Uq8Oi8adteuwf1qJGvSr1I2kFLt8aDpJklzfO7OFm1widUPgUQJvOsOHteuTF6dRruKSyNsFQO8KGDp2XJge/cXvycaAI9kpluOwnt5hM7OvzYFxWsnkT16KhNkUE2UkJzt5WdNYdjGU8hukgfJAkaNH5lWpjdPap90N03GeFjWK5xcBrDdm3JFih76Lnt7ho1uBjua0WGWYjPLBMRYV7trDnhdwm9gsrHXYILu7vgW2RSE/Q3bB/N3Y3sAH6FWYeMhVYAMUab6VRQa9sg8uLemcl9HuHf7oyIPdfccfZnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TPoZJRNZtBu1hliAopsMpKvlW1KwC3yyN7Pko3OufQ=;
 b=fbOjt13fbYkJwe7Avfr5sWAXmHJ5p48aLoAsp9hg4ex9o6QOySK7fSy5crUfgnvoxCDXL4rFDZBcAoi6+rNXnQ4EIgcmmmw4m2ooVgl9ezjECSzZ6ZTR/DqvgjlAf/3v2V9BZNEUUjlrLK2oRCKYAQ1++VIs1+GbnrNULoxQdcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 05:46:11 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 05:46:11 +0000
Message-ID: <ef9902c4-0d7e-4a1a-b785-b3ca8e8d0a03@amd.com>
Date: Tue, 21 Jan 2025 11:15:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] amdgpu/soc15: enable asic reset for dGPU in case of
 suspend abort
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 Prike.Liang@amd.com, asad.kamal@amd.com, sonjiang@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736739303.git.gerry@linux.alibaba.com>
 <2462b4b12eb9d025e82525178d568cbaa4c223ff.1736739303.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <2462b4b12eb9d025e82525178d568cbaa4c223ff.1736739303.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::32) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 367bb670-123e-41ef-bc77-08dd39dee8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVZDMEQ0VHU5ZnlMdVZLMExiMXVQTUhGNHNJZGlQMWNUWmVHQVVmRjJtS0dz?=
 =?utf-8?B?cHd3TFZGTmRSN1IvTlpXa1Z1UjJabDM1b0xXUXNXZldtVXJHbWVzS3gyWGlx?=
 =?utf-8?B?RE5pS1pvUUgyTVAvL2lhbXRTYmVGRFYvLzIvc0dHd3FOOTVHbEJOeDhRdFEx?=
 =?utf-8?B?cXdJMVIvaDRVNGRyK211S1EvVEJPTWFucE9iVHFLQlF6V3FVNnNUemR0TEs5?=
 =?utf-8?B?cU54K1dydnVnYnpWM2hOeEtlRzRYeDhnQ1VSYzZuaFVveUxoQko1c2IyNTNm?=
 =?utf-8?B?RDYrQ05MMlN0bWExNVBiVytlUTNEVmNKR2d1QWpqVVU3NGVYdWlpbW9rQ3F4?=
 =?utf-8?B?NHNiNFdKRThOdmM2dVl6NkpIVlU4RkN2RzV4OFBycDY4ZEQ3QXVFZjhyaUNK?=
 =?utf-8?B?cVplcEEzeTNraVdXV3YrR1BwLzI0ano2bDNlcmw5ZkxzN1FMay9ic0phZDV4?=
 =?utf-8?B?QzQybFRkS1NJWkhodWQ0UmNxRENscGZUL3QzWTZQbVZrMlNKbkpXY2hGQmI1?=
 =?utf-8?B?ekMzWGs0YnE5aXJmSmNweVhTekxIVmdjNUdqOFRJNGkrSGo0VDlyZVBMU2NN?=
 =?utf-8?B?MHBxWjJJc1EwZjdnT2YyS1ozYTZ2OCs5eEplNllhZmlTZGZhZE9GOWpDc0hz?=
 =?utf-8?B?TFpKNWZxb3A3SlFackpmVEhMa091SDErRWg1QzIzR0cyUkV5cWZSd09qenFD?=
 =?utf-8?B?dXhsUGZJWkltRUNBR0diWmE5M21PNUNmYUpNZXE3SVNyVjNINmNxYU42Sjd5?=
 =?utf-8?B?SVJXMjdsa29DdUJpV21sUm93ZlFmdVR6RjhsNnJMcnJYRXdBeVhzbXQ4RXIz?=
 =?utf-8?B?Z2ZyWVBrZG9RRXFwNHVEdWRFWC9qTzV0NjViK1p6YmFEMmJGYXp1WTAxenZF?=
 =?utf-8?B?cGtrSTQ5aTRPMnA3aS9BU01MTitpOFZnOUtDVDA4OEUxekZWRGc1bzJTdTZH?=
 =?utf-8?B?K1pVUkIybFZ1RkxsckVxcjlXSTh1dVVERFh0TjdyZjRyK2lXNmxvUkNnNEdk?=
 =?utf-8?B?aUlSMmVmMWw1VHZETDlyTS8rNzVVRkNwRVF1RmVXUDNualBKbm9CL3VxRlV1?=
 =?utf-8?B?YjNUZklRQzR0TU1RYXEzTnNONTZ4cXVFMmgyQlZCTnRkUXp4Y0I3eVdHcUJt?=
 =?utf-8?B?TkUxTi96QlpFcHhpUDJseFo4TmNaMjk0UnZWZmNlVHVMK1NZaHoreTh3SjFU?=
 =?utf-8?B?S2swZHdvQ2E5MjRhanVvR0I4d0Z1amowQkU4cmJyTWQ0NjliaEMxeFc0Z0I1?=
 =?utf-8?B?TTdqQ3BKTzY5UThkQ0VkbWdTT0xnazU2ZjRTUkowakllZ0IwMVFBcHBBQ2hO?=
 =?utf-8?B?Z2EvNGVxcnA0b1F3b2NiaGFSdkkrRmovdEV0RGZRVENrdTMwdmNiSXl3eXNs?=
 =?utf-8?B?NDJONytqMmpBTytzWnI4SWxEU0g3TkM0N3JpZFdvV2J6bllrbk9XSXI4MlBs?=
 =?utf-8?B?Z1FaRGNidXJBandVNzc4Vzk4VHBGcXhWeUtnZkp3Z0VmaDM2S0FENUVBVXJS?=
 =?utf-8?B?YXppTkNsZmhGZmZnVjVHVHo0QzFBekFhRGorZUwzdno1WTFYZjZNWnpXbWVr?=
 =?utf-8?B?dHluRllkZTh4UnNWc2RIOGFnbzlDMGVEUGs0eG9Wb3VMOVlwbitXVGNaQUFQ?=
 =?utf-8?B?Ly9QamtxbzR0OFhLdHdWRThWVVFGUU1sTG1VL1ROTG5jNmVyaXJYckdSQkpi?=
 =?utf-8?B?UTJxdnhROW4yNXg1b1lpb3JLL2ZvemYvMGt2ekYyMVE2eXJHRHN3a2EySEFp?=
 =?utf-8?B?KzRqWFhnUVRTb1RKMjBLYytnMzFKUzhwdWthUlFjOWJHUG9jQVYxbndpNDV5?=
 =?utf-8?B?MnM3RllnNW1IWDNoYllmeC9yZDhFWWkxM2RNOG5pQmdRWVBOZHZvNk5aTDZq?=
 =?utf-8?B?ZlRHVGs4NFE1cWZrNGZRN2QrNTIrSEFqbllCeWdIOXJteG1GKzMrSVY5bjcv?=
 =?utf-8?Q?G/Pa0BXr3Xc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNpN1dNQ0xrUERmTnNkamxycmhSNmxZNE15MHgwQ2lNWHlXZjlpVWtISnhT?=
 =?utf-8?B?UE4zMHpPeWVkYzUzc1UrUkxEV1VqSndWaTNjd0V3a2tWYnNMUStuT0QyRlhD?=
 =?utf-8?B?ZmtFQml4T2k2a2NNN0dMbEZKTlo5TWVrRmRLRlNuUjVuZ3NlUmZWcGY2WitC?=
 =?utf-8?B?Y1U2ME9YS1hhV2ltMjVBMGtYWEJKRDVjOUszOFUvVXl6REFlbmNYQU1uY3pV?=
 =?utf-8?B?SWgzQkY4WTdMVUlrSEUzN1E4NlM3Z0xSOUZmdEhQcXlrak9IajBVcU0zOG95?=
 =?utf-8?B?K1dZZXYvUTVROWVCb3drek9aMXAvd0h1bnd4YzNDV2tMVTBvK3BSM1dqR1Vq?=
 =?utf-8?B?RkRETmxsejZDL3phYS9KRFBvWFVCcGhlT2JYQ2tTK25md3lFNkMycjAxRFZ6?=
 =?utf-8?B?ZVA1OUJjbkxkVDJvWHhXenRyYVRZUFZlb1VXTDl6Qmo1d3d1QWFoMFJaREhu?=
 =?utf-8?B?UjFpdzkyU0FpeWxLOW8zM2Y0NkFXSlIrZm9Qdjh6d2JreWRVNDlJT1BhQS9k?=
 =?utf-8?B?MzN6aXlqLzgwSW9WU1htNjNsVTRtK2tsdHc4bkh4OWd5MzFMWWdrc2dmWFNI?=
 =?utf-8?B?WkZnTkVYZzlVempoLzI3TkxCTms2dmZzMk15ZFljSlBtMnJkWjRodFZSR1kx?=
 =?utf-8?B?NFVkT28xVm9JVUFrMWs4Mkc5a2Y0ZHNYeTFZcGpMM2NLWE5VQ3FaUmRSZ3hN?=
 =?utf-8?B?VGVqTUtLYnhzQWx0b2t3WlFhWWM5Y1RvUU9OU1R0QjVxUVhvMUovdkhmRmhm?=
 =?utf-8?B?bDBVMU5qdjh1KytFZm5YQ25FQWNsQ0VQc01mTytvOGJaTk1PMzJaSWZVb0xu?=
 =?utf-8?B?YkVlbSsxUlg0ZW9NWi85c0NHYUJ0U0FyZmx4VjAzc3pnNFB3Y05TV2VWTllC?=
 =?utf-8?B?ZWsrc0VURVY0NTg3Njg2akhwWndFemlyOGdSUnhVVURRRWJQUUdhZTlrcThK?=
 =?utf-8?B?WE5DZm5vcnhWRnBkVjR2OWpTT0d2WkJuK09rb1BpVmVvRWRZVGNqWjZHeGRz?=
 =?utf-8?B?VFpOZ0J5Wnlab2NtNW5ERU5VejJuVW41ZnZTVVczVTg0bk0xU0ZUTU11aTJO?=
 =?utf-8?B?OGUzUG5aRW9qZ2R5a3NCdCs0Rys1ODZ0VmtKeGk1WHR6WFJleGRmK0swdFI1?=
 =?utf-8?B?MDVCMEpuZmFjeEpyQkQ2ZTdyRnBLN1RFb0xkZC9CWFZiOStzYVBFNFMzL0Nj?=
 =?utf-8?B?aUp5OGd5bnh5V0ZBRXRpNFpTL25nZmprdnBFOGlkbWowOEhPMnl0NnhlemlM?=
 =?utf-8?B?Z3drL0E3TWxwL0ZNdTRVUVppdlVoK3lvZTJnd1BGYXIyek5yY3V4QlppQXU1?=
 =?utf-8?B?T1ZjbGYvUHZSbktuV2dCOGVQNU1xSHhycVRUYUVKYlU3TGlEa1pSeVE2ZkRQ?=
 =?utf-8?B?b1F1cVR6TTIzZVEyV1BzaEQ2MHpMV21LcW1WZ1hTVUswanpHODQyTlhpcStG?=
 =?utf-8?B?NDY3bTN1SHo0R0Y1eUYxR2tUemFSd2FnbFJBcnNRcGljWHh5dm12N1lXUEhT?=
 =?utf-8?B?ZUEzNllUYVdJcGxkM051bmpSS1NGMit6WjhaZWNmTStvS2VPOG4rK0xGTnlT?=
 =?utf-8?B?OWdMOGdWVExpeTRWNUVhTFRseTYyUnh3ZXdQN2I3Y29FaEdzaGxpR1k3UEVp?=
 =?utf-8?B?WEc0Qklucnk0UHNSRlF4WTZ2czBZYmNPeVFQT1Y2UVh1T2tXQWZqNzgzNmM5?=
 =?utf-8?B?cXUwbUI1dlY5Y3NNNXdmaXYzK0szMC85RFZOc25NbDlaZkc4TCtIN0l1NGpX?=
 =?utf-8?B?d2VncjRVZ2xUVUUvdXV5cU1DMFhYZnkvZW0vMkIvOFRoQTJnUWtlNVBFV1pI?=
 =?utf-8?B?Tk1xcHVTOXdzalRTNGdLcXRrNmw0dWFQWlNQTlVXMGJrTUZZNlpnZTlhdlRF?=
 =?utf-8?B?WGRqS004YmlpV2g4U0RCU0c0UXlpamZ1UmRhUHJ4blRhN0VCN0hQSDFDckxa?=
 =?utf-8?B?ZmhWWnpFVk1UVisrK0RVU0pKSWU1Q2w4ejE1YmxOazVnZTlpWFpzem15d3NR?=
 =?utf-8?B?TGI2RDRzVGwvM25YQnB1NFpkVWJZbGw5TmJrdXc1Mks0MUI4aFdwODBDYjNB?=
 =?utf-8?B?anB1dkQwNFQyTEFabGt0emNqUzJZUUtkVzQyaVg3dTBqc0hYOEhPL0lmeWdY?=
 =?utf-8?Q?OaVD8S6bkPaArXWJ+gOCLxb/x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367bb670-123e-41ef-bc77-08dd39dee8f4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 05:46:11.4363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RsZxRX8J277M9aLUh8Un6Roa6VdtEZ5clVV5hiFG7oYkCxnfsQkaGCSurN7WjAZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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



On 1/13/2025 9:10 AM, Jiang Liu wrote:
> When GPU suspend is aborted, do the same for dGPU as APU to reset
> soc15 asic. Otherwise it may cause following errors:
> [  547.229463] amdgpu 0001:81:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
> 
> [  555.126827] amdgpu 0000:0a:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
> [  555.126901] [drm:amdgpu_gfx_enable_kcq [amdgpu]] *ERROR* KCQ enable failed
> [  555.126957] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <gfx_v9_4_3> failed -110
> [  555.126959] amdgpu 0000:0a:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
> [  555.126965] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -110
> [  555.126966] PM: Device 0000:0a:00.0 failed to resume async: error -110
> 
> This fix has been tested on Mi308X.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index a59b4c36cad7..0e1daefd1a8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -605,12 +605,10 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>  static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
>  {
>  	/* Will reset for the following suspend abort cases.
> -	 * 1) Only reset on APU side, dGPU hasn't checked yet.
> -	 * 2) S3 suspend aborted in the normal S3 suspend or
> -	 *    performing pm core test.
> +	 * 1) S3 suspend aborted in the normal S3 suspend
> +	 * 2) S3 suspend aborted in performing pm core test.
>  	 */
> -	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -			!pm_resume_via_firmware())
> +	if (adev->in_s3 && !pm_resume_via_firmware())
>  		return true;

I don't think this can be applied to all environments. For ex: this may
not be applicable for dGPUs combined with ARM CPUs.

Thanks,
Lijo

>  	else
>  		return false;

