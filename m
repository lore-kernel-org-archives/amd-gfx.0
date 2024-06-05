Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8295AC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 11:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8183610E76D;
	Wed,  5 Jun 2024 11:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JfLax5Gm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A7D910E771
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 11:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtmfRwhmu3LzZHBaurufHCHKArelSAkHvTSNil7ChYb3cPZfzNdy5VLdT5F/SbzMOyMYn1mSc5C16AYtBdCKRgsOjAiug6SrPhHVOF/XHdPrYgfmB5Z+xuaN7u1OWNOeZ3pjMF+T6ozcG9O8AGTlR+n9u1zgBENIGNox1euQVm5b25774lDPodE9n3ispyIYBG0PHJ8VXbWyEMIUhDg7ceHqr/4pLJVKO2AzQ1gIlIidfIVg2PLha3EBDUWiwwGIeT6vgRlVtnL+zFmnaZaS+gTBaWUtioGNTC0bkvtsbtWri+af1mxqxnt0/5oxP8Ak3j6nsXYgjpi2Wa2Yn3WRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8GPkPZ9GxOVmyZRBECUSdF7/8it7hVsDPa3XOxFXWs=;
 b=ajmzw1m7lKkNtCWOk6bKUEw5hqfXd5zD3N7K1RdjTZxbMIk7nW4wi6oglLNkxxy9nxchDOE9n5TF0ybK+nVHpVdcK/EaRL/RArgBJvXUgWfPquMg43wD8UEozSdij5DPGkcB2gNObp2pN5mUaO/dYpbBcd1xyl/Y5gWVq2L7pK1mo4etCWWl0tqTIA0JPBMTPOBgPfJgtZP0uYsxGl5Xsr66Gxy8m7ogbm+2BOTOc0AZPWQRsHS3De4NsNT7hgbmliOyAwEFao9j1nn7MbUNE6AFy1kRXSe3i7F5kbvsgdddwmhmxKcXruwdagnPKh8g70FjJonjrcZQ17Z0EiU2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8GPkPZ9GxOVmyZRBECUSdF7/8it7hVsDPa3XOxFXWs=;
 b=JfLax5Gmxad42hPtMfe94bhE1Za/ZAczTq1FfbelMngNhehdJ6+ZXS8gflJvPftG5+z+zJc28hX6BYhwWuyNJRGM8HiSMIFVBsawEQVoRzMPAKcFE7H2CBZkfYAsiXmEGkh4yNvxXuCZMdPsZ2ro52PEqEw3MTgQXbkWDjscgHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 11:18:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:18:52 +0000
