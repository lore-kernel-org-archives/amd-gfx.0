Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3324EEB2718
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EAA10E3B1;
	Tue, 10 Feb 2026 21:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y0G0hAsq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C9510E3B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6mrlTghu5VgNNcTCw7sWfng1pHJs4jJw7Rhn6O1sUj3iolOzXYyw2CQ6U4pDUcKBmn16rGf/C6PAdGdDfqZvSCxt1L7W4d/1lPsS/z3i97papNS3F1LwNrXkwVPT/1AP/Wd8RN8XpBwW8UiOyQY8u6/II+D3QZc6ven/iTC1bTzbFWGvjOnGAfMun8iE0ozegQKhEABPArBSo9C5KpEeerqQhKYVXM3UV1Z9oq587c1gmfzG7Eu4GSGxSGhihwbxOPplLzyAq5IJIRqfAn3hUelAjO6ASUyERuWInR0nS/e3pDoJPGDmSemLJp8k3p5JegTN5PflOtfOgR1jVxpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPIgX6JbISQAvHdXcHtXOoGuyDAERrpB7oBWgKk+WSI=;
 b=rRKJzpqM9ZcWN8/WGKrLXd+rT/RxR+HqtcPra+tVHb/Tcc5bU9h24zU4Fi1dithZJPIujvG3dct6fz8uY0wm0gF7OJxzCFxNv/8gRNqQGfWPlBcB93iZds9cPlA4KULWD2x413lNUXpimYFnSBEf3TDFKUfR6p4M0+q15pPawbTjUii8Y1+h2u1SdDlRerRt7Nlnx++UgpxFawvjVxYau2T/BZWWpdjZSWsoqTGw6hy5irZECQ3aRar965PW8YCGPYmh0W+Q8YZGQBLZpG0pCIixA1IWGs38xIuUahG6k51qJ42SbUiBnhyeE8tyHWnDPWuvW6X4hqA4rNuKtBBrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPIgX6JbISQAvHdXcHtXOoGuyDAERrpB7oBWgKk+WSI=;
 b=y0G0hAsqQhhzJvXbSY0e6eAO+HBe+cvYT+zHs8zphOX2TsTqnXTm2rujChbLv1P5VcYX1lWEo8uMcpIBPGcszd0vw6ruL9zuxGVltkNi6oA7RYzToao/zUqtJQ5AJbBJty3qHiwRxea+1/2v0P7Q0taHE/V+t+OJKRhwJMGYDj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by PH0PR12MB999111.namprd12.prod.outlook.com (2603:10b6:510:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:01:16 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 21:01:16 +0000
Message-ID: <f1a92ba2-96a5-4bb2-971f-60a1857b777d@amd.com>
Date: Tue, 10 Feb 2026 16:01:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] amdgpu: Add amdgpu profiler IOCTL functions
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Cc: david.belanger@amd.com, chris.freehill@amd.com,
 harish.kasiviswanathan@amd.com
