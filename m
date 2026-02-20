Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0362C55ABE
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 13:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31EFB10E068;
	Fri, 20 Feb 2026 13:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FDEBdHrL";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B3410E068
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 13:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhyavXxVv/l5b96I2jIWU6QxjPSnDedLS+khmNbFg1zR9jVQjZi8qhSeC2Gwv4Mdg0FCnHs0iwQOBMq0/EA3vithfBJ/R7q3bfjxuPsUsUVplMQ2cTYpgKCnAmM/AqQn4syddeUGKTO+l35k7eYYRbcaeI1m+AalW7uucWYtpo/o/NdIAnmN7p2K3bR9tkYNHRRirC/B6EKt7b9ko815IHljIjOvkRwKcy77VOMq8axlxbBuQJZwHXWT0o0LnoHzc8KZ7RjFpov2Mf4D5avm78TLJrkoJyVSKcBDYKxldG0hTB6LQCZqxV7n5UUtjN3Vn0lfreVngkedQTrksc99TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cMDeYVxU4rXD4z2Qy2T+6L6rxOWMRiSsCo38OyfpNc=;
 b=reL1t22KyrATEjzQlvFQh+hHo7MFFr5wr2h1jwj2irGMYAKvElZIeb9gZK0a/D6iH9nx3BMjW7AWpbJrSJ+KEhJxLMmmoOX0FgcDn5RBVuv3ozNTDd7XlUEQlZ4LImbC0EYGpJvTMhsfME0vjVVDQxNjmImPk0X7MEszB9xTb8R/iZSuKY0HvMbL7XIA4wSw2cdtIgqAeUDD/qnthEfAlY/dKB6jQcpA7d8V21UTQ8W35cSn2QdyP36LtRNpAgkwmfcrr7GgdzNzbPbMzIkMP7lmySoUfG18LRMXd4NRv0a3FjVIQlyFpo0gc9UeI/MRl8g2vZ7umsbhlkCNZtt99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cMDeYVxU4rXD4z2Qy2T+6L6rxOWMRiSsCo38OyfpNc=;
 b=FDEBdHrLHrzla/F1fAMgTA6X/U1IOfQX21e6ojydDWL3qEtNu0q/ZZDvYmE4eEljrpyyqRbJBYGD1x/4FAZqQ6dFg1dvZ5angs4phNlfJWHqEVxZMYbyOccVymEk+t/ZyvcQ3fBVq+GfCTMVhdoKpYnHYFmnMCONBdU0e3ff0AA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 20 Feb
 2026 13:51:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 13:51:51 +0000