Message-ID: <9ff42462-55eb-4e71-996a-498533d85a8a@amd.com>
Date: Wed, 5 Jun 2024 13:18:46 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>,
 "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Page fault storms and IH ring overflow
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 752f29d9-056c-4400-88ba-08dc855147af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGw5MnFnbTVaNHg3QTl5R2l5clFxZEdCSDZyMU5oUm1icE5rcmxmWVd6aWFs?=
 =?utf-8?B?UHhpdm9NTFB0STZvMm5HRjI2N2JXMXF0ampBOW92NURLcWQwQTVQZDYwQkZS?=
 =?utf-8?B?eEdMWXB2NDN1UmVjMnJUNmlTWWhieFlMYjVjNi9oSElPS2FRTUF5RXg3ekZS?=
 =?utf-8?B?aEM5bTdIdjgxK3RMS0hBcEQvekU1Tmw1M1p0azZ5THdzcnJaVmc5WGRoT2Z6?=
 =?utf-8?B?R0ZuaG5IQlNQTnJXbkUwMXBrM3MzaU9EVjVuYTVBL2xQdTZ0K3pIRkpXd0hO?=
 =?utf-8?B?dVVPREd2L2dCSGEwUGl6WjdnVHdzSFZ5S3NxUzVQZVhWZXdoczlXa3Y5dS8v?=
 =?utf-8?B?ZmNvRjFrM1FvTE11UUZvRGVPeEVtVE5ZQW5MYjJhcVh0K045Zmhmd05UZGF2?=
 =?utf-8?B?bnJpUTkwTUc5Ry91KzhpK3JucEpKdEJMY2dMZW5SVFVxeDBkeEtNeUdxQ1N4?=
 =?utf-8?B?TkRBZW9tZFFpL3phRmF1S1VJcmVHYkpLUEZpVldsMytMNlVTU1NSVnZEWlM5?=
 =?utf-8?B?dit3dE96c3pkeHNhNVFFdVpFTFNoV3RmU2wrOTFyQkFpbFIraVE0bDAxblRY?=
 =?utf-8?B?TmM0ZkVYaSt2bVpEUmRpcUs2bFZyTXVoay95UFljNFEwcmdyd3FsS2RoSXJn?=
 =?utf-8?B?c0kyYXNtV0g4cERvcDJFUTJiMGtxVDNEbHVKSmVPc2doaDEyL3R0bGR1a0VO?=
 =?utf-8?B?THdncUVON3FheHRtNWVzZFRza0tCMDdReXJMcllrSjVpYXlhV3B3TVpZODNh?=
 =?utf-8?B?Z3RMbmo2WFptNXZvQnNnemRUYVVKTGorN2RBZTNzekNDdmJiVnBKMUxmYUlZ?=
 =?utf-8?B?WFQ3bHpnNzkrc1NTOEFrS0FQcm01TlNZSTVvdkY2R09qOEJRYTRFTC9nNUpQ?=
 =?utf-8?B?bmRUYStlaWlwaDMydnBDZmhRNWxaaGxhb21vUjZqU2pwMWwwZGl6OHBib3Bt?=
 =?utf-8?B?NDBKeE8xYTRtL05QcU9EcU9GREZwMUdJM08zVm5ncUM0UG1hV3AwdXhRV2xv?=
 =?utf-8?B?TWNON2dBQzQ4alJuaUwzZjArTGY4Q3k3Y00zdm9nUTY3SzRib3BhbXIrUkVi?=
 =?utf-8?B?ZW4vb3RQTVp5dm5UeVFra0dqSHdFY3hSdjVLSEZLWDZleU5ZRE53SUU1VG5E?=
 =?utf-8?B?WkFqWFIwV29tcEF0cFA3dUdaa3ZFYVBWWlhhUWVtTEVrdXd4RkdyNm04MWdD?=
 =?utf-8?B?UlZJVTByTk9wZkN6cEZwUzVHdUNtVTN4MVRMZXRsY0haaG9ZK2NDUlBMWDlM?=
 =?utf-8?B?cHVHemZ6UmNZWmRuWXZ3SWRPRVh4dVVSZkZIdXpVVVV5MmFXQzZVcDl3ZGlv?=
 =?utf-8?B?VFhFYTU5M3ZYdXordVNLc2E0S01wK3ZZZ0RQZ2RBR1UyV0pNM3JEbnZlMUhh?=
 =?utf-8?B?ZWJMekhwQ3dkMXlXaGVML08wLy95STlnRStrUzUvaDl0ZmRKWWJZZkZmeW5q?=
 =?utf-8?B?YTlrcG5Da2ZuSGpndWZLTXpIYjhiVHErcmd1QjdDNUV0cDdwM1pnMVdoTFhp?=
 =?utf-8?B?M04waEF1YWlJVHJXNW5qSkdIbG1VU1V5UDdqWVFMcFI0UXR2R0taYmRoTTlM?=
 =?utf-8?B?Y1FyWE9pMjllT2RYaXVnbHRscDJFK3lndk9xSndoeE0zbmdaK2xEeGU2S2Vw?=
 =?utf-8?Q?m4XTA/bsmgxZR/r98ycSH+Xs1UlfybulI479iUyUWAus=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy83OVBROTVmSWdNUmdncTh0U1o3clkvaXRPVEZGRk1meTY2ckxVMzBIQXlr?=
 =?utf-8?B?N3pHWEpFUU1mVTk0bm9FUmF3TjZqdHVldndJazl6bHRucys4Wm11Mk1qVHRt?=
 =?utf-8?B?TWZjUDFocnl1dkk4RjgyU0UrRzNGVk9aZ3doeEtwTVhGZzB0TnBQWE9URmZL?=
 =?utf-8?B?M3lGZ1NNSmJHbHo1VTlieTFBV0pTcEtWQy9TRzhHL0g1c0tOWkkvM0RHN3da?=
 =?utf-8?B?SW5UQ0VJOUt2TTBhUDNmNUw1aURQeU9XVTlhR0hsTU5jbG9DMUFBZ3JNK2Qv?=
 =?utf-8?B?MTJzSmdyQXlucjFTZjNWSFNHM1VabW1xNDRRejRRektnTEtjdS9QcmY3a3pG?=
 =?utf-8?B?eEZjRE9lZG1iZGtDSlVCZlRUdmdON3I1dHM2ajNad0xwTFBaR08vNG9UdVJ4?=
 =?utf-8?B?Q3pyUmFna2VyaTRRWitWMXVZVmhxMk81cStKYURLazdsSEUyUUp6UCtKMU5T?=
 =?utf-8?B?L0t1ZWJqSkhkd05NeXMxdXd3S2pMdTlia3Y5Q3dFei8yNXBsc3FqVjZlbTh4?=
 =?utf-8?B?dE80RStRVFphVHlBTmp3Yi85Qyt4ZTJFcmdmaEtaYms0S0NJdWtuclNCZE5X?=
 =?utf-8?B?VEFBTjRGMTJ5Y25zc3V0Ry9yMFNJNmNEQzZHMGErZ0RvcFBGa2VKelJFdFRO?=
 =?utf-8?B?cyt6WDZpc2wrQ29wekRaVTdiM3dPZnNhMlVIbzE2dUgxeUU0T3EvTTlDZFR3?=
 =?utf-8?B?REM0YXRobGJaWk5HeFc3bHp1YU9tWGdTSTNLVTJEdGVTMjcrRWJvRCtqVVBm?=
 =?utf-8?B?SnczczNOVTRvdW11THRrZ1FzOHFrS1ZlUzR6Q2V2MWdDemxsWWJBK0ZGNzM0?=
 =?utf-8?B?L3JoaWpZcmtHTjl3eFFGUkhKTWE5NVAwVmVPWVd6MlBnQ3dzTitlSUhxYTMy?=
 =?utf-8?B?M1l4Vjh6dU4rSzFQMjBjVEdGZ1dCV05GL2E0V0o5elg2Q21OTHBCWGx6eXNp?=
 =?utf-8?B?Z0htZytFWnhOdUxwU2R6U3UzQXRlRkxWV3ZhRnNvUUxJU1Q4ckZ1ZmN6SzZN?=
 =?utf-8?B?TE1iYjJtbjZCUzNzVFpCbEI3VlZBR244RlZMVWFISHVlc3V3cFZKYnRMOVZa?=
 =?utf-8?B?cDltZlpIbjdGNXVjT3ppb3c0MzlQYTRNUkhJdWVHR0Nwb0F0V1NsT0dBNGxL?=
 =?utf-8?B?Um9OZmR2Vk00Z001eXB4aWE4MVdVOU1TTlg5dE1GS2xKc1J4R3J2b3IxcHc3?=
 =?utf-8?B?b1dtMkR2Q1oyeHFCa1o5L0phWjdqeGNtWnlvSFNpYXAyaTZSb0NaWFdhazRB?=
 =?utf-8?B?b1BOKzh4Ry8vMjZlV29Yc1JnVUcwNFdjYjVpUHgybWQ3VDdaMEtqWDM0Q0hP?=
 =?utf-8?B?Ym9TSHhsWXZuVjh0TWk2eGNUYUNFak1qZmxRZFAvaVVCeTZML2hIZzQvSEFs?=
 =?utf-8?B?V3MxUjh3L3R1ZXUzRlZ2WDJLYVFFN3pIZjNuQmQxSXZVN1FJTXhGSFFTdm9C?=
 =?utf-8?B?bWx1RGN5bE9yWDJVTXhQM21vcDNqRmh1bVVZNUZmd1IvS2kyb2hkWXNOTENy?=
 =?utf-8?B?eUd2QW5ucFU3UmNFVC9uM2FUMlpuSjJCQisvS3JMaVF2emowTWdDWWsyRlpB?=
 =?utf-8?B?MXlPZ0xKb082K2I2VkNnYzNwOFh6TUNoM1NlWThId2JGS3daQU9hNko0eGpW?=
 =?utf-8?B?ZGd1TUhpOFR0SnpKVXZiWUErVGNMbWc3NDVnMjNkcXJORFNtK28xNkpLWmpl?=
 =?utf-8?B?aVNlQS9FOFhPYWVkOHViTFZ3eWxkOGdaOE80cjJ2aUZyeE1RcWRXYTU2UDMr?=
 =?utf-8?B?WklMZ0JNd3p3THlYOUY2S3I0VlFtbjNCYnFYck56SVExMWtSN1R3cWluQTc2?=
 =?utf-8?B?UW9HVWhCaHZrYmdSOUVRTlVLcWNreU4wN3hlb2FXeS8xL0lhUnA0cS9LYzNU?=
 =?utf-8?B?UmZFdldBU1R0MlZlTEZZYmliZVlRWjdVNkJzUGtZQWk2YXZZMXI4VDBKYkxX?=
 =?utf-8?B?NStWQmxKd09rK0NTN1FMWlc1eWJYenR6TmdtemRDUVdBamZZcml6YXhUbzNP?=
 =?utf-8?B?ZE85dnJaaEZ0WFJ0ZjZIKzdXWXR2K2pRWTdsRis2ZHA5K1J4eEZ6NVY2aHF6?=
 =?utf-8?B?azVUNmxiTzVodFZxZlFFZmF6MGFLOFU4NmNlMEV3UU92K2NzYXFURit4UTFF?=
 =?utf-8?Q?+ZetrIhuXId251DX4pFA/TJB+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752f29d9-056c-4400-88ba-08dc855147af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 11:18:52.4096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InkHgCBj97dJgA/woz7bzB9TXz0LETQuCz93jvW6mO5NKL6wYPBqcBc7W73t0rV8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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

Hi guys,

just FYI: Alex published yesterday a bunch of new firmware files: 
https://gitlab.freedesktop.org/drm/firmware/-/commits/amd-staging

One major issue which should be fixed by those is that page faults can 
no longer overflow the IH ring buffer on APUs and older dGPUs.

Newer dGPU with IH 6.x  (Navi 3x) should redirect them to the secondary 
IH ring where they can overflow as much as they want and don't cause any 
more trouble.

Kudos to Sunil for looking into all of this and pushing our firmware 
team to implement the necessary fixes.

Regards,
Christian.

