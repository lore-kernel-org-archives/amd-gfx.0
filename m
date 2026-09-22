Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B7EC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 08:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD5610E62E;
	Tue, 22 Sep 2026 08:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NaL3vuHp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F3D10E62E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRrzpK/d97ZRyqacIQIjFERfjuTwYRWUEYhKM/kRnzdp16wctC0QEbFW3SFJrI51tcQLop5g3gA1dUwsDJFoyPyCTA3pTkui1CZyyXoT/SxCZaf3NTOJtqcW6SGqfFyhnMGQb9Za4JOW3NUleX+t+6ELmOwcxBOlz075oGvXWxFlW6UaCJlqqnnlZ8BEt0w36+0Qyy+7MVcTvzYvuAz1YEW23tuTZWtrP2X7rXKflmmRkqqWrNiFB4cHV5FObT7DC8uq1s9z0c1/lwkbis1XRpf62Q7nFwCE96bD4OOKgEUHLfuueRO1Mc5II8FVgGBGTw9mroR5SqjcDidAQvXVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV9zfe951Rf4y+3sb1NP0nt55cdg6VchtU5wvEcEPTk=;
 b=R41/RQXaKZzcSPIIIqx3pcoXPkYdCCLleTvDCoP50bkNFy1b90StNONJdHr7eLVjWtF84ZedcVZf54Mu4FgxA+/VTMcJUHmqNnYgz9oGUTJGbbhClu7cPg8d/jZlB3W7JPbxdLFcJ8Y0SbVZuaXegxfC633J6yMW8cWl5hSreE+Y6YoBiVWHCqYUWgVaFtzVvUllARPN4yjUYOSYnA3fhzW16hpfX5MRc7wnPB+nxs400Xvo7MiUWBJUp/z4W5XoxG56qrU9IYJoJAz3mcUj4Wr9Q4irWiyv8f9zNxCLU8tPSQant0jqLjky4+hciRiXiSUkKQPwTr9tXKCA10Dtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV9zfe951Rf4y+3sb1NP0nt55cdg6VchtU5wvEcEPTk=;
 b=NaL3vuHpFf3LcUX9Rfy7JwAiShZGiSoOxByKMWZyOixhPDiPaR7MdhGYlhe84O74lKXGSKDhJSgmNnDjkxIoT4IrNh2d99o2YTt24BmIKM8NH2deb1r3M43DTEr6Tc43IAGoA+164joDauv9oPDwzYc3pt6nK5e0S3mAebHFyRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:04:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 08:04:39 +0000
