Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F239CA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 21:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C056810E7CF;
	Wed, 13 Aug 2025 21:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KeJLI4Tb";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C72910E7CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 21:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzftL31sfHyrTbZNeUfmC1UOeVL2WwYeFA7tlN8h1s4aUeITJnjB3X1kCgrTdpduUigqaelek9tayN/7/1oC9o4zX3EAGXswdmSo+uPXnYJKJuH4fUPTcZFLE6+kgATxIHQLcbrxE+Fx3V4OpxkPCd7T/58Niz4SpW4WS0pDqp8Q8nUihpc/nooe1e6oWSmFkbBJBPJHy8x6vX++wdbwJotR2V2GZ2yXX13TDaUwODhFlEarc17T3XZbh+zohRCPkm2l7c/SI8ULCXkBobxpJCMmklgsy/l+BrjFWhwPv955tkf1/AucxaC30L2BjrxrLM0dVlnblLE6/xdJnAv3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fs2rw3/VHtFmnVS2bNRrCB+LxFBhpx1OHGXJ4misVw=;
 b=aUk2Yypf71Fe64UVgFxDCmoWePw+9u/6bzceALwkp8DearaikKHdetDDDadGvjxq/4WTRwrdabIwHgbpMZcbkNYAJjQ2dfV+rlWEYY/aNzELWEPizzAN4yuDxjUCvBZn15+HBY8uFf3dSykKGXGuhrUW3bihTTAK6f8ZPxSxcrwfqxiq08A0bpY81RXiiKSM6FQukq3FjWqOVUY/tyUa3fK3W+pqYjL6J+cKHve5HhHm2a/YjiLeXubsaY/DcvWYWOi75YuT8OlgkBaxx6DSP60ncVRgY/Lh2+0WIN8vmuSTq7XWQlStozR4O7CjvbNQUound/WEChLqt3rETjP8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fs2rw3/VHtFmnVS2bNRrCB+LxFBhpx1OHGXJ4misVw=;
 b=KeJLI4TbxPO9BzUqoMQoosEU1l+Jfl59WEflLbsQhvIkn0k/WqA0Mr7KJ/iJ2ZfMIMwBr/atdjgbCiVDqDXUEbpmYMlEm6ukGrKYJqJehoWCI/8LVLwcRpoe2YHVY9zIbC/tI0OeWZcCdEOWHJ9nyYJU1sniQtj0YISk9yWWbIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Wed, 13 Aug
 2025 21:47:34 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 21:47:34 +0000
