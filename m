Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B906C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 20:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA70F10EB16;
	Thu, 18 Jul 2024 20:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v71nrKZX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A26210EB16
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 20:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsxp6hmsHkJBB8SVxCxpGXd/LZgTC1Oa+oak2h7K+nVAsq5mscFILg/JRwSoUb/xQYjiNS9McCWTkPnRtq4T9DozwPz2LRDD3tM7Uh45HLfItOtt9+x9xvlXHLOm0JFr3w2F+hOi1M5jMdxuhRBLVanu4FN+vrphzggXwDV73gfDmNB6hJ1PLCcoPlgGQoYpCSMy0gMDym6st8HtfXF0G6mJByHmo7kjZAd50FCjRkCMUa+Y0zxuiMiXOju+SPwjvMiwNhJJKVZKiyLvHpEuBT7cKM4he8absO7IIapwRpXwz2dME0FUkhUDLGVOi0eaX5W903yXSwjKl0v1v+2BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PizmEoneUHQuSSBctl41l5lsCoEperxHx+nUBp5Mx/o=;
 b=RPWYhlqSk9F0hgmYWN7FZg8lH6NpdbErDc613TOP9SX/W3+3FM1GqOh1Mu6xkd6whnZyN8jHXcXh2rTOZymBEqkWOmFjWXkjndONcZWliK8xGPffGh+vY8s+9XGdlHtSaay9c5PCqCTf8Zox8HoyybK2VQ2FZg2l9qCGSXfNBnPXQH/ZaDoxMU6Nv1SPQ6wZxXIbKsE8NMDtaOGC2wkHVahA8mvev77rrgFYtPsDCxSEK27Dcm496Rq7PBM0MEZ0T92RdwnnAPMYb5vM8Zh+hDlJa4KWowQYwcOCU40morL79YxSzgj+AZGSVXT9FURoIRzFmG9ZxT0erEHoDUHSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PizmEoneUHQuSSBctl41l5lsCoEperxHx+nUBp5Mx/o=;
 b=v71nrKZXXJabX1XYs2SzMOF/22gNEfdQ+Xs0gBr/WoD504/MibSgCeeFfwTi9yvbdvtSYOXCddlGxEiVtq4D8g/q2S8tVP63cmA7AufFlHXi5OaFic3B0JYCmtDMIt+tcObwcPPqHPYzJq9xmEIR6FIEqm+pGGK1+Rf6BD+fadA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 20:54:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 20:54:55 +0000
