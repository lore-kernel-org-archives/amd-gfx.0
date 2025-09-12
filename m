Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F31CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 14:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7583210EC84;
	Fri, 12 Sep 2025 14:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sqd0sRnR";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A158710EC84
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 14:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRnFjFS/h90yUHlNFe7/pft4jYw22E2Af4+56atJ5F/bTnxylMgReQVU9zqQSW7w9d9jdVowa9HpD4vIFqHpV1PAQJ6QZX6pS2W4hOMe8X0fd+g6jjxI6lWMtv8c4C3wU/cnorAZesMKAcaE7HuqLpFIe1Jjd5ANLmqNaIg8TTLRdo54U75NHmfdVN6+yID+XempnTQshjWS9/Ae4mvh8EyR5I7RETwke+pAiP31V6gf2WTAxPI2fbe+HjDhrLAX+zpfvVaF6cu7f1ri5l5m3wz1Gxog4fSd+1TYXp136KW9lsaEyE819Lwb6vGo8FSKc4dlQxUDpgdzckriLvAKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3fkTjQfRWl3BB5IKgG4unqU4uPbiuEdvYj3EF1QoJw=;
 b=aryvp7c6WE3zBq0vtuKD1EhL3tmb5PlbEbGX3/iAnpCZ+jXeed72/WxsfCTU+zSLay0sOBis1MGnOM1WAedR9i1xFq/Cvdh9pIbEmx3UEDGnjcqZOZK8bGBcW2yIW4sEvX4x/TN+IvLshzBQiGc8TPtD3IKGCA5tMH3DZ7EBuk3MEE3/DGyoxn7CGBnRnCrPi2ypsa02A07i5UnAic98BMpksg3QP1sLtraqOyPkTyzy4RBDOL+spaugKuKS88NwvnlZzbvwIYDSLhO16oHlfg8RbbOTS4wBOISsstC2ROm3BWFJaeXb+TE5c67BVfLYZ6BjPwPhZ3UxQSAtf0Rl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3fkTjQfRWl3BB5IKgG4unqU4uPbiuEdvYj3EF1QoJw=;
 b=Sqd0sRnRxqNhtlitu15/5s1H7KYSG5GjU7zKdpy4uyMlCBtPD2/1dQHSQ6iiBkTSyBI4vrUJBrR08XyWj0CVEZoaDB6a5bvjQTNQAqJI5h5BvZZ7Z5IGVUe3Yb2gJMk4ZAxVKevBw4PdrTkA4eSqsqIu+vcieofdS6es1vm/SIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 12 Sep
 2025 14:57:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:57:51 +0000
