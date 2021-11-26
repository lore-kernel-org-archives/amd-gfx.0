Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5851AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 06:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2546E916;
	Fri, 26 Nov 2021 06:57:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B90E6E916
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 06:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVE9Ppjrtn7XSkws7EP+ce+BiuqmgcP706NVDMYISzfqHRP944fjVsB06eRa543TokLL/uo/QEVRPUhEaJVfVM8UDSK5Gup2fd4naDQyH5LgYQUcJD4IDkiNdXkGfcEdRX+eGJfHgWW1JRdSVbd/0vx4k6gP7/KonNW0wKWLevlafsvJ5b0q5zO4HO23PyFrJ1Gh+YhxmaDY3Rw7yzHDTvK4Tas3z8eX3NAff8TDfWJC0R8ZV0CwiArBIACkU66aF3NEuxXdXg6AUjEJCn0Fv+EZyH4EwF+MYgGU5RfYS7gJNJmsa88vSV/sQOh0YKqI1aUaxZnA1IUY+4doStr6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR6RmYCuKZLMeDVJjrtA5Pqg83LXuvz7lgSp7UngDNU=;
 b=nj9F3NJa7H4g97uOEuD1+xkCXPQi7fFiX3SHtu50o+tV9+UE9EwMFDQfZrFXq+oBTMG6dUUFAl4AEy13Vut3tBrjyL15JbqUwt+8W4WvNi51ufmMJQ1XcT40HVRGHxpXODR4xNIkWvFqqt5NUGIG5RQ8MiO8ttHySLYBC8AFwOI2NAc4szvdZaZas5MZWeheLlQJiz+q6+Tc0Bvj74Nsl80GAUmSHeOXjzbiE5SLqWT+Pff9HApsx6lOIEVd367lUhpmPP7HI4l/E7HhNQchrKD84j4JHscaLU0A2pc1nzXlnURX56oFjZpA8ivu/Iu0+Tej4/UHsPm4k8itW7Ob+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR6RmYCuKZLMeDVJjrtA5Pqg83LXuvz7lgSp7UngDNU=;
 b=m8YFKd36/337Ajuj7xOQRvcKf4d2EVwGl+YQaIfB9NoHPUFmTtVIr8GM0egJ6wb2BPbjvzVhSy+iTG9Wa22PuCyBDm2QnfFFVHdIlR7PaTP3CPQ8AVX/IoRTyVvshs56ybKzWDYuYpVcUjLambS69mGA9kPHm9EKs7O6HmhjNuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 26 Nov
 2021 06:57:13 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 06:57:12 +0000