Message-ID: <580d3ecd-57f0-4b4e-8631-5c27f69ddd54@amd.com>
Date: Tue, 22 Sep 2026 10:04:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
To: Huang Rui <ray.huang@amd.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
 <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
 <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
 <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
 <5f576123-9f57-4da0-a6d5-fd0390e39f1b@amd.com>
 <f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com> <arI0hEYQbrsWVlV1@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <arI0hEYQbrsWVlV1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0043.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fff25d-71a2-4242-5093-08df188026ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fU4oBIemBrxNYMfhj+hLP2AQB/LopchhpxkYm+u/1DU2onBBVeOhsS3ojWabNffH5n9Y49pbEGwXHaYlar9uxuLBnpA8ZEmSn+Rq8tBTRWRjCbtO32BiqXnhj/xeIRRngkp0g3eYQO/pPeenJwFWeZ6t4155flm5OiX0Is5Yu6UcmF48QmA778VLW5bELjvwNLb+4zojy6H2BPK4mAqSQ43nHj3bYh1QgpqwnPNMOphOPelZTcJ0975kgWwI0yFmJ85C5YA3SdnX+ZzH1LS6Xj5TYq7zqxmbDRuW4JIiRDtRbdauQon1p77hplKB/O5uhIYOI+cXUPnw2U84/zHzlIplffD43amzn4cRaj7CgaUxkGvKdWyTzuPsPa3SZH7+OO/1JKbyd7NLx6oIWClWm6VBKPXbfdIFX5BN+Q6PpMpTKMh6OlzSVGZJlOnjWO55u7hw3pzDxuWA5LD1y7ddFAx4ajIXvcw5JaXLT8xVCDGFBihxo1QPfoOBrBv6+oF+dcvP78483w8bI1oRjFubZWG5/COlL6MB2d7NidlHpEVO2twmMuCSyn/u0FSO3iw7ESJ7DLr9tndgPJ7tX6wqoP0R6Aj/IOhV02nxcKfmILr9UCId7EZaPZXNlPeVKF27XXaqumVRMrZC/jtKl3g0Z/irmPJsOC+hUMM76Hlsm8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllueSt6TFlKZ3dpMnRIc2ltVGdTRUdDKy85Z3RCNkFtL2kzUWdOVXpNN3F4?=
 =?utf-8?B?bDZzbktTdERXdFErTm55TlZZc1J3NDFRQUE4UnBGaGUvaVlGVzFITk1HNU9H?=
 =?utf-8?B?SUVsWW9EbUM2amVkQXJyditxdGREbEd3VGdkSUV4UEw3Q0FnbDlseWs2N2pD?=
 =?utf-8?B?aHk1dWpGeXVIVVlSNFpsRTV2LzVZclBXS3d4TzJDbGhySXdZcDlrOHlvMGFk?=
 =?utf-8?B?TkhBZ3BEYnc3T0k2UFVGOForYnFqMEtXeDVzM1JGTmZLQXJFUFZhUTQvQ1k0?=
 =?utf-8?B?czJiQnM4QzJwTTh1SmgwRVpTNXgxbGF5cTNtQ0I5aUl6SE1RekZKbm5YdDEz?=
 =?utf-8?B?eXUxQ2RDL1VXNVR1ZFhDanpmbHBlRlM4RDRubHFlQ3MyMTRqNzJ0cURaLzFJ?=
 =?utf-8?B?Q2l1RnpkSXVoSUdVQlZxL0g0UHpOdXhaS3JhelE5bFhraXB4YVYxVjQwZ1JX?=
 =?utf-8?B?MTdscFJOSDZFK3FEbjkyQ2Y1K2s3dnlaSXJwV1BBbld5NmsrS0R3OHdoMXhB?=
 =?utf-8?B?QjM2NjdmT05KbkRxb0dwQUdCdG8xb0lldC9kMXkxdFJPNHNPQi8zNm5DN0VI?=
 =?utf-8?B?dmVOWHFUSXlyREJ2Z2FYelJaNDBsUk5VWGt0b2IxcHAraGFtd2VYbG5SMTZv?=
 =?utf-8?B?R2pyeXFxM1NhZHpleldNY21pamRzOVBmcmxlSEJOc1VENzFNanhiT1FHVG9w?=
 =?utf-8?B?M2lLWSs1cis2OUNybE5yV3BmTm91NFA1RndTQlFybDFqMXZnbk9lUTNVemV1?=
 =?utf-8?B?SGR1R2IyVy9CS05mTTNWcUZSWFoyNjE5Rnd1clROUlJpQ1RhU0FwLzNOYlB6?=
 =?utf-8?B?RWNITUU0aEZzRnhCd2tucVBYTXhraWUyQ3FOTjVxR0F1eTlNNDVPb2pGaWF3?=
 =?utf-8?B?KytILzdkek8xT0FXT0tYMm5ZUytscTNiNUswOWxZYVh0OEFsZXg0cWJyNyt5?=
 =?utf-8?B?NU5xdjVCRHQ3Tys0ejdkeGdaSGpmcXpUZVBDS1JhTklXeTVoOXBYbXp6QUda?=
 =?utf-8?B?Q1E4TVFEOWJ2ekg2ZmhPVGZrZ2Q0NFBUaC90NzJKWDBpOTFyNFdUYTVHOFF2?=
 =?utf-8?B?ODRuOUpmY0NtaGhQWEdSZU9IUXlaeUptRG14YVJQR2ZBWXRLN2lFaWVFdkI3?=
 =?utf-8?B?bnY4YXUwSGZRUHF1MUxQVHN4NW9mODN4UExrMzhiUUhzait1NTUyQzJqY3M4?=
 =?utf-8?B?L1hITEFBWXZFc3UxV2VWZmRSRlc4UGg5VUROZlhBcXgzL2tGcTJxNFdTM2pR?=
 =?utf-8?B?VnFMTng0S2RzTURta1pzLzkzR0NBU1lrMVRVV3Bhc1FpdHpGeFR2SkwwRmhP?=
 =?utf-8?B?VnB4WlE5a0dMQTdTWUowYm5kenZQYlNrbFdWMG9KaTFmcDVvMlZFSko1ZENX?=
 =?utf-8?B?WFc5WXhWRTh0ekttcnd6V1V4U2tqOU5ab2JMa3Zwa3NRMFgrRTJqbWZoR1RG?=
 =?utf-8?B?Zzk1NHltL0VvelBVUnB4Tms4MFJKbDJXQjRZMTBXbG9RU1gyWmYzbGpUaDhh?=
 =?utf-8?B?bGNDL3Q3U3NnNTRXRm5oTUFBblNXeW53cjdNS25Nck9GZFNyWkNjdmVDNVVL?=
 =?utf-8?B?S1JyVXVPa0l3U3ZhYUlKeXN6U2RJRW9DSTBVQTZveDRxckNVRUQ4SVhPMHlJ?=
 =?utf-8?B?VTdDVlVDMXdxWjlORnU3MUpSQ3MxNS80YmNodWZXd2MzTXRHY1FGbHhBRkcv?=
 =?utf-8?B?UGVXeTZsemNGcFpZeUtjSFZ2azFlS0ZLZ0huUDdIWEkvVWExQXMyNVZRQUIz?=
 =?utf-8?B?OGtJaVlCTHFyZkNFMloyYTEzU2F6a1FGNi9weitJcDdYWlRleDF5WTA3R3N4?=
 =?utf-8?B?Y291UHZEamY1N1RRbGNPdGRrVkxrb3hpU0dTNS9uN2ZNcDZ1d0hsR096NHho?=
 =?utf-8?B?ajMyZmtIWUtGOTRpbGFlZnRnTlFocSttUkRDWGljZXBnalNqdjVZc3NOc0dB?=
 =?utf-8?B?Sk9qUFRPejBZYzdOZmQwdG1tQkFjZllqMnV5M0JqN0ZSWU54N3ZleXh2dnJs?=
 =?utf-8?B?OFJsbi9qR1dkN1F5ODNXT3RGTFJMMUg1U1hwaElnS1lPclJ6YUt6cnQvbGg3?=
 =?utf-8?B?YmFNbE5ILzVVRGdKNkxEMnN5cEk3ODBXd1FrYXd5YmI4QWlIUU1rU2xlQVVT?=
 =?utf-8?B?NUszSHI4dGQ0VGxQYXlYVm1HaWUxL3BycSs1QWZJMEh6V2tjMDFyK2VqZllw?=
 =?utf-8?B?dy9id3VlZXZQQjhqYk9rTWJGTm84RmoybWxxYndtRmpCcWxYZERqaTk4Tnda?=
 =?utf-8?B?NThiV2c4dzk0cVEyV3VGNTdOdUp6NitaOWtMK1FtM1BlM2tLSmVJbGFHNFNU?=
 =?utf-8?Q?n3iE7dYoVBUaBcMJyF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fff25d-71a2-4242-5093-08df188026ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:04:39.5594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmQmRcbtOMazooKfye+dQPB8lmyJ9gEGLHNgzCGCC2Obi5u4zLdcB+3LBKscVZ0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
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

On 9/22/26 09:55, Huang Rui wrote:
...
>> As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.
>>
> 
> Assuming every kref_get() has a matching kref_put(), and the queue object
> itself does not participate in a circular ownership chain, I don't
> immediately see how taking a temporary queue reference would cause
> correctness issues.

The reference on the user queue object is meant to keep it alive for the duration of IOCTLs, e.g. prevent concurrent destruction from the close IOCTL.

It CAN'T be used to grab references from either atomic, interrupt or worker context since then you can't drop the reference any more without risking destruction from non IOCTL context which in turn causes tons of lifetime problems.

This is just standard refcounting rules to keep objects alive during an IOCTL.
> Could you please point us to the historical issue or the corresponding
> commits that led to removing this approach previously?

See Sunils original approach, he made exactly the same mistake and I already had to fix that back then.

I don't remember if it was actually committed or if we only discussed that on the mailing list.

Regards,
Christian.

> 
> Thanks,
> Ray