Message-ID: <6f09f77e-0568-4525-b529-2a06b47be11b@amd.com>
Date: Fri, 12 Sep 2025 16:57:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/2] drm/amdgpu: Simplify user queue locking with global
 device mutex
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20250912093202.4905-1-Jesse.Zhang@amd.com>
 <5a04607d-0d50-4543-8498-52122045048d@amd.com>
 <CADnq5_MoPA7hMc1ffM992pxzU=UeAMaTC2AZBzpC+4Y8uP37gw@mail.gmail.com>
 <45c496ec-d8c7-43c4-b1e4-33453e285bb2@amd.com>
 <CADnq5_ONz2NmSDjTRPV_juM1X-k91wzZG-65jBZ45tvK6bBixw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_ONz2NmSDjTRPV_juM1X-k91wzZG-65jBZ45tvK6bBixw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7fb090-b484-4f7b-441f-08ddf20cbeff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTlIWUZMQ0hwd3Z4NWF2aUpCNE9Ua2hPM1BSWEhxMjVHdDZDQ2phSVVlR0lr?=
 =?utf-8?B?Nk5EU1RTaldKUFpDelh1NWdtbnF3RzA4cWFtQlBSMDdRa0pvWW9pa1NUbzRu?=
 =?utf-8?B?NFVnbEo5UHUvWkxqNTM4OC84K0FwOENJaWJzT0NXRHJtMlkvVzgxSkVYOUpZ?=
 =?utf-8?B?ZVY0bWZvTzZsQmdjSytjREduT1RrNEtjRUZKd2pucWZodlNOL2QybW5BekxQ?=
 =?utf-8?B?Qzg4V204WWgrMUtYcVY5a1NFcCtDbEtlZUpOdDdnYWpqSi95Z3J4cmJaL01C?=
 =?utf-8?B?emJ5bmRjZWQ5ck84T0UrM3RlZ3AzZGgwTXpFN0JRTFNwQlR1elpibDhIOCtt?=
 =?utf-8?B?WGxQQ2xETkw1QXFRS01GQmQ2aDNZbmJidE8wUFdNUkJscDNpSFpxL3FaeDRE?=
 =?utf-8?B?Mmd0QUtoeHQ1WDVuRmNpQlhZM1ZWZlJTQklXd0U2M21FR0tLR2xOaGhLWVFU?=
 =?utf-8?B?ZG5KWDJUNVZFTGFRTFR4QkF4NmJyVm9IemNuMGRobGV6Ykk4bkNwYTNHaDFm?=
 =?utf-8?B?dG5ab09Fa2QrenpzQzl4Sk1oZHFYS1BqSFVxc2lHMUZmWFdlblVBMzg4YUlO?=
 =?utf-8?B?UXdwWmNya0k1QnJ0aDBvaWp0bUo4a2tuSmFmN2E3OUQwVXRCSHluSzdURmZO?=
 =?utf-8?B?bTV0TXBrUWxSb0NSRkRlYlllYXJpdWZOL240VmQ2cXJkeGZiQWU0Vmd5SkxX?=
 =?utf-8?B?WU5mcVVaRjVsTUZwcldxRkNFWmp0NUc3M0NQRDB0Zk56RzN3ZVFjQ3pYWDRx?=
 =?utf-8?B?WU1OVi9DN0RZQ2dJS3FIU24vanU3ODN3SDk1YjRDTjA1Ym40WWpIaW51WlJk?=
 =?utf-8?B?bzVHTlV4aDk0QWxNeGRZaDZiQVI1NXV1akFUZDJ3dGUrdzRtOGRyYk5tSGcw?=
 =?utf-8?B?SXd4ZDVHT1B0c1A0STBiN09YR0pKRVdESllaY21ad0FsSG93dkVEdmx6bTd2?=
 =?utf-8?B?U0FjaXZ2R2w2M0hzenhnYWZsQWw3VU5KQitYS3RkQnFEV2V1UnBwaDJEWThz?=
 =?utf-8?B?VWQ1YkZDYTV0SHp5S0VoeUM0RzlwMWZHMUVPVUxQZ3YrdU9qWFB3UmM4T1lG?=
 =?utf-8?B?WlN1c3ZVQlBjb3JvRkhBZUlscWlyMkVaYnBHQkYyVWZwYVJWTkJFR0pUYXhn?=
 =?utf-8?B?Mi9iNEJuODJtSzRoaVNTQXlha3p3NHE3TzhBVE5HY0FwblBMZVpNT1c1ak9Q?=
 =?utf-8?B?SFZPUXV0ZHhkKzBHSFhPMisvek1OdkJzQyswMkVIelorR0ZFTGpNcVBzVnF0?=
 =?utf-8?B?TUNWNzVXbUV0VEZMVVk5NHpLS0lOcFlhZDdDVVFVWmJ5R0tuT1B0U1Q4d29K?=
 =?utf-8?B?M29wL0hOcDA1V01BREloNGpSUEh0cHQ1NVdvZGNkdENmTFU3dEFPL1V6Rk1G?=
 =?utf-8?B?MU5WK3ZTaFJOSGFkUmE0STlJVmZ1NmcwT2JiL1hZMko2TVkwWEFGZVFyUWlv?=
 =?utf-8?B?WlZsNWoxTEFxbG5PbTBYeWpTQUpnZHBTRDBMcU96eHpoeEdOVkNhUTRvaTkr?=
 =?utf-8?B?N1VoeU8xTmhZRXM5NytWVnBVUzg3S0NxVGZKMXMwSEZIbTcrUE1GUUlwaUEw?=
 =?utf-8?B?UjJNUnZBWFd0WGwrMUloVVBzT29RVFRQaGh2WldzQmg0N0JFbmNIN1lab21z?=
 =?utf-8?B?ek9qdFQ4NDgyMjEyTmJVbCtESm1ReGdSditEMlo4Tmkra2VWYUpXbW1hVFhZ?=
 =?utf-8?B?cUsrcDJlaGF2ZkIzMzlGMlNRVjJFRzNWbFNJQWtTMmhRbk5tZzllUy9NWFhV?=
 =?utf-8?B?SjRvbnhFM1FXeW5lYS92NXlGMmpRcTg5eU1uT2drTHVVZDYwOE04VnZBZFU0?=
 =?utf-8?B?QVdkcWx6MnU5MEM4RExNbURQcmRTemJPQVdjd0szUnlmRVBFcDhzL2RzV090?=
 =?utf-8?B?dVpFaG00MUFMQ0hlQ05nc0Z3UGFlL2RWTHFOM3ZaN2lLT2p2cjc3cWF2akZU?=
 =?utf-8?Q?w8VqG6eJMlQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cisydm9wLzEvWEpnNUJZeHFvNHZ5QS9SaTNpbHRZbFhkcFAveGRBajNYV0dL?=
 =?utf-8?B?NFhjYmlYNE1DN0lraDdEOEJVVk9BeDMyYWpVVTVybTZwSGNjVDBkOG9qeVJC?=
 =?utf-8?B?eHJVdXYzdEpMNTkwT1Nrd2ptdU91NzJ1YnZHQ1BOcGJYam8zSlZBVm1tTHYz?=
 =?utf-8?B?T0ZlY3o4ZlNNTnZjQzV0N01YU3QxLy9ORkZGbEpqV20xb3RWa2t3R3VtSkQy?=
 =?utf-8?B?cnZha1U4R3VZamY4eFdLdHRrWHg4UXBPR2dLS3FYWk9aWTFWTlAwM1ZLd2Fy?=
 =?utf-8?B?VlFSVU40UFpaa0FqVDMrc2lOVXQ0SVNGaGljWW04a3RNRzlhc2tXcE4rMk1s?=
 =?utf-8?B?Nll6Wm4vQ0oyUjBjc3ZGNEVpb2tJUHpBSlYwS2Npc3YzSllzeTZrMkZkazlB?=
 =?utf-8?B?MTFrVEpxcEgyeHg3RkVoOFpCUk1UQWk2Q3dBQVYvSU9WVkp3RTBZbVE0U0Jk?=
 =?utf-8?B?YzhvL1AzRlJwajJTNXEzd01iSkhEVldtMUxTdy9PeVVVWGtjV2UrWURmR05I?=
 =?utf-8?B?UnhJTVVZMVRQTEpzZDFNM0RkbDR2WTd5d1pOZXBESktsMlQvQXB4UCtEbHM2?=
 =?utf-8?B?NUl2UjNpMFN3WG91T2hFY3labzNaWkJ5TUxJaXZ4QmpCTittc0JFV01qTHpv?=
 =?utf-8?B?WldQTHg1VGNlTk1sSnRFdXVaMmJ5cklEd2JSaHV4Wm9Da3hCUTBiVVdRK2J5?=
 =?utf-8?B?VTZHYXhnS0JzM3NqZmhFQ3U3am5Oek9rRzV0U3gvWW1HK1NwMFJRaVhTQld1?=
 =?utf-8?B?amlxN2VtQWpPazdZeENKdFRUVkhBaHl4Vkp2d3dPRUhxc0wrWE1HMnZwaFRX?=
 =?utf-8?B?cDduaWFZWDJkeElQNW5LQzBIQlZDRFNWZmlFTm56OHR4cllyQzg4a1UwRmZz?=
 =?utf-8?B?VG4xMC9tT2FuLzRNc0N4dHNWR2VZM1QxRHluaTlLR09CWHRYeDhHaU1EOHVP?=
 =?utf-8?B?SW9jL2N2MzJRL1VHb1BidFpncHBVbWJEY1VocmMxbVVSRHg2TDVLMjlHSmow?=
 =?utf-8?B?VXh6UGE3WEZjQmFwTGhiRlBZZXh0SWV4czA2NlhsczNSQWtzK1o4N1JhbjFj?=
 =?utf-8?B?ekFqS0JYT2FLZThESnBZaGJUTE1hbnR0NnpqTVVKOVU0MGF1ZUVvWEFQNVg0?=
 =?utf-8?B?ckhPMEdWNDk5Z09GUFZJNVpKVFp0TGV2T2JXMTd5TUVONlM1UDdiYSswKzlQ?=
 =?utf-8?B?VERnKzhYVm15cGFKKzFwalVweEcyV3VISXhLbFUzSDVOM1g1RGJQb1pDS3BU?=
 =?utf-8?B?V2pVa1ZUTWwvTEVEQVl5QjVyUlgxRWk5anh0TTVrSmV5UmNxWE5Vb01FRDBs?=
 =?utf-8?B?bURabWpjSGVLNTVYNWs4eDg4OE5YQWNIM3o0S3Z4WnRMN01Zc3gzb1pQTVVl?=
 =?utf-8?B?Q1FENyswMDl0Z1NsMFBrQjVKSGo2TGpwVGtXcVB4cW1KczNXRzkwQzRBdXdX?=
 =?utf-8?B?aXNmTk9td0U3b2JCNVQvZVZaKzdmNS9VbWVua0Z1OWpHR3R4NjZYQUxWR08x?=
 =?utf-8?B?ZWlDRDVpd25lSGVlMzU0N3dNUU14UWlvNVVFamFpSVI3SlBlK0ZndVJZNVFE?=
 =?utf-8?B?OHVQMHlIQWNwdmtqOUlKSVgrTW83amEyQ1JIMTIzLzBybXo1WUdReDVjYUFa?=
 =?utf-8?B?aGxlclJYak9nVDU3dTVZUmdZcy9FMlRadm9GQnAzRUNjczNSa0JscGwwUzRO?=
 =?utf-8?B?QkVPVHpFZVBBZVZxcEVvZ1Vqb2ZHY3A3cG9QSWorL055Tnl3VVIzZW9zekhO?=
 =?utf-8?B?QUh5L3QwcW43Ylp1TmNyNmpza2pkQlJvTVlvb1NzbTN5VUdmY1hzYTk2SlRN?=
 =?utf-8?B?VHcyT0creXdIdkhLUUxMQ212SmE0UlB1ZzMzSW5vS3FTZ0NtWlNTaS9OekFW?=
 =?utf-8?B?Mm1jQVU0QkZrbHJuaVlxTCt4K0lzVlRyQzAzV0ZqRXptNWtSdTlWRFVvcUpK?=
 =?utf-8?B?WWthTDR4SEdjTmI1S1lSdy9Yb3YzaDZxMUlNSjMxWWVqbGhTbWlFK216RmJi?=
 =?utf-8?B?UXp4NW81aVYrYWFhc3dHVTJBUmlERzNxTVFQc0tpV1hJaEVacVNEcTVlYUtp?=
 =?utf-8?B?b0RibW50V2VPUm1RMGhkVGlZNFZoTnAzUUFsUFJqWTdFT2NXb0dZQjJGT0Zz?=
 =?utf-8?Q?hLUpmQJe3WjeQ61eP360FW9Wt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7fb090-b484-4f7b-441f-08ddf20cbeff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:57:51.7302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5tfQVBB8AJCQxN8YtqaO5xYmL+xijMvHTrzg20f40GP2VgSEmrh2U9nsj91ZSl/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
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