References: <20260122151110.3072843-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260122151110.3072843-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::17) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|PH0PR12MB999111:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c28e9b6-8166-4075-f0c8-08de68e787c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alNucXNicWxuRUEvWm1PYjQ1NVBIZG15ajMxZnB1eG01QjRZOC9yUHBkbFNl?=
 =?utf-8?B?QTdra2ZMazhMWFJXVGwxSjFwWGo5NEtMZUZUZTlZa1ZBU25WaDRkQ29IMk0z?=
 =?utf-8?B?Zk1JZFBkME5GUy9lNk10QlhzNzdlSENBUlRVVnhUMk4rWXdiQWtMQmQ0RTl3?=
 =?utf-8?B?SW9uYlc3NWYxZkV3QlZUVDAxa1doR3p3RFJDV0I5akh3b1F3SENRdGlPc0g4?=
 =?utf-8?B?bG5mQkFxT1hpTDlNZExVQnBwV1JBOTVyL0VLak90UldMcTMvazZ1Ykw4ZXhQ?=
 =?utf-8?B?SE9CanVzekFhQmI4YkduV1h2c3Jmb2s1V2JyR24wRk9YVnpKTUc2S05FWXNS?=
 =?utf-8?B?N3hlU01udE9oaXFYS1poekY4blRlS211VVJpYkQ4bTROM3JvbGFUVVNzQWln?=
 =?utf-8?B?Q3pwV1laKzFKNnBpZ0ttOE5BRE9HRmcrN3pLaW5GUGJiNG1aZ3NUTE5MSExU?=
 =?utf-8?B?eitEblpXZHRqWC9XTWJIQWROWHhIQ1ozS09MaUcydldXWE92TmtBd04xS2ZM?=
 =?utf-8?B?Mm1yRU5yMFM1Sml4N2VMc1RHUDBWOEtPd2d5RUVzYlFSSTBNMXJKZ2Y3Z3Vx?=
 =?utf-8?B?cWJEL2g4R1l4OEhGekZRMjdGT3NPRWRvUE42NXRXeFdoNVkvK2ZGYy9zOFYy?=
 =?utf-8?B?QTRMRmVodUowUUN0alJ1RUt4OHd3TlJTYzlkd0N3MFllLzBUd1d0QWZVZFl5?=
 =?utf-8?B?SW9rTmF2RUFxaEdYWHZRRFIwT2tQQUhGcjZmRjcyVll5Mk1JRTJmbDdpRDRW?=
 =?utf-8?B?eHkzLzlzcjVJK3lnK0FFditRQjd2V3pZU2x5UkRaUHJpK2Y2K3JLcUJGU1lr?=
 =?utf-8?B?U0RIaGVUWmw4cUNvc2M0Nk0vYVdtbGY5aklWeFVxV2kvc0F2dlhCZGoySHJ3?=
 =?utf-8?B?ei9ITksvZEJ0KzFzbDZ4RnBMa0RRRWZmQ3lLd1dUdVVkOVlRdFBMTVV5aVU2?=
 =?utf-8?B?MVlaU2ZmTm5CcmR4cGd2dGl6ZzV3cWRpOHNzbXFMR0VWNTlzQ0ZBWEtHdWpo?=
 =?utf-8?B?WCtmcTZQcU5ldzZEdVNvM0NHVi9vdGRhOVJSMm9yVXA3SnhQSzF5ZjJZK0VI?=
 =?utf-8?B?QXY2ODQ2c2JZQ3VFNlltajNqdWhtVnBGdENGL3ZyYlVWMDB5dkhsNE9UVkRE?=
 =?utf-8?B?MWMvTzRySmRPc3FJd1pKOXhvbHBuTmVuYXcvK0xMK0FNdzcyWlg2Y0RyeDhs?=
 =?utf-8?B?U3lhT09JbzZGYnFZaFozemNmS3E1Z3c0UGxMbUkyeXoxaXl3UFV6c0xFVk1H?=
 =?utf-8?B?UE5mTmZyQmhZcStBMm9RbWVCQUN2QW9XWkRXVTNIVUhIeXRRUzd4QU1YekFo?=
 =?utf-8?B?a2V2bGl1ZGdaU3dTNUdOYTFQbVkrQ0x1SC9IcVFjYng0QkRBejczL1lKYjVW?=
 =?utf-8?B?QjlXRlJXV2R3RFMzaHY3RHZoNkl0cHVndzFudmgwdUZsUUE2eE4xZ1lqMFBp?=
 =?utf-8?B?VDVNMEs4UitKVG9VaEZFS2lPNmRIK01zb2JQR1VVd3NvWHZaMitlcEw4Smsy?=
 =?utf-8?B?Y2Z0WmhOamhTQVRqUmhTN1ZEbCs3Zzk0VVBHRHl1cUc3UkViMW1oTll3NTZ5?=
 =?utf-8?B?QWxOVUtTOFVVWHFmdzJ3WkQ1YjFENERYL3lma1pvUHQxREIyTU9uQ1FBY1lR?=
 =?utf-8?B?emhMK1FJS1NWN1c1QmkvRE12SjNPTTF1azRpdlhpQkZCSkkva1JJUmIvcG1C?=
 =?utf-8?B?NnNGZVAreGVmMVQwMFVPV2hEbngvSkpQNCtIN09Sb1F5YXlWUEJzcUFsUS9G?=
 =?utf-8?B?UzMvR3l1VVc1YTJuaDl4eVF4cFEyS01oZ2hQVUEyTWNITUNQaWdUUTJSK1VQ?=
 =?utf-8?B?dWNYV1lJM28vcGJjUGpJUzRsQXYwVk85SUMxTkVJemN6T1VWQXRlOE42R0dK?=
 =?utf-8?B?UnVjQ2M1VGU0dXBmR01WZ2VKa1lvY1cycW5Sa09iMURDMjluZVNNZXlrNXR1?=
 =?utf-8?B?RkFMYzhxU29xYXpSVlJ3eW9LTm44TUkvZEtTOVhGVk1yUS9WUTZIeEJ0VWE2?=
 =?utf-8?B?VUdhQlhadFB6bFJkV0FVWkU1S0dobDVtVGIrZFRrcjJhcFN0Mks1V0hZWmNr?=
 =?utf-8?B?WFRnaFFvTS94Y05xblRYYTlEc2R3SjNjQkJyOHhXM3lRQ3kvbFJ6T1F6TWxl?=
 =?utf-8?Q?ODG4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SklKZjJTanJ4bENCTUtrciswOHU1Wk1KRG1KU3lBU1ZnclRWdG9TVXBCL2gz?=
 =?utf-8?B?MkZCRFFKaGFGMytHZllWanFGbkQvaVdsbzNTVHRJZFRyZDFoeDJreTE2dmls?=
 =?utf-8?B?YytVcXdKcFVEK1hFZ3FlZDc2bUhxSVplQXdmL05yNUhQd3FoUTJuV1M0akQ5?=
 =?utf-8?B?dGxNaFFRZ2RZRjJnRVNVemhpLzVPVzg1RjE1QlE1T2V4Mi9NSm8vc2lxZGdv?=
 =?utf-8?B?c0RsbE45ZFR0Q0QvUEF3QTZORC9iTWtERGpKK3kxN2xNazdodkdEVjNicUE0?=
 =?utf-8?B?SEdROG9rZGtqVEtKU21jclg4Z0dwQnh1a2hQL0VGSXZBNGVFcGgyUkJKcWVQ?=
 =?utf-8?B?NUpNSzhlTU0zS1ZGV1ErcElMNlVQeHNwd0FzTzNoQmlGSTZqRHhUaFB0YjRF?=
 =?utf-8?B?WDBjNGxTQ3dZNFJPanRRSi9XYjN2Y2wvWW1lNGVUdmpxMGFvclQ1L2czWndz?=
 =?utf-8?B?OUwwV3o4OW1GRytVNHIrMWlHbzRiOTlZSGVSUU91Y0YySnN5dzI4djZSb0cz?=
 =?utf-8?B?c3lZU3pocUZqY0Y0VnIzZFhPRHpRdGpmbTJKbjMvemFxOFR4eU5RV3d0Z3BU?=
 =?utf-8?B?Ym4rYnRPNytMYk82a3p4SkIwMmFGc044MU1NZjlHdUtNT25LQzQ1NUdFaGxj?=
 =?utf-8?B?bGJYTU53S2RUYjFwdnlFWXdTbGc1TUswZndMaWg1OXlFV2dsNUh2NVVpZUZU?=
 =?utf-8?B?bStzZ2x0VTNrMWF4WXRHR2JlbXZEcVMxaisxNHNQb3NxazJ5cDhrS0VySVNQ?=
 =?utf-8?B?QWNIbU51SlY0U0RLS2thVmRwRUZBamdQMXU4Y2RKeFFCQ3JmUzB2ZVFJRHZr?=
 =?utf-8?B?d0RaV0tOcCtaY05mNmxqTHVKd3BHZUptbWZzZWZzeEtNckJSUlc2anV5THJm?=
 =?utf-8?B?R0toOHJVZmZVSEJLenRuc0IyU3I0UlV4dXJuRGU3em5iaU04ZlNwTnN1SzJt?=
 =?utf-8?B?YThpZVU3dkpaQ0Zod3ZJMFBnR3FpR1ZhOEFNR1J0czNBOVNLZm5WYUVDeFlF?=
 =?utf-8?B?N3R5YWpqWmpjbUxZRnlOQldGeGNwNWJJYzcyNUVNMVNLeUhRT0tSUlJGYXJE?=
 =?utf-8?B?VmRRMVRBbVdzbDdVeUo4MzVTdUFlK01HS2VwY2RCT2hCT2xTWFVPb2tLTFVF?=
 =?utf-8?B?UnNRTG1FQ2lUTWNINzg0c00vZ21xdVJoT0MrR1Bneng3TkNjSUlNYVhMRTYv?=
 =?utf-8?B?Y3ZiMjhxU2tPakFXanAzYVBVaE1JNDAxRkxzdmo5TUdrQ3pnd3kyWnJEaUta?=
 =?utf-8?B?cmxiejZXOW9xUXYvOHl1ZWIxd2xXODdweTRSMzdhRXFrT0ZFMnBhNHQ1Wklm?=
 =?utf-8?B?QU1CanhHcFNSZmRKa3BEUmF3ZFlzeHZGYmFFSlZZazUzMWRUODhLdDJHM3hF?=
 =?utf-8?B?Tjh2eHYrbHY3T1FRbmVUck8zakpOL0RnQzNtYS9YQnVGNFoxOU5QZGpYUDlN?=
 =?utf-8?B?TGIwYlBoUk5QdHBUaUQ5NXRqeGVVRlpGM3MyR2ZxWmtZWjJ6dmE4RVl1ejBC?=
 =?utf-8?B?Q0MzOGk1TVgxQ1c1UDRKemZlcDJ4WEgvSE1lZXk5RWtiajF1TVZpQ0loSldq?=
 =?utf-8?B?bVFYQlJ2enQrTnNlLzBJYkJFTXRmSUdYQTZjeWVEYVBjYVI1TkxBRFFkamVx?=
 =?utf-8?B?eHp6MForUEN1djFqNVdWOTJCaVJGRit1dDRXaTcxR3FYa1pQZnMzZlNzMXA3?=
 =?utf-8?B?di9lN3NnTTVUcFhhVGUxK1IxWTdhWUxuanlrM1FFQTFRRWpXamFPWjlSdlRO?=
 =?utf-8?B?Vjh4c21FZ2tJL3U1SnpTc1YvZjNjMmRhSWpMSXpBN21TUldiVHBaVk1zb2FC?=
 =?utf-8?B?YnV5SUZQUnJhdDdLakZOV05HZkQ0UHFoTjdVNVZZUEZjVWFZS25TTEJyVE5V?=
 =?utf-8?B?VTB3d05MazQ2L1hOak1wVkpxUWFFYWJGRzZOT3kyWkxlK0Zwa3VGRlJzMWth?=
 =?utf-8?B?emxuNzAxYW8wZUxxRW5vQjhlUnBHbS9OYXF2MTBFaXJTRFpPU1d3Z1dkL0Zz?=
 =?utf-8?B?UWc4QkZiNUhJN3JOYzNBWDBTak5NRTR3VUxmN3pzZUN1ZEtGZUJPTUVlNGVo?=
 =?utf-8?B?c2J1SFpLSlJQMEpVcUMxOFEydkVaL1VuT2lSa00xVFJDM3A4ak9DckRRVzho?=
 =?utf-8?B?eVBXSlpMeUpqOExGaHBUZFpCbEtNS3o1b3AvRm1ETzNpVEpCWG9KaVlBdjRK?=
 =?utf-8?B?ZHRQdmV5QnN4enVmbmN4MVIvdzBZMFpGK0lDT0NlRWRLZUxZMUlBQ2ZSYm1j?=
 =?utf-8?B?R0lURTJ0VWI0cGEzUVYvUTgxK2hacXF4bUxkeUprbkFLdmFYNUk5QWhUdk5k?=
 =?utf-8?Q?8HncntENRuVXzglga3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c28e9b6-8166-4075-f0c8-08de68e787c1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:01:15.9605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Djn+TIYQtPIrWns+/j/yDSARWptp9U/v6XbdO3k0jT1ffB2yl7l2FwTZ3jfFR+lS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999111
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