Message-ID: <3c77adc0-d624-45a9-8ed9-6e137968bdae@amd.com>
Date: Fri, 20 Feb 2026 14:51:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdgpu: add upper bound check on user inputs
 in signal/wait ioctl
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <20260220082840.2192325-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20260220082840.2192325-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 334ffbaa-d83f-46d2-b2d3-08de708732ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXZwakRVaWsxalUwN1E1NkwybzhFSnB0S1lRUUpvckg1SlZ4MGhua21ORVBJ?=
 =?utf-8?B?RDM3ODdwYk9CcUJnS0tKUkdtRStuUjhNZXZMMXZLeitMOEswZTBpaWtXdkFa?=
 =?utf-8?B?N3hCTmRiRlUrTVdKT3NSWFhjaEVTeEdvZWdLZ0lSQzBIOTlmcE9lVlZDV0pS?=
 =?utf-8?B?eTBaSjVYRFZSYlQ5dHhYOG1XSUJETmlLL2tqdkFUWjlSRmNYK3NwMTNobmNQ?=
 =?utf-8?B?WUhlRFE2dnczNDRDb0NaMW1hQy9HcVJ3Y0RmUS9MSGM0RVB3Ujk1R0ZRU0RC?=
 =?utf-8?B?SGlvQjNEc3ZEdDlFVGNlZzFRNkRWUm9ranJkYWljREhBa1J5Y2VVblNjOGpq?=
 =?utf-8?B?emF0WExMTERtbEh3WVo1TTIyRnpCZmFndXBacmJzSmx6cnFyaE9ENlRLa0Y5?=
 =?utf-8?B?NFRubFhsQVF5Zk1naHY4aFlNRTZocGZJeUplMGVHM3hvcjI3Z1VlZE5OUjc0?=
 =?utf-8?B?NXZXTDYvc2QyKzloY01ialBPbExCSTh0S2s2emM0S3ZuaWVkUlhTNXFrYlJq?=
 =?utf-8?B?NUJ4S3FkWHJPa1FmeFdWK0ptZkZWQ0gxWHl2OWp2cnhYU2Z1VXg0UTRrT3Vm?=
 =?utf-8?B?MTR3MXI2WTZFdGkvY2hudEtxeHdHSVk4TW1QTE1YZlNYZ3htNzBrbEo4MzRQ?=
 =?utf-8?B?KzlXd2EyUnB6NXJXenZEMENHOVpPUVBkblMwQ0MxYzAxYkNVQXBaaitiR3NU?=
 =?utf-8?B?a25rbDlibHRaekpEdHVHY1B0M2J3RDJnUWgvbzUxVnVMN3lsWVdTSDd4U0ZX?=
 =?utf-8?B?UlZkM2tRTXQwWFdvQWlsVHN6WFpWa0hMOUxkQ2prUDNlT1M2eFBVc1B1ZVdk?=
 =?utf-8?B?WEJoVnNUMG9GRkpSNTMwT2Nld3ZxeGJlVkxGK2RHb3BEejVJR1JBSmhDOHJT?=
 =?utf-8?B?bXVqTVJ0a0VNTkZ0UzN1bGNmUnJPOE5VRThuTE1BeHNnUkg4RElSK0tKSnVj?=
 =?utf-8?B?ZnI2ckFhQ2NMa3ozOE1lVlJQYU1QMTYwaFlXbmF4eW5QZU90V1ljaTRpaFZB?=
 =?utf-8?B?a3lDbUV4WkpGNDFYa2c5WVB1MGc1amhsSVlibno3c0E0ME5yOW8ranNiQ0oy?=
 =?utf-8?B?VmM0Um9HcEwvTERSK21mb0N2VTFleFZkU2JmT2M5S0V2K09FUmxmKzRaNWxP?=
 =?utf-8?B?YlJwOGRyem9aelZ1bkZTeU5HbTd1YU1CNVphMXNQQThBUjZ3eHBlUGMrMHQ4?=
 =?utf-8?B?V1d6dGJtRUhkaTlWb2tOM2FpeHN2YnVUeGRUT0JhRlpXL1E4azRsMGkxTkM4?=
 =?utf-8?B?OC8rdERKZzZBeXUwMi8xdWVtRkJ3eU5Fa25uVXJ0WUo4aWJZcWdMQjJvc1Z6?=
 =?utf-8?B?SFgxRjB5dmRtdTk5MnJWay9EOVBlOFB1VkFrN3lPVEc5OVNjZWNEdVphZnBL?=
 =?utf-8?B?Yzc3cXFQM3J5VmNQc3dCVmoyZGJSRkxRc3pOdWdpbEhDVnIramJBR0Q5cDRn?=
 =?utf-8?B?VXc2RDBjYXhFL2t5eHI3Mkd2L0t3L2pFWWNPOWhQaUdCK1QrTHJob3crcFJo?=
 =?utf-8?B?aStiQ2lHb2xRamdzVWlBcXMra0NXRml0RThoODIrOUtJMEVWWHc1U1pERS9o?=
 =?utf-8?B?NHQvMmRFWDhCWHd4TlFWcmpVdHhod21Pd1AyUkF6cWlxQ05YOXFxVFpPNStH?=
 =?utf-8?B?SWs1cnZCWDZEMFR1b2NTeS8vWE9CbWIwTExhcWZ6WXRDYXVIc3VURFRpeUVl?=
 =?utf-8?B?UXJ6V04xU2xvM1EwOWNLdTVWckZaYUJ0SVZQdzlMWlUyWlNsUjhNVUcrdzVL?=
 =?utf-8?B?eGs3TmNOSnZ0LzBRZ3RTNEpNak9xbmZDOU5aWXQ3L1ArcWRTN2JhdzRKclp6?=
 =?utf-8?B?SzN3N1hvY1NpM2ozWkRwQWl0ZjFONmdGVXB2NW9aMVZqMnRvcktvcjI1L09K?=
 =?utf-8?B?RHJycVNseU9sL3ZxSzczRy83VDFtbDQ4b1NiQ0JGRXBRVGpSRG5hRGFVSC9q?=
 =?utf-8?B?dTExWEhDOWVWUmEvdEJibGl3WlJJZEt4YzVRMHBHTWxCMmJOck1GMFVDaGVl?=
 =?utf-8?B?RGd6SW9WaVJjT1BISFV6VkZwSXYvYjdNODFCdEg0QTF1YmtaVHBKSmoxYk9H?=
 =?utf-8?B?NHFiQlNYbURlUFBYbHkrOW42QjhmRmtuUjYvYWZ5Tjc1Zm8vblZtR0NrVUZH?=
 =?utf-8?Q?Uv98=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2JKTktZM2d2Q1RZNGpEZ3A3WjVnRjhvUDZMOGdFNCttbzBWRkhDTjJwN3k0?=
 =?utf-8?B?K0RpTHNrdHBOUldJNkpKWTRoVTBoalhpdDloUG9QTkFENEhBZmhvNlFuZGZ6?=
 =?utf-8?B?Vk5NSWEzaVgrbCtCUWZ5ZlBhOVUvRWpkOU9uRk5QcW1zV3FCcnVvTVo0N1J5?=
 =?utf-8?B?RXNwQTkwM2JkNS9XSkc5ZTJKdE1OaVViL2tFN2V3NjJnRnpLNEpJcGtRdkVF?=
 =?utf-8?B?eXNEL0NFdUNjdVhDVVhOKzRkdlI3WkUxVjdGUkoxNEhjNTZQSHVBRnNyU3Fi?=
 =?utf-8?B?OG9lVGFDQm9JNDk2LzBXZ2FmQW1OSWpNMkdENmVGTWpmWC90cTZzME1MSXo5?=
 =?utf-8?B?NEsrNHNLZkVCRVluMzZRU2RYcXFGTEs0T2JERGtoaG1aSnQ5RXdXV2M0QlFa?=
 =?utf-8?B?ZmNxUlVSbVlaWE5ub1VHTUFhc0lzZ2paeHNKcEdHYkYvT3kyT1Jtc2ZLdUpL?=
 =?utf-8?B?WS9IK2JpVW5sbENpYURLV3M0V2JpWExya2k1QXFYSHEzQmFzeEx4Wkh3S0RZ?=
 =?utf-8?B?dVlTTzcyYXcrNTB6WnQ4Q1lnV1krdW83bTVsVHV5Y1pOaitBbTRYVWRSUVhY?=
 =?utf-8?B?Z0FzWUtFS041Y1N1cGYyVmVUamVTbjk3NUZra0ZmVmtsbFYxOEtUdkIvcG4z?=
 =?utf-8?B?Z0hCWUpySWl0Sk5TcllpeFVJS25SRWVMQ25FbVlNL2d2TWdraFFaYTVyQXc4?=
 =?utf-8?B?d1oyN1VkamJlY2Ewdm1vMkhZNXBBbmdwV1BNU0NmUzJxcEQ5SzVwMUhxalov?=
 =?utf-8?B?ZTU2SVUyb3h5YXZKSGx2MkdXOENoMlBKbmxyMk4zOUN1YnNUUzREenp4U2Jh?=
 =?utf-8?B?clNhak5zd2taZGVOTS9hUG5naWVvZ1BrcE1OMXFXR3pmc1VQV3NlTnNsU3Rz?=
 =?utf-8?B?SkhTajVmSkQ4Y3RNNGVqTWd5NjF1QURSRHJQeU4vNzMwdWh3V0pJK2tGYmN4?=
 =?utf-8?B?ckRFdzVWaFBnWGNTNVozTVR1RHNKejFpVkZLaFk2ekxsOGg4RUFDYnY5NWNE?=
 =?utf-8?B?aWtZZ2hQM1JVU0U2RTlGVTZCSkE4Z29QZDNobDZuQ1VheS9GWG1UUGhWa3Vj?=
 =?utf-8?B?YlQ2bWFvVHlxQncvUER4ZWJ6ejNiMTFVUWF1djAzaHh6Nk4razg5Nzh2S2Fn?=
 =?utf-8?B?VHRmKy9jM01GZkFjSWYwRm9jSTlYREZINWNrOHBjRUlaSGpQTVhhbS9BS2tr?=
 =?utf-8?B?MThSWURHR1kxdGJPYWVGaVQwa1JnVy9OS1hGTU9WVjdrWWZlSEtyL3RnRjRF?=
 =?utf-8?B?Qno0SHl4S1lHcEJYdVAxRThTS3FaeGVsL2xpeWxBVEpBTTBUeGdYdFdxNE8w?=
 =?utf-8?B?T0hXdUlTeWhqbVA5NWpXTTFndFNtL1J0RllpMC9WQUJhM2I1bTB4TDZHYStV?=
 =?utf-8?B?QWdxSzRZU3FOcTJwazhsaUQweDlTRC9oc2xhbzA5VmhsSFdzeGRIVmtiYjhZ?=
 =?utf-8?B?REE5cjJqSkM0d2YxemxkSG9ZVktoWC94TDZuRzJWKzFzYmJ0djFNb3NtaHpQ?=
 =?utf-8?B?ejBnR0RCWFVCZ1ZBdVVNL2k0NU5sd3FOOW53cmpPa2Znd3RRWjJ0Q0pTczFR?=
 =?utf-8?B?eTg0VXJ4VFZrRVpKOXNGaE0zdXdqTFJDa3lQWm5TcDRSZHRPTFBCNnJYRHdh?=
 =?utf-8?B?Q0l5cG03eFUwWkdEK25pVlM4V2RPSzIwc2xoK0MxbGo4T3g0dkZzT2grdUl3?=
 =?utf-8?B?eFJEUjBvbkpmbTQ3cnBhWVBicE9rQWdqZ2J1TDA5TGk4TFZzc1F1KzNuMWpV?=
 =?utf-8?B?UXJDM3B3WGIyMUJzWnZKN2VQb0tMdGR5MFQ5dVVvc0xQcmcwV1hKMVBkeFlU?=
 =?utf-8?B?L3hMYUNnSTVrbDhzSFdldnBLcHVhTmxMVmJzQ2VwTHBuMHkvSTVrbGUxM1Er?=
 =?utf-8?B?WTRWdWsrOC92NCtlSWF5Yk53RUZ3c3FEajZ0RkpwRFJlYXR2YjFtWVU1bUx3?=
 =?utf-8?B?ZWxvb1ZFeXk2N2JQclU1Wk40QzNxVmc0RVhFRmFsckNpSkFnc0ZtanpleXhL?=
 =?utf-8?B?S0x0NGhFMzl1dG9QWmUzcnJwZ2F4NTlmcTZQSWp0dUp5RmVRMjErcFV3RmN3?=
 =?utf-8?B?ZDJaeUJCMEllQ3lyUTZXbVRKcFI3bWJQYXUvN2hEVnAxU1ZKUHRHTnYzZTBW?=
 =?utf-8?B?amRvdHUvMlAwUm4zSXozTkxOQWEwcGswM1JpR25qODFGYnJBOXdVUFZXem5h?=
 =?utf-8?B?VDQxcVJqQk13d0RwVGVvWjUyM3dKVFA3YVBmekJoRUNsM21sNGVwanAweDQr?=
 =?utf-8?B?NTd0Q2g0U01UWFRiNExjRE5nYkRBUXg4NnFLVEkxYWxRcXZob053WEE3UkJm?=
 =?utf-8?Q?JBTbP6r4AZimc5+IPs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334ffbaa-d83f-46d2-b2d3-08de708732ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:51:51.3091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UfwLZUZ7yZ9Xo8APz4XyXK0Ir/UHbTQmV9qkkKfPg9+6bwoL+XuZVtxN4lEbZS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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