On 12.09.25 16:08, Alex Deucher wrote:
> On Fri, Sep 12, 2025 at 10:06 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 12.09.25 15:02, Alex Deucher wrote:
>>> On Fri, Sep 12, 2025 at 7:17 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> On 12.09.25 11:31, Jesse.Zhang wrote:
>>>>> The current user queue implementation uses a dual-mutex scheme with
>>>>> both per-device (adev->userq_mutex) and per-process (uq_mgr->userq_mutex)
>>>>> locking. This overcomplicated design creates potential deadlock scenarios
>>>>> and makes the code harder to maintain.
>>>>>
>>>>> Simplify the locking by switching entirely to the global adev->userq_mutex
>>>>> for all user queue operations. This approach:
>>>>> - Eliminates potential deadlocks between the two mutexes
>>>>> - Serializes all user queue handling at the kernel level
>>>>> - Provides adequate protection since user queue operations aren't
>>>>>   performance-critical paths
>>>>> - Makes the code more maintainable with a single locking scheme
>>>>>
>>>>> Key changes:
>>>>> 1. Remove uq_mgr->userq_mutex entirely from amdgpu_userq_mgr
>>>>> 2. Consistently use adev->userq_mutex across all user queue operations
>>>>> 3. Add proper work flushing in amdgpu_userq_ensure_ev_fence() to
>>>>>    prevent races when ensuring eviction fence availability
>>>>> 4. Maintain proper locking order throughout all user queue functions
>>>>>
>>>>> The serialization of all user queue operations is acceptable since
>>>>> these are management operations that don't need high parallelism.
>>>>>
>>>>
>>>> Absolutely clear NAK to that.
>>>>
>>>> This also serialized eviction handling making it completely useless.
>>>>
>>>> The global mutex should only be used when new clients open up their connection for the first time or closes the last reference and never otherwise.
>>>
>>> The problem is that the firmware reset code can affect multiple queues
>>> so we need some way to lock all queues during resets so we can
>>> properly update their status.
>>
>> That shouldn't be necessary.
>>
>> When all queues are affected we should use a sequence number to indicate the queue generation.
>>
>> When only a subset of queues are affected then we would need to identify the queues and then set exactly those to an error.
>>
>> So what exactly do we get on information from the FW?
> 
> FW gives us a list of doorbells for queues that were hung and reset.