Ping ...

On 2026-01-22 10:11, James Zhu wrote:
> to support PMC, PCSampling, SPM etc.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   amdgpu/amdgpu.h          |  8 +++++++
>   amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
>   amdgpu/meson.build       |  2 +-
>   include/drm/amdgpu_drm.h | 19 +++++++++++++++++
>   4 files changed, 74 insertions(+), 1 deletion(-)
>   create mode 100644 amdgpu/amdgpu_profiler.c
>
> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
> index 39b61539..87eec030 100644
> --- a/amdgpu/amdgpu.h
> +++ b/amdgpu/amdgpu.h
> @@ -2072,6 +2072,14 @@ int amdgpu_userq_signal(amdgpu_device_handle dev,
>   int amdgpu_userq_wait(amdgpu_device_handle dev,
>   		      struct drm_amdgpu_userq_wait *wait_data);
>   
> +/**
> + * Acquire profiler version
> + * \param   dev               - \c [in]     device handle
> + *
> + * \return  0 on success otherwise POSIX Error code
> + */
> +int amdgpu_profiler_version(amdgpu_device_handle dev);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c
> new file mode 100644
> index 00000000..8d4dffe4
> --- /dev/null
> +++ b/amdgpu/amdgpu_profiler.c
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <string.h>
> +#include <errno.h>
> +#include "xf86drm.h"
> +#include "amdgpu_drm.h"
> +#include "amdgpu_internal.h"
> +
> +drm_public int
> +amdgpu_profiler_version(amdgpu_device_handle dev)
> +{
> +	int ret;
> +	struct drm_amdgpu_profiler_args user_arg;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	memset(&user_arg, 0, sizeof(user_arg));
> +	user_arg.op = AMDGPU_PROFILER_VERSION;
> +
> +	ret = drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
> +				  &user_arg, sizeof(user_arg));
> +
> +	return ret;
> +}
> diff --git a/amdgpu/meson.build b/amdgpu/meson.build
> index 3962d32c..d781f2e9 100644
> --- a/amdgpu/meson.build
> +++ b/amdgpu/meson.build
> @@ -27,7 +27,7 @@ libdrm_amdgpu = library(
>       files(
>         'amdgpu_asic_id.c', 'amdgpu_bo.c', 'amdgpu_cs.c', 'amdgpu_device.c',
>         'amdgpu_gpu_info.c', 'amdgpu_vamgr.c', 'amdgpu_vm.c', 'handle_table.c',
> -      'amdgpu_userq.c',
> +      'amdgpu_userq.c', 'amdgpu_profiler.c',
>       ),
>       config_file,
>     ],
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> index 947bf261..107d2b69 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -57,6 +57,7 @@ extern "C" {
>   #define DRM_AMDGPU_USERQ		0x16
>   #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>   #define DRM_AMDGPU_USERQ_WAIT		0x18
> +#define DRM_AMDGPU_PROFILER			0x20
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -77,6 +78,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> +#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>   
>   /**
>    * DOC: memory domains
> @@ -1616,6 +1618,23 @@ struct drm_amdgpu_info_gpuvm_fault {
>   #define AMDGPU_FAMILY_GC_11_5_0			150 /* GC 11.5.0 */
>   #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
>   
> +/*
> + * Supported Profiler Operations
> + */
> +enum drm_amdgpu_profiler_ops {
> +	AMDGPU_PROFILER_VERSION = 0,
> +};
> +
> +struct drm_amdgpu_profiler_args {
> +	__u32 op;                        /* amdgpu_profiler_op */
> +	union {
> +	    __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
> +	                                  * lower 16 bit: minor
> +	                                  * higher 16 bit: major
> +	                                  */
> +	};
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif
