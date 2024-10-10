Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427F5D24450
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 20:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF4110E9CE;
	Thu, 10 Oct 2024 20:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBC3/Kji";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2811E10E9CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 20:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryAzF8QudPdn2RxvL2uiUIavW7iL1kwxfVyjQi8FGDxgwXBn4I1SjWTkhK/AGBwDmnwtbb9ywd6SjEiP38AVAwgP3sDjOQBKvA8LxtC9G6jYkJ0xveSK0vxiWNTffv9yEM3GzmVe5N0fFN3XJT5NMc6S+rkvDX6p4iDDHc/rDVBNc06moIk60JnOx7I5BT9dgAmkGv1ZgCycWdUspJMv7Q4zrtM52n+PPeM3aANY+FTo+RxAaUeyFJGdHPuE9dS7q1BYaQMjr8VC0HhsQxLSIYZWG72qfEh1yfUoxVu+1MZtI6Bhg1yJDILBvnPKWolc1wPndI1uUSTs/8QeGW0M/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtQXuI8mpOipmjJPrkLgDSSCDVpppnzW/GcUzxq35EQ=;
 b=c+P3cRg3SlWV3Jcu8PTb6ms79Jx9qWa/WdhKzQGPX+FVD97MdMQ3IB0xsumMfqQgkZ5+HfbkdKNQtAKLu9iQ+c5x02HA6XBWjo7Zkxj4C4Z5xF8Ml6GnFtA4cs7la/xrL3NMEOCy2QsGFgVAkQM5EHpjuljpWSlAerj++ppZ1KFn2qMz23MJinCuahckVGvuXuWjld7Q1Xubo4BOTKoj/dUwerly/dKvFURNRHgVNm5L6m8AIKhbmp6ZBj6WdA8aS/TqtZduC+wetYna6tw7+EKd7bhmI+fY/wlrpC4EqaepccS1r/HEo9dlMjS7QkxWAbNKOZe1SeIfD2C3zx78wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtQXuI8mpOipmjJPrkLgDSSCDVpppnzW/GcUzxq35EQ=;
 b=XBC3/KjiPqLFzFMT05RcrH/mLCRNWy85AS+i6GlNJ4WV0LBx+G60B/MuG9hc81JnB63o939NGOb2jiai8pfjYBkdU+8W8dxZddGOWftB0zVFy9kp9mPmzlOA1Dp+VIUfWjxfHlPdouurJpvK/Y1SfW1fardOxrm5XF6MVe0wM3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 20:37:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 20:37:11 +0000
Message-ID: <9445ae2f-9bd2-4bbf-9fbd-789a75a4e9e5@amd.com>
Date: Thu, 10 Oct 2024 16:37:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: change kfd process kref count at creation
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241009180855.14859-1-xiaogang.chen@amd.com>
 <56b95963-f617-4578-a660-37eb471edd68@amd.com>
 <98dfd8f4-3c24-466c-8ede-d3fcb341912b@amd.com>
 <3005a471-e835-4d0e-a0e1-e40c5d761cbd@amd.com>
 <92839ce8-4fe0-4099-8592-f461bd9d119b@amd.com>
 <0e685c63-ca07-4147-9051-bac211f52661@amd.com>
 <381a4701-1b3d-4bf9-a361-329fd090ba44@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <381a4701-1b3d-4bf9-a361-329fd090ba44@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8461b7e1-ffb9-4065-f72e-08dce96b5129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1qQUpQK1VLTUJZN2dmY05tbUFLN0xIajdybWJyZXVHU3NzV1kxNk9yd08z?=
 =?utf-8?B?WklhV3lFNHhsSDNvbVRzUmxWU3p0TFpiL0F1MEtNdm5BWkMxMERNQUZqOHNp?=
 =?utf-8?B?ekFIWEZwME9iQVkvRTFRQnJRZTdBZVVxbkRuV1dDNzlpaU5tSUNNL0ZBcnZ2?=
 =?utf-8?B?emN2SEpUMks4bFFsazF3MHBkTGx5L3RzMUJOQkZMOENlRmFESzA5K2lPam0r?=
 =?utf-8?B?aHB0S3kyd1I2V1BYNnYvem96NHhvZVRwUkJmd3JjdWlBY1JJdXZQNm1TYkZZ?=
 =?utf-8?B?UjRyODhwZ2N3S1QwbDVCSGZaS3AyQmthUGhYdVVJNEU3bkx3U3ZBWllEZHVM?=
 =?utf-8?B?YUJqVjJma2JjeHhlUEtaTEhvWWkreXRBZEQ0VGp3QmNyK0NhZi9kZEV5Y1E2?=
 =?utf-8?B?ZDBrNGdiRzJWNVNWZVNLNTlabE1CK2JqdW1ESyt6MUpWd3gwcWcvNVlmYjQw?=
 =?utf-8?B?cGdhL1BiNXZubnZNZ3pUc3dBZ3QrczVHVm1MQnRGRDRjc3JUVm5ibjFWWmJF?=
 =?utf-8?B?RTNBMVVrZXFDM1NHQ29FVEg5aDRHMXdhL3BaRWxTakQ4eUlMTkRacXhWUEw5?=
 =?utf-8?B?d0hoeXJkbEdUSUxkWGV6SitPZVh4VGNOUDlVSTBQVXExZkdvdUdKMGRvWWNz?=
 =?utf-8?B?WCtreVpDMDVWV09maTBnNlI2WVFwTG1uYmliWU9oWjdaVmQvcit1cmo0dEVt?=
 =?utf-8?B?V09aSnRQdWtnT0dCcU9ESkp1aDFMOTJXSXlja3dNR3NIVk5OMExHYnZoU0M4?=
 =?utf-8?B?bjlpd1BjUHBiSk1vWTBwWVZjdVpQaHE1eURKMDE5eWpTSm92bmdkcXlOMitS?=
 =?utf-8?B?TG9XMHdPSkVyOE9PcmltM1VBWnlkejZaQWNKYlJ5cTZDZSt5d25XczhuOFhL?=
 =?utf-8?B?NmplVHhLYWdYYTVpcmRCSUxGQkFvN1NYS2Q0SkRVcFRLaXh3RWtWOUlJUVpq?=
 =?utf-8?B?MUQ4cHlheGZYRHgrUGdZMVBxSzFwUjVrbEZ5SWkrd0VDRk9SbWxvSWZ3RU1I?=
 =?utf-8?B?UWdNYU0zSnFDMk5MS1BwRmpRbHBqUldTNGlZckZlcEJ5WVZENkJaMWVETmRX?=
 =?utf-8?B?K2JHdFpQL1hlSXNuZHY1QTNBK2NwcWgrSHZNK1RpZHNHSzVXUExmY0U2Zjkr?=
 =?utf-8?B?bVRLallob0ZNVng4emJMWW9EeEg3ZFpSeVVkZVRXT2o5UklVd0J5Q3MvdUc4?=
 =?utf-8?B?L0dyV3V3Z1NJOG81YkJGdEFXa3pzZFlKZkd1dlBXZm5jcjd6L2NzbEdVbEl1?=
 =?utf-8?B?a1JrS3d6NmdJQmZPaHkvc203Mm5ncUhjY296eG1KakVHTGZhbFduVXpwNXVm?=
 =?utf-8?B?TEIwNzFVckVXMlkzRnpJTkFDNXQ2VHNiT2RDNnZ1U24zV1VtU20xVStWRjI0?=
 =?utf-8?B?d3ErTkdJWW5xQ0RYQjRsQXJoNDBkOXRNMWhDTExmRytSQkppNHYzQWZ3V2lK?=
 =?utf-8?B?a2w5NkVYemQ4RUNKRXkxMC90Rjl0VllhWml3ZlV5Ymx5eno2MzIyWHo3MHdz?=
 =?utf-8?B?R0FXK29kMlhwbEJCZm44Ly9ROWtXUmNicFJMMFBlTldUMkJtOEd4THMxY2NO?=
 =?utf-8?B?T2g2TG5ISjVnM0paSGs5cjZJNWRrK29ZeVdQeXMxQUtiM1pVUGhjUXhlTGpn?=
 =?utf-8?B?YTFqT0N2VnkrUnAzSjc4aG04QVBVUmFQY3NWeWJvcThCT2pzbTZqQ1JoUXMv?=
 =?utf-8?B?bmR6NWRwajV2bUpDLzZ3TW9oWGhJRHJXOUlDZ1dIUGRkV0c4TFU0Zit3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRVb1oydk1oQnVBbUcwOU5GTE10aTl3T0RWek1DVURGSThBNTU2czFEYWV2?=
 =?utf-8?B?anNDNFN0QkZLYUR2MjczcTd6Q2RQc3JBcXZnaGJRbWlLNG4xMEFuRDlibkdH?=
 =?utf-8?B?eXpUdFVhWHhBR3loVWg5QXhBRFhsN3JieUZQYXlkVVkwUENnZlloVTYyTkQr?=
 =?utf-8?B?MHRsR1NrYUFGUUh0U0lqYUpNN0lQQTVRU1JnVy9TSHlxdDBLQlhVc1FZQ3h2?=
 =?utf-8?B?WmNxT2dJVERTRlBjeWpnNkoydmxGMURCa2xYTnR1ZUlOaTlBRXk4K1k1ZStB?=
 =?utf-8?B?MjQrRmtGV21Wakl4WXljYm4zemFMTnN1MXQ5aVF2NzkvSTg1Qk5kdFgxYnlK?=
 =?utf-8?B?dmlRK1A1QTArWUVpR2VqUHNKVEh4blF2SU9DbVIvSktGN1pRdU5CWG9SMjNH?=
 =?utf-8?B?R0JuRDNsZ0pQWWY4VWpmamo4VVlsRFZMU2JjbE5uS2FsQlN3TTY3bk41Wkp1?=
 =?utf-8?B?TUpxbEMrL3J0ajlOUW9SUzZsMS82TnRtSWRZU3Yvc2pnQVl0KzVrQkNiMDlh?=
 =?utf-8?B?SStTQmNCVm1JVkt6aXYvU2NXQnE4ZVMyRExQRW5kZ2ZqczNqbktMcy9FN1Fr?=
 =?utf-8?B?ZFpzZkFUOGRpSC8yMWZwbW1KV0JXRzlCVEdrZHNzb1VhVFgvZlFLUEtNdnZa?=
 =?utf-8?B?NEYrWkUyMVRYSlFqem0venNMVzBqa2pZeGI1QTV3YncxRTBncDJYeHdGbVhV?=
 =?utf-8?B?VTVvYXVFdlZNaEZRZk1VVzRWSXo0aHQ5bFRoS0kzZ0FpbmVYdUZqSGtOTG5X?=
 =?utf-8?B?YTVYdnIyL0JRbmQzVm5rOGI5OHlPTVRxQy9oemxqRHp0K3ErQm16bG5XdGcr?=
 =?utf-8?B?ZUJCS3A0NFZMdTFrTEJ5RVJZMXh0Z0txNGttd2ZLbnlXaTZOUHZRY3gyeTNr?=
 =?utf-8?B?NkNLYk1QcHBPNDFqV2ZaL2pTSDV6V0lnVW5Ic1JtdWN3SXdEMFR3R1d1ZjlD?=
 =?utf-8?B?TFR3WmRRMUhmSWhPZTk4UlM2UWN6VkJDTkFjVkZNSzYyT2JqdFJNb3hzSUt6?=
 =?utf-8?B?bFl2RWZTOEpoRTVkOUxaNzNJT1dHdWdaSUtYaG01OUp1NktlUlIrR1pRbGRl?=
 =?utf-8?B?elI5M1J3bEFQSXo4N2pSYXZsc2NiVllBeHJ2Z0xSVnNGbTJaZXNyeGJ6NTZC?=
 =?utf-8?B?MTR6VU5NZ3UwRDVRYUZkQnpDTHBLZ0lMTXdFc0prcU5MUml6K2RCVnhuOVEr?=
 =?utf-8?B?L1lYa1ArbWZQY050WTJsbTh1SERwVWNEeS94MDJzMlNGZmRUd1EzUURJd3BY?=
 =?utf-8?B?V3lGZnhPeUlML045dnVKWWw1Q0crbXQwRS9IVTM1ZWhIQlhnRktjNTBUUDd4?=
 =?utf-8?B?STBmL3BvZ1BiNFdyQUk4WFJEYVZ5R1N2WkduQ3VBREdVc1RrZHNJS1ZYV2xE?=
 =?utf-8?B?RDFxMGxyUk1idjBvSjVnY2QyWGd2bkdDdklBMU5Pa1hKbmRGSFAwMzhlQmI2?=
 =?utf-8?B?S2FWTUtzZGVnM1ZubUVmZVFTdVBrbFZ4SFo0ZVhvc1ZROEhJQjI2M3dLcyt3?=
 =?utf-8?B?RGpidDVsTUN2NlJ6UHphTnB6UVRMc0hOaTNQVlFKM254UWZvcmt2M2k1QzBO?=
 =?utf-8?B?R0VrVmdmTS9JMTlFbVNVYU8rMXFaOFpadWhvRXFLVS9CY2V6bFA0di82YXFT?=
 =?utf-8?B?R2M1UHJNT2xCQ1FkZkZZUzlXYk9UbzJFVm10OFpqZnJ3WWs4djQxNkZ1dURF?=
 =?utf-8?B?ZjBsU2ovNXhhb21SbkNRM2hvYmtqTnc3WmZWQnZoN0ZJSVpvaVl0Y3hlM1hD?=
 =?utf-8?B?SFU0K2RuYzJQeDc0RGRrZDA1dUorV1NpcUw0dGtYUTViby9pbkJPcTR1OFdo?=
 =?utf-8?B?ZVQrK2lXazJFeFlIZ3RSa1ZIcVVtMTNacVlwUVBZYWFvUFhwcmlvdU95Y2Fw?=
 =?utf-8?B?aWpza2JRZ2FIQ2p1UXNsKys0VEFYb1RJc3JBRGc0dmRXN0VtUGVIWWt4ZWR5?=
 =?utf-8?B?TXFsRWFkV3lTMk11d0JuaFBwL2dUN20xQkV0M2g4R1pxR0xnS3ZrNGF0Ynh6?=
 =?utf-8?B?Nk4xRE1uUnNYcEM2alNKMWxCU2VBM1hRRncvY0c3K3ovUGZQY3Vra1ZBelgr?=
 =?utf-8?B?LzdlcjNNZ2NIL2NveHdlSllELzF5U2d0RWJwSmRaanYrS29GK2N2SHpxYVZa?=
 =?utf-8?Q?OLnlz0SMPKGZ3JJQkAvn/GIEu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8461b7e1-ffb9-4065-f72e-08dce96b5129
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:37:11.3453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIyAn3Oe9mbKFQqk2CDQp2QMl1iUgJ2u5gCD8e2NZ7hbr8cUn1gaILVuoTBCV/tyEZYW+mq8FTHxDWkcNtmZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
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

On 2024-10-10 16:19, Chen, Xiaogang wrote:
>
> On 10/10/2024 2:01 PM, Felix Kuehling wrote:
>>
>> On 2024-10-09 18:16, Chen, Xiaogang wrote:
>>>
>>> On 10/9/2024 4:45 PM, Felix Kuehling wrote:
>>>>
>>>> On 2024-10-09 17:02, Chen, Xiaogang wrote:
>>>>>
>>>>> On 10/9/2024 3:38 PM, Felix Kuehling wrote:
>>>>>> On 2024-10-09 14:08, Xiaogang.Chen wrote:
>>>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>>>
>>>>>>> kfd process kref count(process->ref) is initialized to 1 by 
>>>>>>> kref_init. After
>>>>>>> it is created not need to increaes its kref. Instad add kfd 
>>>>>>> process kref at kfd
>>>>>>> process mmu notifier allocation since we decrease the ref at 
>>>>>>> free_notifier of
>>>>>>> mmu_notifier_ops, so pair them.
>>>>>>
>>>>>> That's not correct. kfd_create_process returns a struct 
>>>>>> kfd_process * reference. That gets stored by the caller in 
>>>>>> filep->private_data. That requires incrementing the reference 
>>>>>> count. You can have multiple references to the same struct 
>>>>>> kfd_process if user mode opens /dev/kfd multiple times. The 
>>>>>> reference is released in kfd_release. Your change breaks that use 
>>>>>> case.
>>>>>>
>>>>> ok, if user mode open and close /dev/kfd multiple times(current 
>>>>> Thunk only allows user process open the kfd node once)  the change 
>>>>> will break this use case.
>>>>>> The reference released in kfd_process_free_notifier is only one 
>>>>>> per process and it's the reference created by kref_init.
>>>>>
>>>>> I think we can increase kref if find_process return true(the user 
>>>>> process already created kfd process). If find_process return false 
>>>>> do not increase kref since kref_init has been set to 1.
>>>>>
>>>>> Or change find_process(thread, false) to find_process(thread, 
>>>>> true) that will increase kref if it finds kfd process has been 
>>>>> created.
>>>>>
>>>>> The idea is to pair kref update between alloc_notifier and 
>>>>> free_notifier of mmu_notifier_ops for same process(mm). That would 
>>>>> seem natural.
>>>>
>>>> What's the problem you're trying to solve? Is it just a cosmetic 
>>>> issue? The MMU notifier is registered in create_process (not 
>>>> kfd_create_process). If you add a kref_get in 
>>>> kfd_process_alloc_notifier you need to kfd_unref_process somewhere 
>>>> in create_process. I don't think it's worth the trouble and only 
>>>> risks introducing more reference counting bugs.
>>>
>>> It is for making code cleaner or natural to read. mmu_notifier_get 
>>> is the last call at create_process. If mmu_notifier_get fail the 
>>> process is freed: kfree(process). If create_process success 
>>> kfd_create_process return that process anyway(after create_process 
>>> kfd_create_process creates sys entries that not affect return 
>>> created kfd process). The finally result is same that kref is 2: one 
>>> for kfd process creation, one for mmu notifier allocation.
>>
>> Currently, when you call kfd_create_process for the first time, it 
>> returns with kref=2. One reference for the MMU notifier, and one for 
>> file->private_data.
>>
>> Subsequent invocations of kfd_create_process when the process already 
>> exists should increment the kref by one to track the additional 
>> reference put into the new file->private_data.
> one ways is changing find_process(thread, false) to 
> find_process(thread, true) at kfd_create_process. When kfd process 
> already exist find_process will call kref_get(&p->ref);
>>
>>
>> If you can come up with a patch that preserves this logic _and makes 
>> the code simpler and more readable_, I will consider approving it. 
>> Also keep in mind that your patch would need to be ported to the DKMS 
>> branch, where there are two different code paths to support older 
>> kernels that don't have mmu_notifier_get/put.
>>
> At DKMS branch alloc_notifier and free_notifer either exist together 
> or both not exist. So when HAVE_MMU_NOTIFIER_PUT is defined(new 
> kernel) it is ok.
>
> #ifdef HAVE_MMU_NOTIFIER_PUT
>         .alloc_notifier = kfd_process_alloc_notifier,
>         .free_notifier = kfd_process_free_notifier,
> #endif
>
> but when HAVE_MMU_NOTIFIER_PUT is not defined we need change 
> kfd_process_destroy_delayed since since it call kfd_unref_process(p);
>
> static void kfd_process_destroy_delayed(struct rcu_head *rcu)
> {
>         struct kfd_process *p = container_of(rcu, struct kfd_process, 
> rcu);
>
>         kfd_unref_process(p);
> }
>
> That means if port this patch to dkms branch when 
> HAVE_MMU_NOTIFIER_PUT is not defined(old kernel) we do not need call 
> kfd_process_destroy_delayed or remove mmu_notifier_call_srcu(&p->rcu, 
> &kfd_process_destroy_delayed)  at 
> kfd_process_notifier_release_internal. I think that make thing simpler 
> for old kernel.

No, we still need to destroy the kref that belongs to the process when 
the mm_struct is destroyed. We can't do that in 
kfd_process_notifier_release_internal because it leads to LOCKDEP 
issues. So we still need kfd_process_destroy_delayed.

Regards,
   Felix


>
> So it needs additional handling for old kernel on dkms branch. I do 
> not know who port patch to dkms branch, or I should change that on 
> dkms branch.
>
> Regards
>
> Xiaogang
>
>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Regards
>>>>>
>>>>> Xiaogang
>>>>>
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
>>>>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> index d07acf1b2f93..7c5471d7d743 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> @@ -899,8 +899,6 @@ struct kfd_process 
>>>>>>> *kfd_create_process(struct task_struct *thread)
>>>>>>> init_waitqueue_head(&process->wait_irq_drain);
>>>>>>>       }
>>>>>>>   out:
>>>>>>> -    if (!IS_ERR(process))
>>>>>>> -        kref_get(&process->ref);
>>>>>>>       mutex_unlock(&kfd_processes_mutex);
>>>>>>>       mmput(thread->mm);
>>>>>>>   @@ -1191,7 +1189,11 @@ static struct mmu_notifier 
>>>>>>> *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>>>>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>>>>>> +    if (p) {
>>>>>>> +        kref_get(&p->ref);
>>>>>>> +        return &p->mmu_notifier;
>>>>>>> +    }
>>>>>>> +    return ERR_PTR(-ESRCH);
>>>>>>>   }
>>>>>>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)