Yeah, that's what I feared. In this case having two locks are mandatory or otherwise we will automatically run into deadlocks.

See the uq_mgr->userq_mutex is used to prevent new queues from being created while we validate the BOs and restore the VM page tables after an eviction.

Now validating the BOs and restoring the page tables can obviously wait for the GPU reset to finish.

So if we take the same lock inside the GPU reset we also take outside the GPU reset then that obviously can't work.

My suggestion is to drop adev->userq_mutex and use an xarray instead. The xarray has self contained locking and we would then just need to use xa_lock()/xa_unlock() to update and retrive the queue status.

Christian

> 
> Alex
> 
>>
>> Christian.
>>
>>
>>>
>>> Alex
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>>>> ---
>>>>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  7 ++--
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 32 ++++++-------------
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 -
>>>>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  5 +--
>>>>>  4 files changed, 16 insertions(+), 29 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>> index 23d7d0b0d625..d6a07fac7df2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>> @@ -105,9 +105,10 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>>>>       struct amdgpu_eviction_fence_mgr *evf_mgr = work_to_evf_mgr(work, suspend_work.work);
>>>>>       struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
>>>>>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>>>> +     struct amdgpu_device *adev = uq_mgr->adev;
>>>>>       struct amdgpu_eviction_fence *ev_fence;
>>>>>
>>>>> -     mutex_lock(&uq_mgr->userq_mutex);
>>>>> +     mutex_lock(&adev->userq_mutex);
>>>>>       spin_lock(&evf_mgr->ev_fence_lock);
>>>>>       ev_fence = evf_mgr->ev_fence;
>>>>>       if (ev_fence)
>>>>> @@ -118,13 +119,13 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>>>>
>>>>>       amdgpu_userq_evict(uq_mgr, ev_fence);
>>>>>
>>>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>>>> +     mutex_unlock(&adev->userq_mutex);
>>>>>       dma_fence_put(&ev_fence->base);
>>>>>       return;
>>>>>
>>>>>  unlock:
>>>>>       spin_unlock(&evf_mgr->ev_fence_lock);
>>>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>>>> +     mutex_unlock(&adev->userq_mutex);
>>>>>  }
>>>>>
>>>>>  static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> index b649ac0cedff..af92450ea6eb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> @@ -198,17 +198,18 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>>>>>                            struct amdgpu_eviction_fence_mgr *evf_mgr)
>>>>>  {
>>>>>       struct amdgpu_eviction_fence *ev_fence;
>>>>> +     struct amdgpu_device *adev = uq_mgr->adev;
>>>>>
>>>>>  retry:
>>>>>       /* Flush any pending resume work to create ev_fence */
>>>>>       flush_delayed_work(&uq_mgr->resume_work);
>>>>>
>>>>> -     mutex_lock(&uq_mgr->userq_mutex);
>>>>> +     mutex_lock(&adev->userq_mutex);
>>>>>       spin_lock(&evf_mgr->ev_fence_lock);
>>>>>       ev_fence = evf_mgr->ev_fence;
>>>>>       spin_unlock(&evf_mgr->ev_fence_lock);
>>>>>       if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
>>>>> -             mutex_unlock(&uq_mgr->userq_mutex);
>>>>> +             mutex_unlock(&adev->userq_mutex);
>>>>>               /*
>>>>>                * Looks like there was no pending resume work,
>>>>>                * add one now to create a valid eviction fence
>>>>> @@ -362,12 +363,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>>>>>       int r = 0;
>>>>>
>>>>>       cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>>> -     mutex_lock(&uq_mgr->userq_mutex);
>>>>> +     mutex_lock(&adev->userq_mutex);
>>>>>
>>>>>       queue = amdgpu_userq_find(uq_mgr, queue_id);
>>>>>       if (!queue) {
>>>>>               drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
>>>>> -             mutex_unlock(&uq_mgr->userq_mutex);
>>>>> +             mutex_unlock(&adev->userq_mutex);
>>>>>               return -EINVAL;
>>>>>       }
>>>>>       amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
>>>>> @@ -388,7 +389,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>>>>>               queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>>       }
>>>>>       amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>>>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>>>> +     mutex_unlock(&adev->userq_mutex);
>>>>>
>>>>>       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>>>       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>>> @@ -478,7 +479,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>>>               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>>>               return r;
>>>>>       }
>>>>> -
>>>>>       /*
>>>>>        * There could be a situation that we are creating a new queue while
>>>>>        * the other queues under this UQ_mgr are suspended. So if there is any
>>>>> @@ -486,7 +486,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>>>        *
>>>>>        * This will also make sure we have a valid eviction fence ready to be used.
>>>>>        */
>>>>> -     mutex_lock(&adev->userq_mutex);
>>>>>       amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>>>>
>>>>>       uq_funcs = adev->userq_funcs[args->in.ip_type];
>>>>> @@ -588,9 +587,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>>>       kfree(queue_name);
>>>>>
>>>>>       args->out.queue_id = qid;
>>>>> -
>>>>>  unlock:
>>>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>>>>       mutex_unlock(&adev->userq_mutex);
>>>>>
>>>>>       return r;
>>>>> @@ -820,11 +817,12 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>>>>  {
>>>>>       struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>>>>>       struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>>>>> +     struct amdgpu_device *adev = uq_mgr->adev;
>>>>>       int ret;
>>>>>
>>>>>       flush_delayed_work(&fpriv->evf_mgr.suspend_work);
>>>>>
>>>>> -     mutex_lock(&uq_mgr->userq_mutex);
>>>>> +     mutex_lock(&adev->userq_mutex);
>>>>>
>>>>>       ret = amdgpu_userq_validate_bos(uq_mgr);
>>>>>       if (ret) {
>>>>> @@ -839,7 +837,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>>>>       }
>>>>>
>>>>>  unlock:
>>>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>>>> +     mutex_unlock(&adev->userq_mutex);
>>>>>  }
>>>>>
>>>>>  static int
>>>>> @@ -919,7 +917,6 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>>>>>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>>>>>                         struct amdgpu_device *adev)
>>>>>  {
>>>>> -     mutex_init(&userq_mgr->userq_mutex);
>>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>       userq_mgr->adev = adev;
>>>>>       userq_mgr->file = file_priv;
>>>>> @@ -942,7 +939,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>>>       cancel_delayed_work_sync(&userq_mgr->resume_work);
>>>>>
>>>>>       mutex_lock(&adev->userq_mutex);
>>>>> -     mutex_lock(&userq_mgr->userq_mutex);
>>>>>       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>>>>>               amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>>>>>               amdgpu_userq_unmap_helper(userq_mgr, queue);
>>>>> @@ -956,9 +952,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>>>               }
>>>>>       }
>>>>>       idr_destroy(&userq_mgr->userq_idr);
>>>>> -     mutex_unlock(&userq_mgr->userq_mutex);
>>>>>       mutex_unlock(&adev->userq_mutex);
>>>>> -     mutex_destroy(&userq_mgr->userq_mutex);
>>>>>  }
>>>>>
>>>>>  int amdgpu_userq_suspend(struct amdgpu_device *adev)
>>>>> @@ -975,13 +969,11 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>>>>>       mutex_lock(&adev->userq_mutex);
>>>>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>>>>               cancel_delayed_work_sync(&uqm->resume_work);
>>>>> -             mutex_lock(&uqm->userq_mutex);
>>>>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>>>>                       r = amdgpu_userq_unmap_helper(uqm, queue);
>>>>>                       if (r)
>>>>>                               ret = r;
>>>>>               }
>>>>> -             mutex_unlock(&uqm->userq_mutex);
>>>>>       }
>>>>>       mutex_unlock(&adev->userq_mutex);
>>>>>       return ret;
>>>>> @@ -1000,13 +992,11 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>>>>>
>>>>>       mutex_lock(&adev->userq_mutex);
>>>>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>>>> -             mutex_lock(&uqm->userq_mutex);
>>>>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>>>>                       r = amdgpu_userq_map_helper(uqm, queue);
>>>>>                       if (r)
>>>>>                               ret = r;
>>>>>               }
>>>>> -             mutex_unlock(&uqm->userq_mutex);
>>>>>       }
>>>>>       mutex_unlock(&adev->userq_mutex);
>>>>>       return ret;
>>>>> @@ -1031,7 +1021,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>>>       adev->userq_halt_for_enforce_isolation = true;
>>>>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>>>>               cancel_delayed_work_sync(&uqm->resume_work);
>>>>> -             mutex_lock(&uqm->userq_mutex);
>>>>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>>>>                       if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>>>>>                            (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
>>>>> @@ -1041,7 +1030,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>>>                                       ret = r;
>>>>>                       }
>>>>>               }
>>>>> -             mutex_unlock(&uqm->userq_mutex);
>>>>>       }
>>>>>       mutex_unlock(&adev->userq_mutex);
>>>>>       return ret;
>>>>> @@ -1065,7 +1053,6 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>>>               dev_warn(adev->dev, "userq scheduling already started!\n");
>>>>>       adev->userq_halt_for_enforce_isolation = false;
>>>>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>>>> -             mutex_lock(&uqm->userq_mutex);
>>>>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>>>>                       if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>>>>>                            (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
>>>>> @@ -1075,7 +1062,6 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>>>                                       ret = r;
>>>>>                       }
>>>>>               }
>>>>> -             mutex_unlock(&uqm->userq_mutex);
>>>>>       }
>>>>>       mutex_unlock(&adev->userq_mutex);
>>>>>       return ret;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> index c027dd916672..2d63308d55c3 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> @@ -89,7 +89,6 @@ struct amdgpu_userq_funcs {
>>>>>  /* Usermode queues for gfx */
>>>>>  struct amdgpu_userq_mgr {
>>>>>       struct idr                      userq_idr;
>>>>> -     struct mutex                    userq_mutex;
>>>>>       struct amdgpu_device            *adev;
>>>>>       struct delayed_work             resume_work;
>>>>>       struct list_head                list;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> index 95e91d1dc58a..daf3be92a39c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> @@ -464,6 +464,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>>       u32 *bo_handles_write, num_write_bo_handles;
>>>>>       u32 *syncobj_handles, num_syncobj_handles;
>>>>>       u32 *bo_handles_read, num_read_bo_handles;
>>>>> +     struct amdgpu_device *adev = userq_mgr->adev;
>>>>>       int r, i, entry, rentry, wentry;
>>>>>       struct dma_fence *fence;
>>>>>       struct drm_exec exec;
>>>>> @@ -557,14 +558,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>>       /* Create a new fence */
>>>>>       r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>>>>>       if (r) {
>>>>> -             mutex_unlock(&userq_mgr->userq_mutex);
>>>>> +             mutex_unlock(&adev->userq_mutex);
>>>>>               kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>>>>               goto put_gobj_write;
>>>>>       }
>>>>>
>>>>>       dma_fence_put(queue->last_fence);
>>>>>       queue->last_fence = dma_fence_get(fence);
>>>>> -     mutex_unlock(&userq_mgr->userq_mutex);
>>>>> +     mutex_unlock(&adev->userq_mutex);
>>>>>
>>>>>       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>>>>                     (num_read_bo_handles + num_write_bo_handles));
>>>>
>>