On 2/20/26 09:28, Sunil Khatri wrote:
> There are various input arguments set by user in the signal/wait
> ioctl which could be a huge value eventually leading to a OOM
> condition and system crash and could be exploited.
> 
> So check these input value against AMDGPU_USERQ_MAX_HANDLES
> which is big enough value and also to avoid out of memory
> condition.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a6eb703b62c4..b9810313c5ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -35,6 +35,8 @@
>  static const struct dma_fence_ops amdgpu_userq_fence_ops;
>  static struct kmem_cache *amdgpu_userq_fence_slab;
>  
> +#define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
> +
>  int amdgpu_userq_fence_slab_init(void)
>  {
>  	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
> @@ -480,6 +482,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		return -ENOTSUPP;
>  
>  	num_syncobj_handles = args->num_syncobj_handles;
> +	if (num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES)
> +		return -EINVAL;
> +
>  	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>  					    num_syncobj_handles, sizeof(u32));

There is actually the helper function drm_syncobj_array_find() which should handle all of that.

If it doesn't we need to improve that function.

>  	if (IS_ERR(syncobj_handles))
> @@ -501,6 +506,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	num_read_bo_handles = args->num_bo_read_handles;
> +	if (num_read_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
> +		r = -EINVAL;
> +		goto free_syncobj;
> +	}
> +

