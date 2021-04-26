Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931BAC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 20:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C35613AA
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 20:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C35613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3066E145;
	Mon, 26 Apr 2021 20:24:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1526E145
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 20:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUNDRdsaifhbOFWbNNsxCoDVvUZKJNwMgadhn3uPWuSXN1QcQXGEz/ETbENLw+8TWaZM2+LX6B74kB2mWWx9GRQD1TrEySycmkn8BU5UUDxfSlnEaZhQZ32OPSqmF+qKz4U8r0GJN9MSY8JOHngdatHP7cKT/lTv9TrLrhtEzOBU0FxnPfIF63acdREH6v4I4eMji4Qj4sxVz8nNBmH0TcqOtl5x5qgHySxks34z5No4zWsle3F6BLfAVBA7zLy1HtYDbsDp//PGfY/DdEqIYoXtYR0t7wPip6K+3F6rKd9ew9S5/tk0mCfa7ElvkQmJ3ukzePAL5ZbIeI71WR063A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QqSNzZ8FbQdmC5MJEYbVyGE8VPV4zU+zZehcZX7oaU=;
 b=VeG3km/x3jSZ9XYVT8Nq7tgMFNdOjzW0JBDdgJqpkzVuzZrKIPRO7dUtAakoYOxlFt2gjZdNVquxsDYvjDcqxMyy9xMv4LBAbAb19cJm5AzY38erwx3r1A3KKDJI7ncDrozbHu+h3eFIX42NqbPqiLiPkWuleK6e59I+wIBzHM1gWm+648T6axaRQRPNTaNPlUWfWEV44Sg3RaRH2PjnQrkpmu/puCDD2KqsmgTL8XccBJ+RV18uO7bsJN/Yv7nby4SR+IGxlbfd7pM40+cIDUonFXu+fE1BDrcpSzVugjJ9omGKPzyah1+3v16pMj3HjG0pYxuOKA/pdEr38COqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QqSNzZ8FbQdmC5MJEYbVyGE8VPV4zU+zZehcZX7oaU=;
 b=0MFWhL3/YrD+geB+KLWiIhi/ri+33ezrEkZYkc2A9xu1hKKVyWYnHKDh8RnrDFdh10Q2yM+EJXCdOlaX73zi2MhT9qUSYnn2RAKw+nCmjtG4HzpgHe5jJiVtZzQNzHXFQoGGgRLMJlwXyyL1v+xpLqDprxl76kdk9hM89GP8+rI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2400.namprd12.prod.outlook.com (2603:10b6:802:2f::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Mon, 26 Apr
 2021 20:24:25 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 20:24:25 +0000
To: Daniel Vetter <daniel@ffwll.ch>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Crash on device remove in drm_mode_config_cleanup
Message-ID: <2231aab0-c5d4-b2b0-f83a-5a0e25283961@amd.com>
Date: Mon, 26 Apr 2021 16:24:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:a338:de5a:b566:6a49]
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:a338:de5a:b566:6a49]
 (2607:fea8:3edf:49b0:a338:de5a:b566:6a49) by
 MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Mon, 26 Apr 2021 20:24:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a56e09f3-9e8b-43eb-376b-08d908f1489a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2400CE96A80C2246C6CD0566EA429@SN1PR12MB2400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2N6ZjW4nBLtp0ytpnvl3ucjiszjZ1kaOmib6cmvygEzPaVVpErwIS9pyBldq3bMvg6IBKk6PghO83aedNfEf2/vsiGOIkBGQC0jXp1cpQG5fTrnM6ufnJzJd2U3rVLXzU5jqwki8ZO84Ig+OkbKpW/xaPm6UAmx8HIFWRz0M3PQSYu9gRCra7jhs+TvnOInglJg+V5ZKSGogn/n7XV7OgMa1m+MJGQXvdqDJic00fRPgO0kBREvwCI+1IlWd+iLb6vjptXTvyVeqRz5VW0ON1RIaN0zJcn7m1IT+ROy5CXaSTibKTTHKsag2mNgPeqYNVWyIBp1RjWmYJ+9fO4DCMBZgrARce7e9634goAs3vWfNCb5zox/lUAD3V8NzAL//fSCfmygYXUepyB72e+75yc5drd+A+fmtctMcvxUvQvF/JkJUMrH40YLR0zTDFWG6ETmxwy91PyGZd26GG/fWsR32qT36OosVO0Mox3glz63lTBQNUTzic91qFKnBscMHvgvC6x40aGWFPmBv49KJNp08MR+r4id4KGXo0NU7xPigcJW3rGQ3tT1y3unMQbhfeM+vvTlwLwlVRFJS0rICmDZWj0RMj0JpsxxOQMvRDNi3CYP2PVcGDEAf1X1cNO7wPBtOCTWrYRR12L+xiApIP7KN4ee4krFKUEXI3NwJJkLhnUCSZgPvDNob84+joGwH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39850400004)(31686004)(110136005)(31696002)(36756003)(8936002)(316002)(2906002)(5660300002)(6636002)(83380400001)(38100700002)(44832011)(2616005)(6486002)(66946007)(186003)(86362001)(16526019)(66556008)(478600001)(66476007)(8676002)(52116002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RHNhSkxjamJFV1V5ekRYQ3lqNWMrYTNWSHBGNWZjS014S1I0UnYwL2xvMHpz?=
 =?utf-8?B?S1ZKbVJ4bFlUeVZrd2ZJSUxoanNZTkpHa1BEUmZsT1BJSDdmK2NNb2VqNFJ0?=
 =?utf-8?B?UG9vMnMwMno1U0wrS1ZhV2ladUtTODVUUCtrakFPS0I2WDY1cGNValRoT2F6?=
 =?utf-8?B?ZWJnMERZWmlaQlZHc2JDOVlaY1IrR0ZEY1pWNVMreFlUWlBjM2Joa1dtWThr?=
 =?utf-8?B?QSt0L216bStXT2VkSklxVElNRnh0bXk5MGx0M0FtU1dTai9FT0tQYUM2T0My?=
 =?utf-8?B?VWFuY1lZc2ROa1puL0p4aXBPNTQ1VlFlVnhlZGVXbVlIeVJSYkN6dXI0NUcw?=
 =?utf-8?B?NUxGcVBKdHVXa1VoVEMzdDNKU2Z6YlNpMmxXYUhzTjBsVkVnK2JvTEFtTXVU?=
 =?utf-8?B?eENmWWdFYTR0a3hLVjNpb3lQMGRGTy8vSkZKaFFQNk5KS1BnZ2Jmd3kvMFdP?=
 =?utf-8?B?MDhiOWRjeFRRei9rRlRmQ1pHTGU1STlMRXZzMUxEeUVQMUt2dEdab3ZEYWQ4?=
 =?utf-8?B?UTZvZWV2VUJUTkE2SUJYbER4azBXZVNMVmJJcXVhTUZRdUZZQXlHTCsrVWNM?=
 =?utf-8?B?VmRLQXhpeE5sRXpvRWJrWnl2ZVFKNkdTUDBlWFdPNEdwZjlrRHo5TzJaRk5O?=
 =?utf-8?B?c0NXSXAxMmIrQXJTUXJ3LzNBck5xUUhtL1JXWjB3NG03OVpjaUdySUVJbURP?=
 =?utf-8?B?dXc4Q1duN2tKOUdLYmE0S3I3VUZYZTZlU2s0c2diUUZnZGRtYittY3dNQUQ2?=
 =?utf-8?B?SHlnekNQcWpoSlUwNkRPV2U0aERzTTR3dSt5ZjdsYVYrRUNIcTAwSjBudjFo?=
 =?utf-8?B?OW5HQzBTWUxic3NVNWt6OHlsL0FMTVVHNjZaSFNyb05ocnByYytXaTRIZXgw?=
 =?utf-8?B?cmJSek1zQXE4dVNzYjl5djZleTZaNklCSEhwaW5Ic1lRTkhnZ3g0Sno0bjZZ?=
 =?utf-8?B?VW5UYTM1QWtXUS93T2M4alpHWk5EUWJzbUoyNDBEZ3dMZUN2Q0MxZGgzQ0lH?=
 =?utf-8?B?cndBdFZNWFJ4bCswRncwQUhjM0dDMzhWVjBhbzhSK1o0c2hZcnh1ZnFsYWZq?=
 =?utf-8?B?aEFVZjA2V281cXdnT09yTXhvMi91TEcrU1lIWTJ2bEQyQVE1TDhCUXdpVlB0?=
 =?utf-8?B?SCtsRTFXc082ang0OEs2QWYxL2dLNStONVdOdzAxaDBKTUEyeFFwL1FCYmNH?=
 =?utf-8?B?aTJla3NMeGtqbzBMWDNad3hrTkFKVll4QzE2aFNZM0FacFlsVVMxdmpqbEU0?=
 =?utf-8?B?dThQTlZ4WGhmWmZDVjhYN1dvYjhIL3QwUzk1OXVycmhIM21VL1FTeEpwc3pS?=
 =?utf-8?B?amhVRVRxY0ZKQnZFd3JuKzI2Z2NONGc5REFoWXN2ZUdDWmNhQmlKSDcwSkRr?=
 =?utf-8?B?YldIcTV5TzIwTkVQZG1yQzVCQUUyQk1pdEV1Vm11RXVWZGJoNFM4OVVpT25k?=
 =?utf-8?B?bGZVczl3WmN1Rml2ems3Qi83aytFL2U2Zm4rRk5jdk5nNHY2ajZoTnM2WjFy?=
 =?utf-8?B?L3IzYllETnZMNVhpenFmRFNUOGNIUm1Fdko3S2pLcFZzL0RaVjdZNDJ6UEs0?=
 =?utf-8?B?QVhpaU1HczdDRHdYOGRONFZLSlNpWlBBSmNMRHh2ZFdBNTJkT2ZsVk9UZTRP?=
 =?utf-8?B?aUF0MnBlRmxzZ09jOTM2WVh0NURWQ2tORVBHdFF1YlBtM2VKUWgxVWhxeHJQ?=
 =?utf-8?B?elZCZ0Y4Vy84U2x5OGluR1I5VWFHcUxwZGxTS1ZYWS82WStvdzhnVGwza2l3?=
 =?utf-8?B?VDlaNTViQW1jamtRS25PWWhpU1hHQU9QUThndzRMWXlSZ3RFVHBFcTVWN29s?=
 =?utf-8?B?NXFWM0VhWWx0UitmUDd5RzhycTZRQzBDMmpmRlNwalZqS3FETU9ZNlkvTHJy?=
 =?utf-8?Q?TldRqCgpHmdc5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56e09f3-9e8b-43eb-376b-08d908f1489a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 20:24:24.9751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UeSd43LO7t1/uXYDhm+Uxz5VnNw0D4o/saU7rrvTkSv9sKlTxdJhI+EWQlqvOJjx9GQYVWA311BCn8AgyHpcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Daniel, Harry and Nick - in latest drm-misc-next (5.12.rc3) I am testing 