Message-ID: <03852487-f4f9-474e-ae92-cfd7a496cab3@amd.com>
Date: Thu, 18 Jul 2024 16:54:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Correct svm prange overlapping handling at
 svm_range_set_attr ioctl
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20240626150633.157464-1-xiaogang.chen@amd.com>
 <0aea26d5-7850-44c8-b072-5d50a9d4c272@amd.com>
 <337411cf-1d45-4bfa-bf23-b4709c318570@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <337411cf-1d45-4bfa-bf23-b4709c318570@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb85298-225d-4803-4407-08dca76be071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUFiNjRiVEVXNTB4TkphQ0V6aDVqVnFna0N5b2xwU29zL3VHeTlkd2hNRm1j?=
 =?utf-8?B?d3Rldnprc1VzRHhGSFhJMkIvbGVFM2tYZVhVclNmZnJ5MThLU212M1JmSXE5?=
 =?utf-8?B?Q0djekR3SzBodUtqS3RQWU5sWFJmd1lnS0VXRm9ncTZrNWltd0hLTWQ1UUFE?=
 =?utf-8?B?blhYaHNpWDMzamFMakQxMG5ERTdlVWlEb2hBbStOZ0pKQnU3M3E1VDM5MDRi?=
 =?utf-8?B?djRaRnAzNzdQeVdEdXFWRmt3Und4eVpzVzRZMktPc3h0ckpBRW5QVTN5TS95?=
 =?utf-8?B?bSt5dC9zeDFVZERIL055YlpnUnpuV2JTZmRTWXBKUUNtOHkzNHlXQTd4ZHJS?=
 =?utf-8?B?a1Y5ZlJxZzJDUGpXQ3NqQU9URDZFK0N5SFBqRWtQS1dxTUN4TmptZTJrVFZD?=
 =?utf-8?B?TzJMYUpJUTdFNXFFQWR3M0pGanE3QXc0WEFkWGc4bXRzMGZTeDlvNnNJQW50?=
 =?utf-8?B?MlpramNFWWFxR25BeFZuNEloT05DNGZZNEoxbkNNZmxxUmNZa1BwOUVRVHBR?=
 =?utf-8?B?Uk0rc3VrdWJDV2NLejhSWlRyTVFxMG01YjlaclJ1MDBBcStuQjkzZ3VnODFQ?=
 =?utf-8?B?cnR1Q0p4ZEFNNnY0SE1NUjJleGdBbzc5TG1jcDFBQTkwVjBSZHdpckV1aUpk?=
 =?utf-8?B?R0xNRWs1OWgrYnQyYVZGV2xvZHFjbVhRREpLcjZwOXBWYm9nRE1aL0M5SFVZ?=
 =?utf-8?B?Mmpkc1V1aGM0L1lWY2ZCRDNOMjdDQ2VaK002MUN4aGFtN0pKelAxZGxtMnZp?=
 =?utf-8?B?dCthWTUrdmU4YjBwQ3ZIQ3gwRFpkd0F3a1UwMWpvcDRwZVJqcGpPNW9IVFEw?=
 =?utf-8?B?YmJjYTdjQ0djK1FPRUdQejJ0Y0VNbEN3NkFSbWx0VFZPVllSallUVSt2OFQr?=
 =?utf-8?B?R3RPUENnQlZTL0dVd3lqaTBsQVVSL1hnLytBWm9KY1FDNzRKVU9tUTdNYllT?=
 =?utf-8?B?SWlzR0hadS9UMWU1alFxYnJhODNyTWtURUdNUjBETHlnYm1zb0p6TVFMeUta?=
 =?utf-8?B?S01zN3pEcE9yTCs5bUwweFZkZEVnNjgweWJ5ditnZ05HblVDU2xlQnJkanNH?=
 =?utf-8?B?YmtTZmd0bjl1UDF3Qnk2WlZXV3VZVHBMMDJZSEZwNTU1N3U5MDV6NXpwUTZI?=
 =?utf-8?B?czFYSjFjSGNWT2ZyTWsrRGg5eHZGVEo3bjNZa3JjMnZ2ck5meXRGNGJKWXdC?=
 =?utf-8?B?eWFFN3BHY1dBbWlleEdpZWpXalVydHB3WUdqQUF0MHVJY0RQRnliRm54Q1Zr?=
 =?utf-8?B?MGl0QXJHcTJkaDV3c09FZXlxa2xkUlVaNCs4MnAzMEJDRFd0S2NQRDhlajVp?=
 =?utf-8?B?R0p1c043blRPd2pMdVZGY0ROc0ZoNTl3dS9kSkd2TStyNGpnRFFqakkwZTd6?=
 =?utf-8?B?YVRMdGZySzVPWkRvcGhsU1kvMnJkS3Z3dURieE8wTHJkUzlOVDM5c2hJWkNN?=
 =?utf-8?B?K01ucVp2U1E1Qk4vSlh2OGNialQzMFozK05MZDhBMGRoaW56OEtUK1V2ZHVO?=
 =?utf-8?B?RTNwZmQ2QnF5ZTYyc3FyWW40VDl2bjVWOU5XcmJmRUZVSFNtdVhydGxOVWEz?=
 =?utf-8?B?ZFMwbmdsaC9TRFZjNU1yeVJhaHR3dUFkRjZ0L3hHRE9oR1V1UTBRcHQ3Y2Vr?=
 =?utf-8?B?eGpSU2pXUXVzUnhtZWUvKzdMdUVXVDd1aGVVZEZDRTMrTGxNYjdHbHh6dG9Y?=
 =?utf-8?B?YXpXOXViRTBFNnR2T1Bta3Uwblg2R0lvSUg1Lzh0eCtiOTY3eGN5cWpXMkhh?=
 =?utf-8?B?ZWJBd2RyalZVVy9tSXFVZzBZeTZ6T1JSN3hxUXRRdEZ1YUdtQzhaN3dPQmpG?=
 =?utf-8?B?TkFWZ0piZS93QTBtdHl1QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi9WYXo0M09BMkh6T0Z6aTR3YzVCRTJDN0NKZitEQnB1MWxzL3pXMVlUQTM5?=
 =?utf-8?B?dVFHNTVBZXNRcENJNXYwOW0xRG9rL1dGMmZmd0FwakRZUlBTMXdmWVRlbUdo?=
 =?utf-8?B?RzhEWVpoVTNaODE3QjN3SUd5a0JDeVBKMldKSHFsTlR3VXdCOFRRK1JZTFBq?=
 =?utf-8?B?cXQxaVo0ZHU0cXZxdGcwMmNVWWZYYmErQzZhaEhZcHFPNGloQksrRW9QY0x2?=
 =?utf-8?B?NFppQlZsU2ZvMTQ2VytXNUl2RFBIZWNZN2p4bjBZVkQxbXhlaEN2NUl2Z2Jp?=
 =?utf-8?B?YWErMXZGZTVFV05kRFk5MytqZmZiY3RGL3ByWnVDZnBISnBNMktvOSt5c3gx?=
 =?utf-8?B?TGlUT3kwdFcrR2x2aGphZGdjUWNXczZteUs3ajBnalNOZVdhcllZeW50U1RY?=
 =?utf-8?B?ejdBeFhubDc5ejEzd2ZETjR5SWFLZkZUOU5pY1FJSitQNHN6bHlkZ3M2Q09r?=
 =?utf-8?B?NXo2ZmNGTlVsSjZGRFlHa0djaTh4MkhkZTIvMlY0N1hUc2ZVQWg0bnp2UzJE?=
 =?utf-8?B?eVg3bUdvZkFoRmlXRXdxbUNCV1BrZHRwSFlsUnByOVRQR1o1RmhtalZ6RVpC?=
 =?utf-8?B?bVBkVU1aODNCMndvdzJncVpFcEVJa2pueFE2SlBsVHk2Uzl4NWM1OUJnWkN0?=
 =?utf-8?B?STFudEJDRDM4S25QeDVQOEZPcm1jRFNpRWZpY3c2MEVCTklkSk45NHNuM0Za?=
 =?utf-8?B?eFo1c1o1dWN1RTRJQjBUUFR5YnJ4OERaZWVaM2F3aTBzUU1HbHRpRFI1b1dn?=
 =?utf-8?B?QVhwMGhkZEFqcmgyWFM3L0tnSHV3bFZPZkdTUHk2TFNrWjgvdVZCNDdCV254?=
 =?utf-8?B?bWd1eHNtcG5WNWlJUStZQStXYWV5ZkRjTk84YUo1SUwyN0cxUCtlR0xWZlc0?=
 =?utf-8?B?QmxuSkVVRWczSmRycFplTEZwb1VuM29NcStaOEc5ellaclVTRjM0MW5ZUWEy?=
 =?utf-8?B?bzZmaFlSdzZQMEtuQVo2NkdEVFJuNVBuakJFNXlQSE1TUmVBbVdQM2ZxUEx4?=
 =?utf-8?B?elZud3hNNUFSSlRYMGFzSXdjNmhDN2VrN2JWUEsxWXFJTnc1OTFaOFE2QzYv?=
 =?utf-8?B?RHFCSGpBZ1Rhd0FQdGd4NUpsMjhFaGF2TEg2YkgvRklCWkJCZUt6MEl1OCti?=
 =?utf-8?B?N2FJdWNTdWFPa3I4UG9Ed05pU1RqdVZXcld0NUVZZFk2cXlYY3d1dUNGbTZT?=
 =?utf-8?B?MHpLKzNlNHh2UzBIeG5iYkx3eFE0YURqK21qSUhUdlJuWVIxc2VvcGhocHIx?=
 =?utf-8?B?eGlJdlJPZmVreVhCOUZ2Zy82N1BoQy80UEhjVWs2a3FGK0EyOTJvZFN5OGNQ?=
 =?utf-8?B?RUVGSzJnZXVFNGRKZlNqNUZPZWlTWTFBVUlBekZkUVRqL3NsdDIwWmtMODVY?=
 =?utf-8?B?OEhJVmxyWURJaVBXY2I1T3ZzQ2owN3FFWkJKNmtDd2lZTVlJNlIrcG8raE9u?=
 =?utf-8?B?aEVvUGJqN1Vwdit0ZTZDcHZuWnl0RHpxZUpvdm5UVHJYWlVrZDBqVkxySWp5?=
 =?utf-8?B?V0ZpWEEvRW9TSmRDN2RSejkzYTAwZDZDaEJhUklPZ1AwUXZSSDdsTDFKMk43?=
 =?utf-8?B?VnJoQjMxUEY2ZzQ4RU1BYkNzTm9WTnZGVHNhVE5HUVR4aEJGempzNUZTVXMz?=
 =?utf-8?B?VkU1LzRwWUkvSUdwWnpxQXVtclI3LzJvRXNpWlR1VkpjYWJkNHBxenNlZ1Ft?=
 =?utf-8?B?YTFLVUNLT0Ywd1FDWkVsc1VxVFcxK21HaDR4Mk5NaGdDeVRnRUxZa3J3Q3Yv?=
 =?utf-8?B?VzlzbHZnSXgyNjVGK3c5aExNWTM1aml1SGJQd0NHdWwwVUhWWndvVXdiS3FR?=
 =?utf-8?B?MVBNeXpCTWdNRFluOW1UYXRXMUNmam9TSW9oT1hPTnVHZEplYjhveUExbDZ6?=
 =?utf-8?B?bzRUWTFvcVV5c0xsMmhJYWZHbjBFOGpRL2hGV3RqcHJFYTNLOXJWYTVkTnd5?=
 =?utf-8?B?YzFaNkhRMEk5NTlsNERlL1ZVTFVPclJxL2Y2ZmU3RjZFbDFnRnpVQXZVNXA1?=
 =?utf-8?B?eXBjWlRKaFhmOG55eDhnOTBnNUUyOUowbUJKL3RWbWszZ3BNUnZ1SFh1Zk4r?=
 =?utf-8?B?TnEydmhMSXFnQXZJMzJlZlRHWjRXcWswRWhkTFBibWR6bXhqREpXQzE2VGV2?=
 =?utf-8?Q?RXJlncUt7OTiFFyHxL/bZgnbG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb85298-225d-4803-4407-08dca76be071
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 20:54:54.9929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24jI8rcYf0NG5Uj9dXWWD74F3RUhn6xhPx/yjeEwLDnp/9vobA8WUPNAS2bJN3MNXoGl5aR98H2aOXo594U4Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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