Message-ID: <85af1027-5a09-40ce-987e-9f4ad8fe2b5c@amd.com>
Date: Wed, 13 Aug 2025 17:47:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: Alex Deucher <alexdeucher@gmail.com>,
 "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::18) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: e34c72b6-f14a-4a1a-674e-08dddab302c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUdUMUE0OWVKYlVmb283TkRtbERJNGtuSGZmQzhlWUZZazRoSittSy9rT2Js?=
 =?utf-8?B?amM2ZmZkejZ5dDkydDBwTy9qcFdpTjBvd2NTcklxd1ljcll0QWpqeXhCSGNP?=
 =?utf-8?B?RXppOWViL042cW9ocmlzdkw0d20zQlV0eWM5c2xNa285MktoQko3TExQajJ3?=
 =?utf-8?B?REVHdTljWmh6MTRpZGtqdTg5ZTB5d0ZEZVhkdDNnZkhoc0t6dlhKSXJLb2Vw?=
 =?utf-8?B?R0pQOEhQUGFWWGltYkpVbi9DODBxTmJ1L1NFTVFqNjlxaDNVazhGOUtIcWcr?=
 =?utf-8?B?YnZQT0RUUGU1TU84bEhDbDlva1lUYUlZbUE5WlNzWmdST1dqQzJHRFh0dDNm?=
 =?utf-8?B?cFVETHgzd3Z4Vi81cE5CUXBQQjNZZUtLeXhoenl5N0EyMCs4Tkxpd0pYMXR6?=
 =?utf-8?B?bGMvejV3cTNISWE4L1RpOTNDWnM3M3BYaTR2bjd0amF3TzFNOVVLRnNzNmdh?=
 =?utf-8?B?blIyT2h1aWtBVkxqVmprSS91YkdxbDBycGpBMndBOU9xcnBtT0N0eUpwOGlH?=
 =?utf-8?B?azI5OHFnd0wzRDd4RDhKeklNZnlQdWJZQkFMcFZMaFhEVStkaGx0VW84OUxC?=
 =?utf-8?B?Rk4vTFNaZCtoOWdiMk5MWjBybGhmTDZ5bm12S1hBMGZpNHBlbkdyK20rZXUz?=
 =?utf-8?B?dzhNeEdnYXhOWVpqMEVqTDMwTSs0SVJONjg4dnhXNWRLSWNmWlQyV0RYZndl?=
 =?utf-8?B?ZVB3NnVnT3hQKzF6RG4xOVJZTFZFY29vRThvSTFnekgvYmFTUzQ1MzdaMlc4?=
 =?utf-8?B?WlQ1ZVFIamZpcEtxSXVkNnZQVmRJcFB4SzNpQzdjc1lndjVYMFlzVk5RQWZl?=
 =?utf-8?B?eE9HdXp1ZWpVaWtxWjc4WEgzU0Q5L2FnUE9rSmFxTWRCajhJUW8zem50WUxY?=
 =?utf-8?B?SDhqVTBBNW5IVnBMUCt4bzJjcTVxbkhFOFFFc05qSktMenZzZm9Sc3IrcEZ0?=
 =?utf-8?B?dENyUlZrZGJobitkYW9wcUcxNTFWNUI4ajgreEFUeGJUa3hNdFkweG1nU1Q1?=
 =?utf-8?B?WDRxMjY3L2hNVVBGZDFCdXN5ZHVnSzhiclpBVDduMGpFQXZXVytpVlVMcFFP?=
 =?utf-8?B?anF6UnZMVkZEVlE4a1hLRWJQNG9hN3lyNTVVY1dvc0JSTkU4MnhvU1c4ZER6?=
 =?utf-8?B?bThteTZvVUJHY3ZGRzBzMS9vaFpoWnNLeklvWlRWS3hiUU1QVnFXM080cFFC?=
 =?utf-8?B?eDV3N2NGMC9JQXV5b0d6eWlzN1NJNHdpeG1iYVZmRWV0Vm1BQ0RPSWNnQjhO?=
 =?utf-8?B?N3RZT1pUZ1huNkc1MjNqdUJCNUhoaWtBRGxLZTJRd2twYXc1Z0QxNHVUaEhF?=
 =?utf-8?B?ZkdNUVJQTm5xemhFNDgyWE5iOFNzYkloc04wT2lWV29neWlDR2gyZXdnSTVo?=
 =?utf-8?B?T1JCaXRwTVlrYmtCbkdEL1VMayttWHBvcjBrSWMzelljRDd1Z2FYekRzdTly?=
 =?utf-8?B?djJObFkrZ2lSaHlCTXppOHJXY3FjS2VzMFN3VkNKZWRHVk1UMXdHWmt0aDRn?=
 =?utf-8?B?OGJoRlB6M0h5WEp2TEVqNEVPL3d6blkyYUhRTWlJYnpFdWhRN25tRVM2Tkhy?=
 =?utf-8?B?dEFzckQ3ckpnVzJyOHFHLzBuTDVKR0FtdFl0aXZVNk00YytLZnhQZVB3blRI?=
 =?utf-8?B?S1dpbmFaQXFVdlptY0tkK3hpRWhmR1dDZ1VqRWQwM3dlWkQrZ3RmUXBJbFYy?=
 =?utf-8?B?cmdwV0x4NFU4Z1FuQTZaa2VONFZrczRJNjFjVHBiM0JUcnhMazcxOXpiYXpu?=
 =?utf-8?B?bTVvVnJyaGNuY3c3OHl5dlh3bEQ2RFdYNEdaenk5T0lyTVozcng5TU1yRDBO?=
 =?utf-8?B?MFNURUxZRkFqcFo3Z0txSFZtWGhENDl0NHVCbnZJUWhJUzNqUmNiK2lIN28w?=
 =?utf-8?B?VEJYc3EwdFJpRUJDYXc3S0dQRXN3aFpROVVKemN1Sjlad0hMUUk0elRtV2tD?=
 =?utf-8?Q?fQ+sg3W/wB4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S21vMitua09wb0s1MXhHRlBZWElaWUV5VnR5UWF5MzVydm5ZWFFmcjhJWExw?=
 =?utf-8?B?MTllWkF5SVBnSk5tcm1rY3B4VnZMYkxYUlBIY1doUXdKWkY3QkttVzE0M292?=
 =?utf-8?B?bk0yZFpVRlFhbGdnSXI3V2E2cnFyWjJaMmhHd2VsWTBCaVl0c2x3dnQ1eEgr?=
 =?utf-8?B?TTgyYUFuMVpLK0luUE9BdENiQVBWVm50dHo4TVNZeUhNbkoyUXJldC9mL09S?=
 =?utf-8?B?Yy9FS0FSenlVRVJWZUpVYjNhZEJwdWdMVVB2NGJVREhhTFJxdGFCM1J1ekI2?=
 =?utf-8?B?M1hTcjRqVFhlYk5xTDV0dXZ3bmUzeitTTGZjRWFaSmJOOC9iWGpWWU42a1ZS?=
 =?utf-8?B?bnlsS1g2cUNzUEtKbUVoUUNuQjVlMVc5YXNyaGwrRWJCZEFEUHRzdklNTENh?=
 =?utf-8?B?NDQ0SzgwVmZNMGJnampXcWlFbkx5U1NobjBQNzR0VFFvWHpReDVqYmQ3YnBx?=
 =?utf-8?B?WE1rSHZqNVA4OWZzdENaSTU5dUFtaHdjOWhhQUZZd292Q3Z6ZnhrcmdNcTc2?=
 =?utf-8?B?UjFjcWxHajd4dVB5dWRINlJKUTdIRHhSaXU2a2xJZ3JBQmNlcjI5Um8vUGgy?=
 =?utf-8?B?SE8yRE5WMTc3aTIwOHVWYWNsaEFSM1BIcXdWMFY5TXdZTkxvdmRpY2I4K1hM?=
 =?utf-8?B?TmJqTVNzRExSZGU4YXRJMTVXcmdJaFphLytHSGc3RzFpYkZNTENUZ1pjeExN?=
 =?utf-8?B?bUlSVHpXK2tsTmVKd2Roa2ZEbjlta2c0UzZxSmE2SS85aGZZeXdkaTBGS2h3?=
 =?utf-8?B?T2lqZk1CZDkwc3ZpMit5SGpRK3B0M2k3OG5uVUpzTzZUYmE0aXpab0F6THNl?=
 =?utf-8?B?WUQ1enovcWtNejVMZWhqcmpLb21Jd1hHR1R3QTdZUHZzNjBNd3N5WlJSZ0t1?=
 =?utf-8?B?cldFVFJJMzFlWThLZEd4SFV5V2lmWFZLdXNnL3ZNRmFpRERNM2xuL0FGdGlR?=
 =?utf-8?B?NEJsQzFLSGNlalI2Qk9oN2xtY0dwWVd4N1pTMlFpYWE4eGhOOXJnTU1mWDA3?=
 =?utf-8?B?MVM2Q21YZklUZ2NwOGk3dWU3SEVXdmNyazR5MncrVWVaN0FGT3dQbUh2R3B3?=
 =?utf-8?B?WWhIMGJiRkQwbVR4K0JHaHZOTHlKdzMxa3o3Mmh3UXdjRWF5MklIclRqak40?=
 =?utf-8?B?TWhkcnU4UVBDMTZXaTd1eHVOejdBdFFEU0RsVFFnSlhxYW13SkliOVYzSU9l?=
 =?utf-8?B?UnFzRnBTT3ZoT0Q4VnlHdDhRVUVsWEgrdytaemg4WWRvaFdnZWFXQjYvQTEv?=
 =?utf-8?B?ZTFxc3l1UE4xbVBzYm0xVWdqaCsxakdtNE5pWEJ6NUpqQVQ3V3JkUzBBYS9j?=
 =?utf-8?B?NEhJSkJjNURZVDVxSk5vOTVIWDE2a1hZTEpjVzQvQlNQNnE4YWNVME4zOVVT?=
 =?utf-8?B?Z3lOVlhXNVdFWG91bVJ2N0c3aW9SampERWkrejQ0UTcvL0dRbklzcjlWalpT?=
 =?utf-8?B?bk4zOWxheVdaeXhTSjd4WVZMVXZzc1BwMWhWalNqQUk4VVV6eitNRXRoaW0y?=
 =?utf-8?B?RXJBYTlPZGlLaWN3cWRxWlpVREkzZGFrdTJZSFRlKy9UYjNGdEhXbG42dTB2?=
 =?utf-8?B?MXp0NVRYZ1RVVk1keHNFcWltdkRYRkhYTWlLQkdDQTJaeHlSNGxiWVhPaXlC?=
 =?utf-8?B?eHJJUE53TzBLTkNOU0syQlhIclh1MnA4Nk90YmhwV2MyOFJ2MG0wbnQ5ZHBN?=
 =?utf-8?B?c3NiODJjcGEzTzZCSWVzTXhEMGt0RlEycTJqemhnTm9SSzNQd2lablVhWFFJ?=
 =?utf-8?B?ZHZ4RHhPMG9jL2ZTVjRPQlZvaXQrb2NkK2F5a00wWjk1NGUxZzg2SGJEc1dM?=
 =?utf-8?B?M3RjblcwTXZnVm9USTd3allLSHIxcGJncytpUkpSdWFjc1JzR0ZZOGh3Q29M?=
 =?utf-8?B?MVI3dzRyT3VXVkxTd2hUS0VNMktkS1BQMlF6REUwSmFyaXZpYXVuM0x3aUpY?=
 =?utf-8?B?VlFTV2d6SFpLYzYvVjJOOC9KckJUcy9RQWtNTWs1dmlIMWJHcUo2MEdBSHNQ?=
 =?utf-8?B?Rm9MVHNKVjdxdWcvRG9EOEJzWVdsRGpJM1B0ZEl0THBldWVHSGw3VVFwMGJG?=
 =?utf-8?B?VWJOVVdCUXVyWk5Od2NXR1JwYVZCMDBLaFgxd0VGWGgzaE5ibnhRSDV6K0hK?=
 =?utf-8?Q?xLugOWGPjogYICFokfvTuv/0A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34c72b6-f14a-4a1a-674e-08dddab302c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:47:33.9119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLnZ7T8zAIKWGg5/pqfJ9iAUrEXFlufBPl1bs26OYdbQ7ov4bZ7krf75OTApis4WfP/RJHDJ42/Fur3v5wqhZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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