Same here, we already have a helper for that. I started using those helpers in my patch.

Maybe just extract that change and apply it separately.

Regards,
Christian.

>  	bo_handles_read = memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
>  					    num_read_bo_handles, sizeof(u32));
>  	if (IS_ERR(bo_handles_read)) {
> @@ -524,6 +534,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	num_write_bo_handles = args->num_bo_write_handles;
> +	if (num_write_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
> +		r = -EINVAL;
> +		goto put_gobj_read;
> +	}
> +
>  	bo_handles_write = memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
>  					     num_write_bo_handles, sizeof(u32));
>  	if (IS_ERR(bo_handles_write)) {
> @@ -666,12 +681,20 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		return -ENOTSUPP;
>  
>  	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	if (num_read_bo_handles > AMDGPU_USERQ_MAX_HANDLES)
> +		return -EINVAL;
> +
>  	bo_handles_read = memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
>  					    num_read_bo_handles, sizeof(u32));
>  	if (IS_ERR(bo_handles_read))
>  		return PTR_ERR(bo_handles_read);
>  
>  	num_write_bo_handles = wait_info->num_bo_write_handles;
> +	if (num_write_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
> +		r = -EINVAL;
> +		goto free_bo_handles_read;
> +	}
> +
>  	bo_handles_write = memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
>  					     num_write_bo_handles, sizeof(u32));
>  	if (IS_ERR(bo_handles_write)) {
> @@ -680,6 +703,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	num_syncobj = wait_info->num_syncobj_handles;
> +	if (num_syncobj > AMDGPU_USERQ_MAX_HANDLES) {
> +		r = -EINVAL;
> +		goto free_bo_handles_write;
> +	}
> +
>  	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>  					    num_syncobj, sizeof(u32));
>  	if (IS_ERR(syncobj_handles)) {
> @@ -688,6 +716,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	num_points = wait_info->num_syncobj_timeline_handles;
> +	if (num_points > AMDGPU_USERQ_MAX_HANDLES) {
> +		r = -EINVAL;
> +		goto free_syncobj_handles;
> +	}
>  	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>  					     num_points, sizeof(u32));
>  	if (IS_ERR(timeline_handles)) {
> @@ -750,6 +782,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		}
>  	}
>  
> +	if (wait_info->num_fences > AMDGPU_USERQ_MAX_HANDLES) {
> +		r = -EINVAL;
> +		goto exec_fini;
> +	}
> +
>  	if (!wait_info->num_fences) {
>  		if (num_points) {
>  			struct dma_fence_unwrap iter;