On 2024-07-18 1:25, Chen, Xiaogang wrote:
> 
> On 7/17/2024 6:02 PM, Felix Kuehling wrote:
>>
>> On 2024-06-26 11:06, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> When user adds new vm range that has overlapping with existing svm pranges
>>> current kfd creats a cloned pragne and split it, then replaces original prange
>>> by it. That destroy original prange locks and the cloned prange locks do not
>>> inherit original prange lock contexts. This may cause issue if code still need
>>> use these locks. In general we should keep using original prange, update its
>>> internal data that got changed during split, then free the cloned prange.
>>
>> While splitting/updating ranges, the svms->lock needs to be held. You cannot have concurrent threads accessing ranges while we're updating the range list. If that is a possibility, you have a race condition anyway. You also can't split, shrink or otherwise modify a range while someone else is accessing that range. So keeping the same locking context is a non-issue.
>>
> We do hold svms->lock when call svm_range_add. The patch does not mean to fix race condition. It keeps original svm range context when we need split/update it. The current implementation "duplicate" a new one, then destroy original svm range.
My point is, nobody can be using the lock context while we update the range list. Therefore it doesn't matter if we replace it with a new one.

> 
>>>
>>> This patch change vm range overlaping handling that does not remove existing
>>> pranges, instead updates it for split and keeps its locks alive.
>>
>> It sounds like you're trying to fix a problem here. Is this an actual or a hypothetical problem?
>>
> It is not a problem in reality so far. It uses a way that not destroy original svm range when split/update it. So keep its locks(prange->lock, prange->migrate_mutex) context. The so called "clone svm range" create new locks that are not related to original locks. I think that is not reasonable.