for device unplug patches a user testing with eGPU box reported a crash 
on unplug. I debugged myself a bit and I see that 
drm_mode_config_cleanup is called twice - once explicitly from display 
shutdown code and once as a callback from drm_managed_release. 
Obliviously there is a problem here.  What's the best way to fix this ?

root@andrey-test:~# echo 1 > 
/sys/bus/pci/drivers/amdgpu/0000\:05\:00.0/remove
[   37.068698 <    3.923109>] amdgpu 0000:05:00.0: amdgpu: amdgpu: 
finishing device.
[   37.081385 <    0.012687>] CPU: 1 PID: 2397 Comm: bash Tainted: G 
B   W  OE     5.12.0-rc3-drm-misc-next+ #3
[   37.081397 <    0.000012>] Hardware name: ASUS System Product 
Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1004 08/13/2020
[   37.081402 <    0.000005>] Call Trace:
[   37.081407 <    0.000005>]  dump_stack+0xa5/0xe6
[   37.081419 <    0.000012>]  drm_mode_config_cleanup.cold+0x5/0x4f [drm]
[   37.081555 <    0.000136>]  ? drm_mode_config_reset+0x220/0x220 [drm]
[   37.081689 <    0.000134>]  ? kfree+0xf3/0x3c0
[   37.081699 <    0.000010>]  amdgpu_dm_fini+0x73/0x230 [amdgpu]
[   37.082541 <    0.000842>]  dm_hw_fini+0x1e/0x30 [amdgpu]
[   37.083404 <    0.000863>]  amdgpu_device_fini_hw+0x38f/0x660 [amdgpu]
[   37.084030 <    0.000626>]  amdgpu_pci_remove+0x40/0x60 [amdgpu]
[   37.084524 <    0.000494>]  pci_device_remove+0x82/0x120
[   37.084531 <    0.000007>]  device_release_driver_internal+0x17b/0x2a0
[   37.084537 <    0.000006>]  ? sysfs_file_ops+0xa0/0xa0
[   37.084541 <    0.000004>]  pci_stop_bus_device+0xd5/0x100
[   37.084547 <    0.000006>] 
pci_stop_and_remove_bus_device_locked+0x16/0x30
[   37.084552 <    0.000005>]  remove_store+0xe7/0x100
[   37.084557 <    0.000005>]  ? subordinate_bus_number_show+0xc0/0xc0
[   37.084563 <    0.000006>]  ? __check_object_size+0x16b/0x480
[   37.084572 <    0.000009>]  ? sysfs_file_ops+0x76/0xa0
[   37.084577 <    0.000005>]  ? sysfs_kf_write+0x83/0xe0
[   37.084582 <    0.000005>]  kernfs_fop_write_iter+0x1ef/0x290
[   37.084587 <    0.000005>]  new_sync_write+0x253/0x370
[   37.084591 <    0.000004>]  ? new_sync_read+0x360/0x360
[   37.084596 <    0.000005>]  ? lockdep_hardirqs_on_prepare+0x210/0x210
[   37.084603 <    0.000007>]  ? __cond_resched+0x15/0x30
[   37.084608 <    0.000005>]  ? __inode_security_revalidate+0xa2/0xb0
[   37.084614 <    0.000006>]  ? __might_sleep+0x45/0xf0
[   37.084620 <    0.000006>]  vfs_write+0x3d7/0x4e0
[   37.084624 <    0.000004>]  ? ksys_write+0xe6/0x1a0
[   37.084629 <    0.000005>]  ksys_write+0xe6/0x1a0
[   37.084633 <    0.000004>]  ? __ia32_sys_read+0x60/0x60
[   37.084638 <    0.000005>]  ? lockdep_hardirqs_on_prepare+0xe/0x210
[   37.084643 <    0.000005>]  ? syscall_enter_from_user_mode+0x27/0x70
[   37.084648 <    0.000005>]  do_syscall_64+0x33/0x80
[   37.084653 <    0.000005>]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   37.084658 <    0.000005>] RIP: 0033:0x7f576c3e01e7
[   37.084663 <    0.000005>] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 
0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 
01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 
18 48 89 74 24
[   37.084667 <    0.000004>] RSP: 002b:00007ffcf7b05948 EFLAGS: 
00000246 ORIG_RAX: 0000000000000001
[   37.084672 <    0.000005>] RAX: ffffffffffffffda RBX: 
0000000000000002 RCX: 00007f576c3e01e7
[   37.084675 <    0.000003>] RDX: 0000000000000002 RSI: 
00005568ffe63d80 RDI: 0000000000000001
[   37.084678 <    0.000003>] RBP: 00005568ffe63d80 R08: 
000000000000000a R09: 0000000000000001
[   37.084681 <    0.000003>] R10: 00005568ff9f3017 R11: 
0000000000000246 R12: 0000000000000002
[   37.084684 <    0.000003>] R13: 00007f576c4bb6a0 R14: 
00007f576c4bc4a0 R15: 00007f576c4bb8a0
[   37.400338 <    0.315654>] amdgpu 0000:05:00.0: 
[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_2.1.0 test 
failed (-110)
[   37.401171 <    0.000833>] [drm] free PSP TMR buffer
[   37.443240 <    0.042069>] [drm] amdgpu: ttm finalized
[   37.443246 <    0.000006>] x86/PAT: bash:2397 freeing invalid memtype 
[mem 0xd0000000-0xdfffffff]
[   37.443945 <    0.000699>] CPU: 3 PID: 2397 Comm: bash Tainted: G 
B   W  OE     5.12.0-rc3-drm-misc-next+ #3
[   37.443952 <    0.000007>] Hardware name: ASUS System Product 
Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1004 08/13/2020
[   37.443956 <    0.000004>] Call Trace:
[   37.443959 <    0.000003>]  dump_stack+0xa5/0xe6
[   37.443967 <    0.000008>]  drm_mode_config_cleanup.cold+0x5/0x4f [drm]
[   37.444048 <    0.000081>]  ? drm_mode_config_reset+0x220/0x220 [drm]
[   37.444129 <    0.000081>]  ? drm_mode_config_cleanup+0x430/0x430 [drm]
[   37.444208 <    0.000079>]  drm_managed_release+0xf2/0x1c0 [drm]
[   37.444287 <    0.000079>]  drm_dev_release+0x4d/0x80 [drm]
[   37.444363 <    0.000076>]  release_nodes+0x373/0x3e0
[   37.444371 <    0.000008>]  ? devres_close_group+0x150/0x150
[   37.444376 <    0.000005>]  ? _raw_spin_lock_irqsave+0x6c/0xb0
[   37.444382 <    0.000006>]  ? devres_release_all+0x3f/0x90
[   37.444388 <    0.000006>]  device_release_driver_internal+0x18b/0x2a0
[   37.444393 <    0.000005>]  ? sysfs_file_ops+0xa0/0xa0
[   37.444398 <    0.000005>]  pci_stop_bus_device+0xd5/0x100
[   37.444404 <    0.000006>] 
pci_stop_and_remove_bus_device_locked+0x16/0x30
[   37.444409 <    0.000005>]  remove_store+0xe7/0x100
[   37.444414 <    0.000005>]  ? subordinate_bus_number_show+0xc0/0xc0
[   37.444419 <    0.000005>]  ? __check_object_size+0x16b/0x480
[   37.444424 <    0.000005>]  ? sysfs_file_ops+0x76/0xa0
[   37.444428 <    0.000004>]  ? sysfs_kf_write+0x83/0xe0
[   37.444432 <    0.000004>]  kernfs_fop_write_iter+0x1ef/0x290
[   37.444437 <    0.000005>]  new_sync_write+0x253/0x370
[   37.444442 <    0.000005>]  ? new_sync_read+0x360/0x360
[   37.444447 <    0.000005>]  ? lockdep_hardirqs_on_prepare+0x210/0x210
[   37.444453 <    0.000006>]  ? __cond_resched+0x15/0x30
[   37.444457 <    0.000004>]  ? __inode_security_revalidate+0xa2/0xb0
[   37.444463 <    0.000006>]  ? __might_sleep+0x45/0xf0
[   37.444469 <    0.000006>]  vfs_write+0x3d7/0x4e0
[   37.444474 <    0.000005>]  ? ksys_write+0xe6/0x1a0
[   37.444478 <    0.000004>]  ksys_write+0xe6/0x1a0
[   37.444482 <    0.000004>]  ? __ia32_sys_read+0x60/0x60
[   37.444487 <    0.000005>]  ? lockdep_hardirqs_on_prepare+0xe/0x210
[   37.444492 <    0.000005>]  ? syscall_enter_from_user_mode+0x27/0x70
[   37.444496 <    0.000004>]  do_syscall_64+0x33/0x80
[   37.444502 <    0.000006>]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   37.444507 <    0.000005>] RIP: 0033:0x7f576c3e01e7
[   37.444511 <    0.000004>] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 
0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 
01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 
18 48 89 74 24
[   37.444515 <    0.000004>] RSP: 002b:00007ffcf7b05948 EFLAGS: 
00000246 ORIG_RAX: 0000000000000001
[   37.444520 <    0.000005>] RAX: ffffffffffffffda RBX: 
0000000000000002 RCX: 00007f576c3e01e7
[   37.444524 <    0.000004>] RDX: 0000000000000002 RSI: 
00005568ffe63d80 RDI: 0000000000000001
[   37.444527 <    0.000003>] RBP: 00005568ffe63d80 R08: 
000000000000000a R09: 0000000000000001
[   37.444529 <    0.000002>] R10: 00005568ff9f3017 R11: 
0000000000000246 R12: 0000000000000002
[   37.444532 <    0.000003>] R13: 00007f576c4bb6a0 R14: 
00007f576c4bc4a0 R15: 00007f576c4bb8a0
[   37.572043 <    0.127511>] AMD-Vi: Completion-Wait loop timed out
[   37.572152 <    0.000109>] pci 0000:05:00.0: Removing from iommu group 13
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