Message-ID: <a7d32e0a-f8f3-6089-5437-beabe5718e38@amd.com>
Date: Fri, 26 Nov 2021 12:26:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 0/2] Create shared array of power profile name strings
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211125021925.7881-1-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211125021925.7881-1-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::17) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0121.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:96::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23 via Frontend Transport; Fri, 26 Nov 2021 06:57:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e45eb41-a630-43d7-76fe-08d9b0a9f8fa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-Microsoft-Antispam-PRVS: <DM6PR12MB461997DD86CAE97EAA721ED997639@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enBx6gI56HcFUksLIh7tmAgysJNp0ZcVL4589aUDGZSIH1doVEr2HKnwUzcmFvqF/W5d97ivw/rFT6LeUhkjwqZ6X+lZJ7exPH/YBuDyqvarrO6XCWTj1pRCJjrU0QduvdzYMLZd1Vbgkf9ptTTccQR56HXRqsrgxsmobxIRy84sg6/6FW9yrJEnoCBBc96CKJLN0cEELxCjZJknUF195egJMV1T0PtB7OVPb8/I2HnGVBFDcqv+3rU106ciwBzFky293+H2tmaw7ICEGzWfZSr4nAlYM3K68Iiipe9UD63tsb8j/as5kynqnJKEThlkoYCecs/ksuuvjSs4yoS8uBmjBT0qtbjIxWu5MhSYktfKdaA90b23WY5YG6gUnJbdNgyin/aWkezX8vY9dyU7SLNuCBgRgXc+16/tQ8q6Q5wU7Mukrvfp+B5gjugVjW4gj2ShVzCZGKA9lB/BwDCthYkEd6eVi55sBseKFJXBnum3tjmj0BBepCK9gZw8lm9aVJapts/1M4+L/2+x6UNzszYq5aDYk8kSlrPPDx0MOGZrQxodMlrQAP2L8yBuP/faUbcjUF/lqXYuVn8dQpJgKhp/WYMuH8dI9URUnTK2s4xSNixu61Agk+/9ZabfqNiTeNhW9KFnZrMl8QT6yQ9YPWyrEeGKJEbOj0u8kAGiVMP/+ugOzt3ygQi0kwtnblT5dazKZJnTIfIkB4pDEBadBNujV6HI36HKJe0nBV36TEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(5660300002)(38100700002)(16576012)(66946007)(186003)(956004)(6666004)(2906002)(8676002)(508600001)(36756003)(53546011)(83380400001)(31696002)(31686004)(86362001)(316002)(6486002)(66556008)(26005)(8936002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1I2UzhGMFNrTGRxZWtuVng5TUpCOWVvNWd2UVVqVDNTQndTV1BJbUFVdkF4?=
 =?utf-8?B?ckZJZ3BDVTE3RXY2Y0cxYTlqcVlqTzFLbHNVblBYc3FYTDZ5dTVsSFRHUWFS?=
 =?utf-8?B?c3ZFS1RLcUFLdkJDcnB6a1UyK01RQUppaWtaODBOK3BubEpVeGV0U0pqUVEv?=
 =?utf-8?B?L0dDQ3VzaU1RZ2RhN3FsVEh3WHBscG1oc01DSk9sTyt1UVNYbENzaWxCNlho?=
 =?utf-8?B?S0g1QnZxaFg0enVCalJacWtiM2ZnMjk4MFZFV0tJelhHdzBBdkNnTDZpWTVR?=
 =?utf-8?B?L1NLK1lVU3AzUG9tZm1iSFFGdjMydDR1NDNibDdwRmw0d0pObThLd1dDOWxs?=
 =?utf-8?B?dXVVamZrdzRXNE5tbTR3SFgrMnBFb3hnZzNCRHg1bUp4enBwYnpHb2N5QTdK?=
 =?utf-8?B?dXJYSVl5NmdOUCtLZjJhbUtXa3FCbXdmd3dhNVo5QWw3bERqMTdqakIyMnVD?=
 =?utf-8?B?MEQ3MldMbnp6cjgvV1ZYdlRNbG1IOWgveS9sbUdkV3Q3akVjWHU3bUpTb3Yy?=
 =?utf-8?B?Tk1HeFhlUlAzK09idHppQ25ZMWtENVVkT0YzMEVoMWNUUWJlWWVkcnR2K1M3?=
 =?utf-8?B?aWRlM09MR0VTRWQreDRBZ2QrN0RBOU5qaDBnN2ZqLzZIZlUxT1E1VVJ4dkI3?=
 =?utf-8?B?Q3JYQjhCeHp2KzB4SStEemJpNUpWcGtjaEhrRVJwRzZiWWt2c1BrS25HazdB?=
 =?utf-8?B?WlFhMU9PT1IrNDdxZkVoQ0pZQ3Q3bGdsaU9uT3RRMUlZTkpMWGRORlJ3Rm1y?=
 =?utf-8?B?U2pxamM5cmtEeWZhcDhwN295ak01QThYY1llNmxmK29rTUtmdU5mM2h2elQw?=
 =?utf-8?B?eTFxUnd4Q2Q4WHVGTXpsd0duaXlDNlV0TXVJYnlFRVk1VFUvZHI4c2F2QnNH?=
 =?utf-8?B?elRBbzlxUzEyWlZJVjFXWVpWUEhLZUxBNThlWm1GcDFDSE0zeW1yZGtHdjA3?=
 =?utf-8?B?OWo3T1FLZFdrZDB3UStmbm5xRXJZOFZ4TmtzMVFVZ2t0WERXblB1dXVBRUVt?=
 =?utf-8?B?OThZWmR4MXoxejZlSUdvRG8waEh1bmRLbFZqS2xjRTR5WEE1dFpSTWpkVS9I?=
 =?utf-8?B?U1YwMFo2Z01JSVJGM3FEY0lZMWpsd2p5K2VRbk9MRndiZXBmVkQvbVg2UWJY?=
 =?utf-8?B?cHhZRUtBK0FpQUwyQXA3MXhzTWlmaFF0VGRkMGZRTWRPaEFaS0E0dCtsb2oz?=
 =?utf-8?B?bVhxTmlsMFlNVEQxVnVobTNxVm1ocVZRcXpDTmIvemRkUWZpQ1ZiK1c4Zkdy?=
 =?utf-8?B?eTR5Tm94dzFsN3BMMThodE9ldlR0K3hyekpkaXlURlBraTdkRGVtUVpHbzdI?=
 =?utf-8?B?QXpEb2twdEVlY3BwMk0rdmgxZml2eU5hVGVjZk1rZnNPdEplWm9od01zclQz?=
 =?utf-8?B?ZzhmbGxjR3NzTUs2ZVNDL1U3VXFSWi8yWUc0MFFFZXM1Ris4NGRXRVRic1BP?=
 =?utf-8?B?TGIyN3pQL1RSQmFMcGFOak9xSzhkWnJrNldqQU9Xb0pnL3ozc3VIdVZCbzA0?=
 =?utf-8?B?WWFaZEUzbDdyOGNhQ3RYbmhyeDJQVGQ2SEF1cWc1Sld4dWRDVEt1bU9XSEJJ?=
 =?utf-8?B?NW8rTXRDNlNBa2NMWElRMU5kU3ZxT2tNamJZSXFvVFE5NFhkVnFNSGZUNXVh?=
 =?utf-8?B?ejNXcFl0QURiL2MwdkJTVWN5SHY2eitwc2tLRmNOWHlRVXZKT24rOWpiWE1L?=
 =?utf-8?B?NzhweVBKOVVMdzRJYTF3aEtrK21ZcnkzWDRmVVZpZzl1ekFrQVVNVjBVTEk1?=
 =?utf-8?B?VGJBWm9xTm0zRnk5VjgrM2FPS2RQZG9QOHN3MHZsS3BtUkZaOXZnRmN4VUhs?=
 =?utf-8?B?emRWMytjK0pjQjZpaERTVXd0dEVBcXR0eGZiNTJYenR3aWxYTTQ3b3MvWklq?=
 =?utf-8?B?eFJQZHA5TGZScmVVUmNSTnhqc3FNSHB5NlpKYnNaWkE2WVVEd055TVFKQUJH?=
 =?utf-8?B?YmVCTWx6WENXL2p5NU9WcUVKbDJOOHBCY1MydDN4N0pNQ0xYLzZhQ3pFRnEr?=
 =?utf-8?B?VXNlUmUrZVp6cklPZXJPbmpNaHg0cXk5WW5wd3RNbFBwRTZKQ3RoajhUTFpQ?=
 =?utf-8?B?ZE43RmpodnRzdFJyK0IvbGlQNXBXL05QdjZoak83aTB1dWl4V3JmN0k3NWww?=
 =?utf-8?Q?jSS4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e45eb41-a630-43d7-76fe-08d9b0a9f8fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 06:57:12.7498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpYfb+HmWlIn3RQ27iLRNrIrySYWzQhDotsJfCwycssvDVE4oktLb6AXDkci02Ir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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



On 11/25/2021 7:49 AM, Darren Powell wrote:
> == Description ==
>   All the power profile modes use the same strings (or a subset of)
>   Creating a public array of the strings will allow sharing rather than
>   duplicating for each chip
>   First patch only implements change for navi10
>   Second patch extends the changes to all other implementations of
>   pp_hwmgr_func->get_power_profile_mode  (smu10, smu7, vega10, vega20)
>   and pptable_funcs->get_power_profile_mode  (arcturus, sienna_cichlid, vangogh, renoir)
> 
> === Test System ===
>   * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
>    + ISO(Ubuntu 20.04.3 LTS)
>    + Kernel(5.13.0-geabeb4f20a07-fdoagd5f)
> 
> === Patch Summary ===
>     linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 1e7a606dca04
>      + 482319edaabb amdgpu/pm: Create shared array of power profile name strings
>      + 1e7a606dca04 amdgpu/pm: Modify implmentations of get_power_profile_mode to use amdgpu_pp_profile_name
> 
> === Test ===
>   LOGFILE=pp_profile_strings.test.log
>   AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
>   AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
>   HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
> 
>   lspci -nn | grep "VGA\|Display"  > $LOGFILE
>   FILES="pp_power_profile_mode "
> 
>   for f in $FILES
>   do
>     echo === $f === >> $LOGFILE
>     cat $HWMON_DIR/device/$f >> $LOGFILE
>   done
>   cat $LOGFILE
> 
> Darren Powell (2):
>    amdgpu/pm: Create shared array of power profile name strings
>    amdgpu/pm: Modify implmentations of get_power_profile_mode to use
>      amdgpu_pp_profile_name
> 

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   drivers/gpu/drm/amd/include/kgd_pp_interface.h     |  4 ++++
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c                 | 10 ++++++++++
>   .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  9 +--------
>   .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 14 +++-----------
>   .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 12 +++---------
>   .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  | 10 +---------
>   drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 10 +---------
>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 10 +---------
>   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +---------
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   | 10 +---------
>   drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    | 10 +---------
>   11 files changed, 27 insertions(+), 82 deletions(-)
> 
> 
> base-commit: eabeb4f20a0786188fba07a2dd1b0a614c4e15f6
> 