On 8/13/2025 5:03 PM, Alex Deucher wrote:
> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
> <sathishkumar.sundararaju@amd.com> wrote:
>>
>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>> Hi Alex, Hi David,
>>>>
>>>> I see David's concern but his suggestion yet wont solve the problem,
>>>> neither the current form , reason :-
>>>>
>>>> The emitted fence count and total submission count are fast transients
>>>> which frequently become 0 in between video decodes (between jobs) even
>>>> with the atomics and locks there can be a switch of video power profile,
>>>> in the current form of patch that window is minimized, but still can
>>>> happen if stress tested. But power state of any instance becoming zero
>>> Can you explain how this can happen?  I'm not seeing it.
>> Consider this situation, inst0 and inst1 actively decoding, inst0 decode
>> completes, delayed idle work starts.
>> inst0 idle handler can read 0 total fences and 0 total submission count,
>> even if inst1 is actively decoding,
>> that's between the jobs,
>>    - as begin_use increaments vcn.total_submission_cnt and end_use
>> decreaments vcn.total_submission_cnt that can be 0.
>>    - if outstanding fences are cleared and no new emitted fence, between
>> jobs , can be 0.
>>    - both of the above conditions do not mean video decode is complete on
>> inst1, it is actively decoding.
> How can there be active decoding without an outstanding fence?  In
> that case, total_fences (fences from both instances) would be non-0.
I think it should be non-0.
I do see a hiccup possible - i.e the power switching from ON to OFF then 
ON in the
middle of decoding, i.e inst0 idle handler turns it off then inst1 turns 
it on.
We should avoid this glitch. This requires the idle handler sets/clears 
a flag for
done for this instance as Sathish's original patch. When all instances 
set/clear the
flag then we can safely power off.
David
> Alex
>
>> Whereas if instances are powered off we are sure idle time is past and
>> it is powered off, no possible way of
>> active video decode, when all instances are off we can safely assume no
>> active decode and global lock protects
>> it against new begin_use on any instance. But the only distant concern
>> is global common locks w.r.t perf, but we
>> are already having a global workprofile mutex , so there shouldn't be
>> any drop in perf, with just one single
>> global lock for all instances.
>>
>> Just sending out a patch with this fix, will leave it to you to decide
>> the right method. If you think outstanding total fences
>> can never be 0 during decode, then your previous version (v3) itself is
>> good, there is no real benefit of splitting the handlers as such.
>>
>> Regards,
>> Sathish
>>> If it is possible, maybe it would be easier to just split the profile
>>> and powergating into separate handlers.  The profile one would be
>>> global and the powergating one would be per instance.  See the
>>> attached patches.
>>>
>>> Alex
>>>
>>>> can be a sure shot indication of break in a video decode, the mistake in
>>>> my patch was using per instance mutex, I should have used a common
>>>> global mutex, then that covers the situation David is trying to bring out.
>>>>
>>>> Using one global vcn.pg_lock for idle and begin_use and using flags to
>>>> track power state could help us totally avoid this situation.
>>>>
>>>> Regards,
>>>>
>>>> Sathish
>>>>
>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>> Hi Alex,
>>>>>>>
>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>>>> The suggestion of moving it inside the lock (which I prefer in case
>>>>>>> someone
>>>>>>> adds more before the lock and not reviewed thoroughly)
>>>>>>>      - up to you to decide.
>>>>>>>
>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> David
>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>> If there are multiple instances of the VCN running,
>>>>>>>> we may end up switching the video profile while another
>>>>>>>> instance is active because we only take into account
>>>>>>>> the current instance's submissions.  Look at all
>>>>>>>> outstanding fences for the video profile.
>>>>>>>>
>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>
>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
>>>>>>>> handling")
>>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>> ++++++++++++-------------
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>      2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>          struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>                  container_of(work, struct amdgpu_vcn_inst,
>>>>>>>> idle_work.work);
>>>>>>>>          struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>> +     unsigned int i, j;
>>>>>>>>          int r = 0;
>>>>>>>>
>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>                  return;
>>>>>>>>
>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>> -             fence[i] +=
>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>>>>>> +
>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>> +                     fence[i] +=
>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>> +             total_fences += fence[i];
>>>>>>>> +     }
>>>>>>>>
>>>>>>>>          /* Only set DPG pause for VCN3 or below, VCN4 and above will
>>>>>>>> be handled by FW */
>>>>>>>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>                  struct dpg_pause_state new_state;
>>>>>>>>
>>>>>>>>                  if (fence[i] ||
>>>>>>>> @@ -436,18 +442,18 @@ static void
>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>                  else
>>>>>>>>                          new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>>>>>>
>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>          }
>>>>>>>>
>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>> -     fences += fence[i];
>>>>>>>> -
>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>                  mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>                  vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>                  mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>> !total_fences &&
>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>                          r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>> false);
>>>>>>>>                          if (r)
>>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>> amdgpu_ring *ring)
>>>>>>>>          int r = 0;
>>>>>>>>
>>>>>>>>          atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>> move this addition down inside the mutex lock
>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>
>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>> -      */
>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>> -             goto pg_lock;
>>>>>>>> -
>>>>>>>>          mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>> move to here:
>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>> I think this should work for multiple instances.
>>>>>> Why does this need to be protected by the mutex?
>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>> David
>>>>>> Alex
>>>>>>
>>>>>>> David
>>>>>>>>          if (!adev->vcn.workload_profile_active) {
>>>>>>>>                  r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>> amdgpu_ring *ring)
>>>>>>>>          }
>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>
>>>>>>>> -pg_lock:
>>>>>>>>          mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>          vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>>>>>>
>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring
>>>>>>>> *ring)
>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>>>>>>>>
>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>
>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>                                VCN_IDLE_TIMEOUT);
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>
>>>>>>>>          uint16_t inst_mask;
>>>>>>>>          uint8_t num_inst_per_aid;
>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>
>>>>>>>>          /* IP reg dump */
>>>>>>>>          uint32_t                *ip_dump;