That's your opinion. In my opinion the current code is perferctly reasonable. There is no technical reason that the prange and its lock context must remain the same. I see no technical justification for a change that makes the code longer, more complex, and introduces the risk of regressions.

Regards,
  Felix

> 
>>
>>>
>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 112 ++++++++++++++++++++-------
>>>   1 file changed, 82 insertions(+), 30 deletions(-)
>>
>> Just looking at the number of added and removed lines, this doesn't look like a simplification. I really question the justification for this change. If it makes the code more complicated or less robust, without a good reason, then it's not a good change.
>>
> As above it does not make code simpler or more complicated. It split/update svm range directly on prange data, not destroy original prange, then generate a new one.
> 
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 407636a68814..a66b8c96ee14 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1967,7 +1967,8 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>>>       return r;
>>>   }
>>>   -static struct svm_range *svm_range_clone(struct svm_range *old)
>>> +/* create a prange that has same range/size/addr etc info as old */
>>> +static struct svm_range *svm_range_duplicate(struct svm_range *old)
>>
>> This seems like an unnecessary name change. "clone" and "duplicate" mean the same thing. But "clone" is shorter.
>>
> 'clone" should mean identical to existing one. Here we use some items from existing svm_range to build new one, the new one is not totally same as existing one, such as the prange->lock is not same between old and new svm range.
> 
>>>   {
>>>       struct svm_range *new;
>>>   @@ -1999,6 +2000,25 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>>>       return new;
>>>   }
>>>   +/* copy range/size/addr info from src to dst prange */
>>> +static void svm_range_copy(struct svm_range *dst, struct svm_range *src)
>>> +{
>>> +    dst->npages = src->npages;
>>> +    dst->start = src->start;
>>> +    dst->last = src->last;
>>> +
>>> +    dst->vram_pages = src->vram_pages;
>>> +    dst->offset = src->offset;
>>> +
>>> +    for (int i = 0; i < MAX_GPU_INSTANCE; i++) {
>>> +        if (!src->dma_addr[i])
>>> +            continue;
>>> +
>>> +         memcpy(dst->dma_addr[i], src->dma_addr[i],
>>> +                src->npages * sizeof(*src->dma_addr[i]));
>>
>> This does not reallocate/resize the dma_addr arrays. Reallocating these arrays can't be done here, because this function is not allowed to fail. That's one reason to use the clone instead of modifying the existing range.
> 
> ok, maybe I can swap dma_addr between dst and src svm range here, then original dma_addr array got freed when free src svm range.
> 
> This patch purpose is to not destroy existing svm range when split/update it since svm_range_add has no mean to remove any existing svm range, even part of it. svm_range_add split or update existing svm ranges.  Maybe we need decide if this idea is valid at first?
> 
> Regards
> 
> Xiaogang
> 
> 
>>
>> Regards,
>>   Felix
>>
>>
>>> +    }
>>> +}
>>> +
>>>   void svm_range_set_max_pages(struct amdgpu_device *adev)
>>>   {
>>>       uint64_t max_pages;
>>> @@ -2057,20 +2077,19 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
>>>    * @attrs: array of attributes
>>>    * @update_list: output, the ranges need validate and update GPU mapping
>>>    * @insert_list: output, the ranges need insert to svms
>>> - * @remove_list: output, the ranges are replaced and need remove from svms
>>>    * @remap_list: output, remap unaligned svm ranges
>>>    *
>>>    * Check if the virtual address range has overlap with any existing ranges,
>>>    * split partly overlapping ranges and add new ranges in the gaps. All changes
>>>    * should be applied to the range_list and interval tree transactionally. If
>>>    * any range split or allocation fails, the entire update fails. Therefore any
>>> - * existing overlapping svm_ranges are cloned and the original svm_ranges left
>>> + * existing overlapping svm_ranges are duplicated and the original svm_ranges left
>>>    * unchanged.
>>>    *
>>> - * If the transaction succeeds, the caller can update and insert clones and
>>> - * new ranges, then free the originals.
>>> + * If the transaction succeeds, the caller can update and insert split ranges and
>>> + * new ranges.
>>>    *
>>> - * Otherwise the caller can free the clones and new ranges, while the old
>>> + * Otherwise the caller can free the duplicated and new ranges, while the old
>>>    * svm_ranges remain unchanged.
>>>    *
>>>    * Context: Process context, caller must hold svms->lock
>>> @@ -2082,7 +2101,7 @@ static int
>>>   svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>>             uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
>>>             struct list_head *update_list, struct list_head *insert_list,
>>> -          struct list_head *remove_list, struct list_head *remap_list)
>>> +          struct list_head *remap_list)
>>>   {
>>>       unsigned long last = start + size - 1UL;
>>>       struct svm_range_list *svms = &p->svms;
>>> @@ -2090,13 +2109,14 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>>       struct svm_range *prange;
>>>       struct svm_range *tmp;
>>>       struct list_head new_list;
>>> +    struct list_head modify_list;
>>>       int r = 0;
>>>         pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
>>>         INIT_LIST_HEAD(update_list);
>>>       INIT_LIST_HEAD(insert_list);
>>> -    INIT_LIST_HEAD(remove_list);
>>> +    INIT_LIST_HEAD(&modify_list);
>>>       INIT_LIST_HEAD(&new_list);
>>>       INIT_LIST_HEAD(remap_list);
>>>   @@ -2117,35 +2137,41 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>>               /* nothing to do */
>>>           } else if (node->start < start || node->last > last) {
>>>               /* node intersects the update range and its attributes
>>> -             * will change. Clone and split it, apply updates only
>>> +             * will change. duplicate and split it, apply updates only
>>>                * to the overlapping part
>>>                */
>>> -            struct svm_range *old = prange;
>>> +            /* prange_dup is a temperal prange that holds size and addr info
>>> +             * updates of pragne after split
>>> +             */
>>> +            struct svm_range *prange_dup;
>>>   -            prange = svm_range_clone(old);
>>> -            if (!prange) {
>>> +            prange_dup = svm_range_duplicate(prange);
>>> +            if (!prange_dup) {
>>>                   r = -ENOMEM;
>>>                   goto out;
>>>               }
>>>   -            list_add(&old->update_list, remove_list);
>>> -            list_add(&prange->list, insert_list);
>>> -            list_add(&prange->update_list, update_list);
>>> -
>>> +            /* split prange_dup */
>>>               if (node->start < start) {
>>>                   pr_debug("change old range start\n");
>>> -                r = svm_range_split_head(prange, start,
>>> +                r = svm_range_split_head(prange_dup, start,
>>>                                insert_list, remap_list);
>>>                   if (r)
>>>                       goto out;
>>>               }
>>>               if (node->last > last) {
>>>                   pr_debug("change old range last\n");
>>> -                r = svm_range_split_tail(prange, last,
>>> +                r = svm_range_split_tail(prange_dup, last,
>>>                                insert_list, remap_list);
>>>                   if (r)
>>>                       goto out;
>>>               }
>>> +
>>> +            /* split success, insert_list has new head/tail pranges */
>>> +            /* move prange from svm list to modify list */
>>> +            list_move_tail(&prange->list, &modify_list);
>>> +            /* put prange_dup at pragne->update_list */
>>> +            list_add(&prange_dup->list, &prange->update_list);
>>>           } else {
>>>               /* The node is contained within start..last,
>>>                * just update it
>>> @@ -2178,8 +2204,38 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>>               svm_range_free(prange, false);
>>>           list_for_each_entry_safe(prange, tmp, &new_list, list)
>>>               svm_range_free(prange, true);
>>> +
>>> +        list_for_each_entry_safe(prange, tmp, &modify_list, list) {
>>> +            struct svm_range *prange_dup;
>>> +
>>> +            /* free pragne_dup that is associated with prange on modify_list */
>>> +            prange_dup = list_first_entry(&prange->update_list, struct svm_range, list);
>>> +            if (prange_dup)
>>> +                svm_range_free(prange_dup, false);
>>> +
>>> +            INIT_LIST_HEAD(&prange->update_list);
>>> +            /* put prange back to svm list */
>>> +            list_move_tail(&prange->list, &svms->list);
>>> +        }
>>>       } else {
>>>           list_splice(&new_list, insert_list);
>>> +
>>> +        list_for_each_entry_safe(prange, tmp, &modify_list, list) {
>>> +            struct svm_range *prange_dup;
>>> +
>>> +            prange_dup = list_first_entry(&prange->update_list, struct svm_range, list);
>>> +            if (prange_dup) {
>>> +                /* update prange from prange_dup */
>>> +                svm_range_copy(prange, prange_dup);
>>> +                /* release temporal pragne_dup */
>>> +                svm_range_free(prange_dup, false);
>>> +            }
>>> +            INIT_LIST_HEAD(&prange->update_list);
>>> +
>>> +            /* move prange from modify_list to insert_list and update_list*/
>>> +            list_move_tail(&prange->list, insert_list);
>>> +            list_add(&prange->update_list, update_list);
>>> +        }
>>>       }
>>>         return r;
>>> @@ -3533,7 +3589,6 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>       struct amdkfd_process_info *process_info = p->kgd_process_info;
>>>       struct list_head update_list;
>>>       struct list_head insert_list;
>>> -    struct list_head remove_list;
>>>       struct list_head remap_list;
>>>       struct svm_range_list *svms;
>>>       struct svm_range *prange;
>>> @@ -3566,7 +3621,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>         /* Add new range and split existing ranges as needed */
>>>       r = svm_range_add(p, start, size, nattr, attrs, &update_list,
>>> -              &insert_list, &remove_list, &remap_list);
>>> +              &insert_list, &remap_list);
>>>       if (r) {
>>>           mutex_unlock(&svms->lock);
>>>           mmap_write_unlock(mm);
>>> @@ -3574,21 +3629,18 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>       }
>>>       /* Apply changes as a transaction */
>>>       list_for_each_entry_safe(prange, next, &insert_list, list) {
>>> -        svm_range_add_to_svms(prange);
>>> -        svm_range_add_notifier_locked(mm, prange);
>>> +        /* prange can be new or existing range, put it at svms->list */
>>> +        list_move_tail(&prange->list, &prange->svms->list);
>>> +        /* update prange at interval trees: svms->objects and
>>> +         * mm interval notifier tree
>>> +         */
>>> +        svm_range_update_notifier_and_interval_tree(mm, prange);
>>> +
>>>       }
>>>       list_for_each_entry(prange, &update_list, update_list) {
>>>           svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
>>>           /* TODO: unmap ranges from GPU that lost access */
>>>       }
>>> -    list_for_each_entry_safe(prange, next, &remove_list, update_list) {
>>> -        pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>>> -             prange->svms, prange, prange->start,
>>> -             prange->last);
>>> -        svm_range_unlink(prange);
>>> -        svm_range_remove_notifier(prange);
>>> -        svm_range_free(prange, false);
>>> -    }
>>>         mmap_write_downgrade(mm);
>>>       /* Trigger migrations and revalidate and map to GPUs as needed. If
