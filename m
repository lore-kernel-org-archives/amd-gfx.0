Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B08ED26D71
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 16:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D7B710E27A;
	Fri,  9 Jan 2026 16:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ssmnt3BZ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010070.outbound.protection.outlook.com
 [52.101.193.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6616B10E27A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 16:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoRes+ONPd7FBelx7oaOtPAEJxTuJx3DiDf/Bu6OWMUUKve9ntVKt4IljgD9gls9YdHuQ5g3LTW52Afn4HuGQftVq2za7Wz+QyR7CSlW8UbxxEHsIyhZCXQ1Lyjt4DIcjCctJK7noxYlsBSxDbVK2nJpCgXBZRoc8XuJFgCbuJ9mfaicfRTBfJRP+hwI+egIMCTcxBhFZSrTk0lvTe2wfAcxvWPNxbnpAOZlh2DFmC+qyBPYbczAgYFWokmJc0CRzL2eIOZyUVkSxo0JrzUV1o4IJRGrHVpxPmezZowlal7S+YUvuF9oEr/npW7H6D+OL+AT36bigFSBgyX81oaJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8va13iUPaGUu3ZEidv9BefsVjCihiUemxk5TGykakM=;
 b=YVHK22YZMxMAcmKpZvvdMYGqrMLCfCoW84oWbkk7Mcde739JZzzyS2L73aALjuMlOCmhKF32irgUKRKdJXZdcAnVL5x/7JP8/mnBujEHp6eTdOksRdM9ddqV2cGe2HHF2ootlGHD6hSlWjBN80Rguhn0lmOflNi30T+gaqEYcjsnC9/sQyN4kAV+1RRaWtDxsm5MyQsz/8JUDA7U7Xa4c4wV0jeoo2SOhWZTsEP4I2lkBjHV6Hb8WWwmuU/OrV0W+5x7EulEO7Qvsje0wWh+slDxsmjYFvg7CIFio86udKxycFLmCa7AWdiNinhPoWoAtNHOfZcBbieB7gntcbd8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8va13iUPaGUu3ZEidv9BefsVjCihiUemxk5TGykakM=;
 b=ssmnt3BZb5xrTA4XNlmo2UgdmoGTbnZeu4M00wukxTDLsXgBeYWOJdeheimbQ6cNTtJ4fRAf6h5GX/8IGfnuSZP+nE+yRJZniVwotpiSwDkspMc66T4N2CvxHajq3QMiTi3Pu6Vj185C7AJf79en1pJELPnxELaZ+QXT3oAXywY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 16:58:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 16:58:12 +0000
Message-ID: <11d93350-326e-429b-af9e-1b9fcb083ecf@amd.com>
Date: Fri, 9 Jan 2026 17:58:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling
 Last Fence Update and Timeline Management v6
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260109164037.104927-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109164037.104927-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0716.namprd03.prod.outlook.com
 (2603:10b6:408:ef::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 78379338-92c9-4378-4258-08de4fa04614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEcwMW9qTkFZaTdnd05jLzhKSDJ5ZlZTNmY0Q3Brc2dtcC9rcDhaMkpXN3BL?=
 =?utf-8?B?LzZzeFU4Ums1N1JUaitQSFdLZUhRUnQ3WE5IQk15YWM3T1VNdFVMZGpvbWh5?=
 =?utf-8?B?dmhKOVU1N3F5c015dHFVTXhuZVYwOTVCbEw1bGlkZ2wzNFFnRGc1Z0FsN3N6?=
 =?utf-8?B?RjFYYjA4S2JDMkladkQ3bGphcU91RFVmOWhNdGM4dzFpakxHR3Y0RHVxeVRn?=
 =?utf-8?B?MnFvSHZFK3k3VUZZd2ZSZ3ZsWkZzVFpNbFBocGhhRU1uL0JxQUtvRU9MZDJI?=
 =?utf-8?B?dHFrQ1M3TFNZSXpLOE11eXFuM3BULy9DMEdDQ3FTcmhEOHZIY08vbVVoN2d5?=
 =?utf-8?B?bi9CbDhVV3V3VGd5d1NlOG1RYWtNakxScFdoc050Rmc1SlUxZTJGYmNVMTlT?=
 =?utf-8?B?WlhPdzNwbUNpLy8wTW1DYWZFdVJnL0NsVnUzWWtIN0FlVnJOYlN0b1N2cThV?=
 =?utf-8?B?eTB2M1d0amJCWDg1eHAvTFBMNkhyMGZKQmc1M2liWXo4RHZseUdDYjJBNmFQ?=
 =?utf-8?B?NlhxVnpSRU1tWGdSUFZOdGRWNXZPaC9FS1AzTkxOWTdXVkovQ09tdlNVOFhV?=
 =?utf-8?B?TkJzcHNjUit2MHQ3WURqNUFXVFU5bng3V0hkTHQ2QklpUlRUczdsaGFIeFJL?=
 =?utf-8?B?RE1BVzVSeGZaejB0RGtWaVdVak1Sa21uQ3FqMm50aXRUQTVtdjRsT0RnTDFP?=
 =?utf-8?B?RWFhUDZhbHNPY2ZLMXFJWndqU2ZjcDFEUzBSUUZvWS9rSXVqZzNYTXdqMTNL?=
 =?utf-8?B?bisxblNpM1M2QlRMSTBwZkdzaVdhN2owYXNVd0RmU0JvdUpmZ1prQWxjK05p?=
 =?utf-8?B?NHVNRDQ4THlhb21jdUhPcDJzUEVQUjIwcXNPeUFldERzK0FKaWp1bnlwdkhr?=
 =?utf-8?B?STFKcFVyY0MyUjhxcmZ4ZXgxZWFNbkFTYlo0QVdCbzBpdDIwRFIvcTcxb3p5?=
 =?utf-8?B?T1dnVk50c2VwWkNzSnhManhqNzhLQm00U2JFMm1EeE5Gcm1qaS95bGl6U01E?=
 =?utf-8?B?eW55TVNLMHFpWGphNmtDbXg2b0tvOEZqa0gyTWpHT2h2amN3VWdWNHFkUEhY?=
 =?utf-8?B?QmJPZm9xYWIvdmhTcko3RVR3bzIrNzI0RkcveSttU2VJTm45aU5KOStYRi9v?=
 =?utf-8?B?VVErMG1pNWVQYU5OYkRJcERWcHlBUEptdlRxeFBJa08rRUVId2JYNS95N1Rl?=
 =?utf-8?B?eG9lcHhTaHhuNUxjenBQZTdLSUlmUEltNlh3dDBJNzZQaDBsVk5lS2R3MllP?=
 =?utf-8?B?d2phbldKVjhYcjdIdDZFcElrNTNNT0FJUXU4ampZUkVLSS9JSTBJTDdBVUg0?=
 =?utf-8?B?bW0xOTdXemhyZ24xNTY0R0l6REUyejRJMmhKSEd2aCtyTkNUR2ZhcDA1cHJ6?=
 =?utf-8?B?clQzMktidkJ4T0tSZ01rRWh4bEViL1k3aElkVjdGTkVnbFh2ckgvM1hNWEJv?=
 =?utf-8?B?Nk9QM1Y2S1RDMkl0TkY3N0ErWGdieXNvbFNMUzhrQXg2WUFyYkpqMkdMQVhv?=
 =?utf-8?B?ZUJMaWRQbVdFWXg0cklRZU9EZUdVMnlkTFZlKzRBRnQxMVc4U0hRRWxjbnk0?=
 =?utf-8?B?WlYvN2M1SlNKQURHeTEzTmZ5QWJrNFdZNXNKREUzN05jV2t0aDFUVko2R2pD?=
 =?utf-8?B?Nk9GMXR3RG9oZkRlQVQvQXhHY1FORUJiOHdhRHdXUm8rbk1UYWV2WUhvZzlM?=
 =?utf-8?B?Z0RDTTVkaGFwbjErRXFMaGhuaXB5b1dmMGlGWnpuc1l3a0oxWStncEdtWG1r?=
 =?utf-8?B?dThjN0RHbWQrWGY2VTRIMlNPa0RlN0xnQ1BjMTNDbXNWaXdjSUJOL2t6SS8x?=
 =?utf-8?B?VFdFNFNjV2g2S2JvYzJGZ3RwTE1yWXdQZGc4M1BIb1lGSXZCeVFLYURXY1F0?=
 =?utf-8?B?STkrdmRrZjJ0WFFET0J1bDExdXNhWVNXdzZvNEY1ZGNnOTdmZmtIcVB4YnpL?=
 =?utf-8?Q?7ep+opVddy0JVjxc/xMaDZ8+4+n38rH1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDkrV3BqTXBBQWxFRzNFWnhEc3NNYU1QNUNSTmI0cEpoT1pONDhzRjFWSC9E?=
 =?utf-8?B?Si84RlVkZlhvTEgzd2hNNWtER3c5clc4WEk3ZmNJWG8zRnA1Q2hRMUxvODNs?=
 =?utf-8?B?UlJVaXF2WG9iVDZCREJpWUhONWgwTk1ld0Nmb3Y0cHQ2RE0reis1dnBMN2RH?=
 =?utf-8?B?K3I0ZlhlVnFhS0xQZmR2bStDZlBKRUdZU21rR0MvM2FkdGhIODAwSngxbEVZ?=
 =?utf-8?B?MTB4MUUwRFVYVzhpblRidEpFL3V5dUZlVWtpRjlGS21DRURjRVBHUHRhVklH?=
 =?utf-8?B?Q1dtUHBDVlBWcFFuK2tva3RBNjVqbHVPUWFaWlFsYkduNi96QXloWWV0NUlm?=
 =?utf-8?B?bUVTbHRZMFNFRzdHMkZPSmg4T2RVWEN4QU9XaGdSK3Zad2ppMjBGVGhTNC9E?=
 =?utf-8?B?VU1TdEUyUWFmaTVhTjcvRWI0TitlSnlrdFBYcEQ1dnJjcnN6eVdiNWYwQkJw?=
 =?utf-8?B?T0dCa3ZxbXJIcGR1Wnl6eHkyN2FYdHlzM2NvWlMrMXdSMGI2eXFHRmZWVmRX?=
 =?utf-8?B?NUpXK000MkREWlNCWXZYckZ5dlVZcmI0bUxleTJza0gvY2JZdW5JTnBncXVC?=
 =?utf-8?B?bDV0aERDSXhXTTNuRGdhRTNPcG5jS2tVNFVyMitsbWtTaElKMzBycmVZYU1G?=
 =?utf-8?B?cjAxRzF3NndOYktzcjVqQm44TFlRQmErL1pLU01aSldDNDQ1dGJYdHRjbmIz?=
 =?utf-8?B?ZlVYNzI0S1J5b1gvQnZUMzVGRnZMOURjNnErbmdYd2JTMEZudERBeEQxdkVY?=
 =?utf-8?B?YkpaSDIzSERXTVR6WnJNZk9RcFg2a3ZWd1R5bDV0b2tCYTVKZzZmKzJBNjRn?=
 =?utf-8?B?d3BwclB1a2JjUzhJc3pTOUptK2hrQ3VXaURjQnNQZHRGVGdwYjJDWlV4SHNJ?=
 =?utf-8?B?cnEzK0Q2dmNqcklhaEk5RTk5end6YjFXM3I3UkZ6bGhtd28ySDRwMHFaNERi?=
 =?utf-8?B?WHIzamtoNUY0bnQzK2cvQU1yRVFrSFJ4QzNRNU9uQVdPeW1JL0xUUkR4eHZY?=
 =?utf-8?B?M0FZZlFhM3dka1Qyb3hFc3I4OFBYVytjSG5BeFIzRDI4YU85QXFnMUJHbERS?=
 =?utf-8?B?QVZCS1FXRUgwbGtWLzNubmd3dWkzanZNRkpnTHdTc2RQRjl5RGt2UklkelZX?=
 =?utf-8?B?QjJZSHI2ZldDRnZyZlUrdTdHSkNlUGZUc0dRdW5Xbk9PU3JydDg2UTFtSjkw?=
 =?utf-8?B?T1pGVExtUERmN2tOazQ2NC80VlpXS0FaMTQ4OXZxZFdkeUszd3lEK01kRFg5?=
 =?utf-8?B?Z2dtczJVbzdRM1g3cS9PNWFVSGNQQlJHcXhWVVNFZjd0VlArYTBBb1EzSEha?=
 =?utf-8?B?aE5YcVNxcG1WbjByM2hQWGNUZ2xSN3c5OG5BVWVKZ0ZtckNGUE0waGozMnZH?=
 =?utf-8?B?YzhMSU1mcTBzVVh3dWMwcXZRcERhbXpWaG50Nk8rQjMrVVN1Zk42dlNWQThz?=
 =?utf-8?B?dmdHZ2F2NDZhUTIzbFB5SFFUaklyREo5MzliRE9WS1EyUWZ0NUQzclNiRDVK?=
 =?utf-8?B?Zzh0R0hhWU9Qc3g0SFVlQmVVOEppRlpYSk8reFBzN2ZNeURQV3A3dXRKekhZ?=
 =?utf-8?B?Z3d4RkJRZ0JzSmpQYkF0bGVKbWNvdFdHbTJlbzhuc2RDZFdWZ2M0c3VMeWFx?=
 =?utf-8?B?UWp1d004QlUzSUFLN29KREcwMC9rbnNDak0vSHdQN2dnQm5ORU5XVERnT1Ex?=
 =?utf-8?B?SmREdVBRSUxhV2o2ZWhDOGlxMGtYN3pFYTliZWpnNzl5WHdJU0ZJOHY2cE9P?=
 =?utf-8?B?Um8rK2VZOS95RnBqcVBwREVSRjlhS3VWR3F5UUxzbHQrU2g5d3dybVZuS00v?=
 =?utf-8?B?VmdGUHNMUGtMbnFwSU9acStkekVheWhldVpFQXp2T2VBMTVSa2xEbHh0empK?=
 =?utf-8?B?ak5reHVuZGJ2THpOSWh4QVArWGFQTlRpZWxpZnkwRm5udDdxa1RmSjl4dURo?=
 =?utf-8?B?bFFFOE45ZHJqMEJ3ZDdHTi9KWlA0VXd6RldZSkhJbUxHelJpdHZxeldlSXlN?=
 =?utf-8?B?ME12eTErTXUzMXdJbHJoVHRBRlJPV1lLQzhwVDlnNVRBcTNIUm1OM0c2Q1Ri?=
 =?utf-8?B?cTVpVDBWaE55MWw2Sngrc20vS0dEMlFIOHY0ZDNlNmVObUczeVNxUlBsN01O?=
 =?utf-8?B?OXlUTzJzcEZ3N0pvZUdUVGJTOEhnb1pVaWFpWGcyNzVqT0IrOHlWMnQ5K3ZR?=
 =?utf-8?B?YlBxekg1c1BidjdYRHhDMlUvcXpnRlkzZHRBMFpSaVVad0xaTTZ4RW1wb0RQ?=
 =?utf-8?B?enhRWkNtUlJJR2llaWw2Ulk3dWFXaUZzZUx5UHlmemRxWHhPY3liN2lMd2ZW?=
 =?utf-8?Q?/yMdc0pc536E/T8xAQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78379338-92c9-4378-4258-08de4fa04614
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 16:58:12.4173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8oLX7dPhVmLURP5rYMTEapwZkVu0DOwMLiLGdIk7QSJVekCmgqq1E+fUycBrRi9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892
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

On 1/9/26 17:40, Srinivasan Shanmugam wrote:
> When GPU memory mappings are updated, the driver returns a fence so
> userspace knows when the update is finished.
> 
> The previous refactor could pick the wrong fence or rely on checks that
> are not safe for GPU mappings that stay valid even when memory is
> missing. In some cases this could return an invalid fence or cause fence
> reference counting problems.
> 
> Fix this by (v6, per Christian):
> - Starting from the VM’s existing last update fence, so a valid and
>   meaningful fence is always returned even when no new work is required.
> - Selecting the VM-level fence only for always-valid / PRT mappings using
>   the required combined bo_va + bo guard.
> - Using the per-BO page table update fence for normal MAP and REPLACE
>   operations.
> - For UNMAP and CLEAR, returning the fence provided by
>   amdgpu_vm_clear_freed(), which may remain unchanged when nothing needs
>   clearing.
> - Keeping fence reference counting balanced.
> 
> v7: Drop the extra bo_va/bo NULL guard since
>     amdgpu_vm_is_bo_always_valid() handles NULL BOs correctly (including
>     PRT). (Christian)
> 
> This makes VM timeline fences correct and prevents crashes caused by
> incorrect fence handling.
> 
> Fixes: 463b33e780ae ("drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last Fence Update and Timeline Management v4")
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Good work,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 73 +++++++++++++------------
>  1 file changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e5fb8f5346b6..baa624717345 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -732,15 +732,23 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  			struct amdgpu_bo_va *bo_va,
>  			uint32_t operation)
>  {
> -	struct dma_fence *clear_fence = dma_fence_get_stub();
> -	struct dma_fence *last_update = NULL;
> -	int r;
> +	struct dma_fence *fence;
> +	int r = 0;
> +
> +	/* Always start from the VM's existing last update fence. */
> +	fence = dma_fence_get(vm->last_update);
>  
>  	if (!amdgpu_vm_ready(vm))
> -		return clear_fence;
> +		return fence;
>  
> -	/* First clear freed BOs and get a fence for that work, if any. */
> -	r = amdgpu_vm_clear_freed(adev, vm, &clear_fence);
> +	/*
> +	 * First clean up any freed mappings in the VM.
> +	 *
> +	 * amdgpu_vm_clear_freed() may replace @fence with a new fence if it
> +	 * schedules GPU work. If nothing needs clearing, @fence can remain as
> +	 * the original vm->last_update.
> +	 */
> +	r = amdgpu_vm_clear_freed(adev, vm, &fence);
>  	if (r)
>  		goto error;
>  
> @@ -758,35 +766,38 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  		goto error;
>  
>  	/*
> -	 * Decide which fence represents the "last update" for this VM/BO:
> +	 * Decide which fence best represents the last update:
> +	 *
> +	 * MAP/REPLACE:
> +	 *   - For always-valid mappings, use vm->last_update.
> +	 *   - Otherwise, export bo_va->last_pt_update.
>  	 *
> -	 * - For MAP/REPLACE we want the PT update fence, which is tracked as
> -	 *   either vm->last_update (for always-valid BOs) or bo_va->last_pt_update
> -	 *   (for per-BO updates).
> +	 * UNMAP/CLEAR:
> +	 *   Keep the fence returned by amdgpu_vm_clear_freed(). If no work was
> +	 *   needed, it can remain as vm->last_pt_update.
>  	 *
> -	 * - For UNMAP/CLEAR we rely on the fence returned by
> -	 *   amdgpu_vm_clear_freed(), which already covers the page table work
> -	 *   for the removed mappings.
> +	 * The VM and BO update fences are always initialized to a valid value.
> +	 * vm->last_update and bo_va->last_pt_update always start as valid fences.
> +	 * and are never expected to be NULL.
>  	 */
>  	switch (operation) {
>  	case AMDGPU_VA_OP_MAP:
>  	case AMDGPU_VA_OP_REPLACE:
> -		if (bo_va && bo_va->base.bo) {
> -			if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
> -				if (vm->last_update)
> -					last_update = dma_fence_get(vm->last_update);
> -			} else {
> -				if (bo_va->last_pt_update)
> -					last_update = dma_fence_get(bo_va->last_pt_update);
> -			}
> -		}
> +		/*
> +		 * For MAP/REPLACE, return the page table update fence for the
> +		 * mapping we just modified. bo_va is expected to be valid here.
> +		 */
> +		dma_fence_put(fence);
> +
> +		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
> +			fence = dma_fence_get(vm->last_update);
> +		else
> +			fence = dma_fence_get(bo_va->last_pt_update);
>  		break;
>  	case AMDGPU_VA_OP_UNMAP:
>  	case AMDGPU_VA_OP_CLEAR:
> -		if (clear_fence)
> -			last_update = dma_fence_get(clear_fence);
> -		break;
>  	default:
> +		/* keep @fence as returned by amdgpu_vm_clear_freed() */
>  		break;
>  	}
>  
> @@ -794,17 +805,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r && r != -ERESTARTSYS)
>  		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
>  
> -	/*
> -	 * If we managed to pick a more specific last-update fence, prefer it
> -	 * over the generic clear_fence and drop the extra reference to the
> -	 * latter.
> -	 */
> -	if (last_update) {
> -		dma_fence_put(clear_fence);
> -		return last_update;
> -	}
> -
> -	return clear_fence;
> +	return fence;
>  }
>  
>  int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,

