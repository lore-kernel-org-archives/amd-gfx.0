Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44175EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 13:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9824010E684;
	Fri, 21 Jul 2023 13:30:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 880B010E682
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 13:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV3tzvChOGmvK3Poa0yRSxAVOGpUY+8+fv/hmmZyw3sTXPuSSO1Ujkrd1qFXYrpCh3CT3bqK0fZfg9Ho16F8yWjZSqilcfZQ1LK2fQOw/S8gr4DxWy7i0VrMzQgnmwhQNy7dhNNc1ANrK4y+/f8bUu7QKg4pQwwqDQmgtWL86lzW21EBaBFvkNTQB9ztYYdOljcERA8roFB96hGYeYjsxz6cjvB9llkKJ6DwJuLfpvHqUtj/yZZ4KAOHStyGsksOeyyLiFAz8e9jLrBkHl3tP6w6Is09daeEx0mUQgalO6bAb7Vz8H5LoG4pjT1QRJyTU/MpqotaKsCqoDk/kqJ6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpj+cN9huts5KdBb5WHceLbPmZRKE72gSijIUCc1P4U=;
 b=nkyXgn2P9qd5u+dqa+puRNb+6yv75ND+Egwzyv9P1sK6MdqabgrXNpAA/wemJdomFj4Ji+aAfTE6mkuRZxayHUzqjH5Vk+cZ9uj/XCR8KTDbbPNVNYsVQ1noMr+XqKoQPOVGGtP0azdCKTBg4OqADh4ySFHPLA2hHvkg9HQMG2KN5ql0OynrKtNK/N9DNOsb2tnPBl2BHXlmthLGpvP7nX2vm9e390x0L/4ClpTywNQNVhtnnT8XPknSskQQ+EKT5G5sbTEmC6QuVP15Ltgdg2tF7eg/qPkg1qiw8SoN522iDMZ7j+MW1afJuJ+lOFMVHcLCz+qzkHnZthk2uuxRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpj+cN9huts5KdBb5WHceLbPmZRKE72gSijIUCc1P4U=;
 b=s6YeFd7z3mSecnbzmVsbwa7c8hUExxZsgTro6+7JVP8HyKLgiV4Mk/ycrcJv5Tzuzd+eEMIxIPVBjg5t6cZ6CDAqAP0qzkbANkSG1BIhLK9+wHGOwvjAaX1kGps/v/5fiGFV2SqLg+ZwhqW4fTakFC7ElUXgJ/cmR5sVAj4V1BA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Fri, 21 Jul
 2023 13:30:18 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 13:30:18 +0000
Message-ID: <0a99c609-c5c2-25fc-4ceb-52a0b4a49f29@amd.com>
Date: Fri, 21 Jul 2023 09:30:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Philip Yang <Philip.Yang@amd.com>
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
 <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
 <1da36164-7cd9-c2a3-a42f-558942257727@daenzer.net>
 <f8c83922-f3d4-34d8-6ae1-3112b52bcdf3@amd.com>
 <d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8a230f-d0d2-4fbd-05e0-08db89ee9fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3pKub0HA7i6avig1DNFveOhgap6uucdD6AwGB3Uv799l4RgV9IQFlRB9ncnDiR4DdNxEqo8ri+HRs8EK5/gTWqJfY1NDLOI9wzHA0frkqFSmgr96rbTqap5NkLMMJJ4TEehAebWobfA8Fua3tyCN3wmPJqgOfBsNk1uJhkZqe2P8VeQWo9xHT2w6uALIe3p2qig3y1NbHFb+Ti36DWvdEMDWeiGict4jvf+m9NQe0Ab4ZS9iLswbRKdmVZ2s/R8JzMvI9MndAZ/pZ325luAuuFpLhJHRHe/f8bOpEBbter4RZzNnzC3H/alioYk/MWauuDeAbguTKnsd8GR4emcS8tmRY+BBpt+npRGMIfyi2tnbTgHXiuPbhVDYiz0uE1Hd0JXO3Ir9INWV4V1Iv8zMtu5b758yTYzqyJzKSMeVrtHBOav0VkoVtLk24fO6780KMaqb/L29g/u4ibfjczYA85i/2M1UpMzFVzXgHkOg+TInKJCpS0v1NFybtB41kfWlvzySfoKEOaZljN5z38Rov/14/4B4Lm+76DHnEE27+RbUdHnro1wzAhQx7Ows9hksJmBxMZuS6jhjK8THn+84MORgG4TFxOMguVc752bJvF9vZqRr/GdZOW1Qd5vvY+CZ/bp7imUaGxNk0q9qTwMiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(31686004)(2906002)(8936002)(8676002)(66556008)(966005)(66476007)(4326008)(66946007)(6636002)(316002)(41300700001)(5660300002)(6486002)(6512007)(36756003)(186003)(31696002)(53546011)(478600001)(6666004)(110136005)(54906003)(6506007)(83380400001)(66574015)(2616005)(26005)(38100700002)(166002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTV3TUlSU09Ob254b3VVb2lPTGlFTmZnYnlaeDdVRjFSMWJuR3pJK3NpaXBS?=
 =?utf-8?B?U05yS0Y4V3ZMQW9zOTJvZmVMYlNVdCtWS2FxL1RWZTJ0K2FXTVFLeFRoZTFD?=
 =?utf-8?B?SzRrNmVGTWpiajNWcFdKdWZmdTZmd1BHM0tUQTljWllOQ2gvNEJQcENGNHZE?=
 =?utf-8?B?a1A0MnBIcmRNTm56UDR3ZmcxOEZKWE9jeXlULzlZTzFWN0ExQlB2QXc0RTZZ?=
 =?utf-8?B?SlBIY1RwUEl0eGVnQk5ZN1JGbmh0M0w5M1EzVGtOd2taUzB6aGdYNm5nb0Ja?=
 =?utf-8?B?YjZvY1dIZklPQUVFYTdFcmhuMUJxS1BheHVjNURhcFhBbjlnT0Z6MDBmNWs5?=
 =?utf-8?B?dUF3aVhpakcvQTM0OEE0ZS9lZDZWOElBOXRNT0wwUkpSYkNyMThBZnNQdGtR?=
 =?utf-8?B?cnhJYzZUbUhFUmJCY2Z0cXU5blZEOHBOQ3lxd3lSWnB1WEhuNDBuUkpxcDdO?=
 =?utf-8?B?WHJiY1JHUFlKVFZ4cWVQQnFveWErdm1GUmd3SENod0UzVnpUSHJVVEdVMWJX?=
 =?utf-8?B?cXRGQVFuR1FYMnJSekZtRGg4STFlRTJLb3k1S0tFdlpobGt2TGZvQXhVd2xP?=
 =?utf-8?B?NDVwZDJvVHhlRFVGTVVWWGRNcnI2Zy9OMEZ2M0ZWQ3N0Z2NRSVgxK3hmdkFw?=
 =?utf-8?B?L2xVYTI5SHZyRjZaZFN5TU9La01oVWc5Z2ZzV3kzcUtYeHhzTkJGWFBlNDV5?=
 =?utf-8?B?TlRUTGtRcFUrOTVoaHFBNG1VRGY4UmtKUUMwRk9YYm5oeDgrTkF3NjlFY1BL?=
 =?utf-8?B?Z2pRVm5Pc2lWelFQVFdaV1VWSWNaVTJ5d3FQNWVoTDJsblhNQzZxdDh0S2hw?=
 =?utf-8?B?Q21Bd01oWWV6VVhRdE9CS2dvUldPZGt3d1BORFdybTRNU0ltOXFZQ3NRdUt3?=
 =?utf-8?B?MXRsMUJ0Z3g0emU2RGNYK1dnUitkd2JuM24wdU9hbTYxYmdNdXcwZlI0SHh2?=
 =?utf-8?B?TE5kSS9jVmZlV0I0Yjc1OEVMMEJsdUpTWFRCa3poMGJLbDRad1VPdHJKUm1G?=
 =?utf-8?B?YXdmS3lDVjFyNEppVEcwVk15WFNkMzNYbE5VY2FUdzhjNmIybGE3VXpDdjFl?=
 =?utf-8?B?bFpYL3RYb3RPUVAvbisvazNsYTRWQzZGbGVDVnNXU2REZjJxRWhhRGVyRDEv?=
 =?utf-8?B?eFZFMjlGK0lUWHBxOW1OR1pULytYOFRXajRGcFlLVGdYZXFWaVNOVU9mdERy?=
 =?utf-8?B?VktpU1RiWjFxSDI3bGlFY3luM2labnhIdFkxVzY4cHM5WjM3aGo0WktkNnB5?=
 =?utf-8?B?UEJKM0MzSGFqenQ5NWNXd3JZdm83bjdJa28xSFc1ditjLzZtcXJCY2dybWNB?=
 =?utf-8?B?VHFuL2RCZmtMWUw2YWgxZFY4VmpOdVozaUdIQklsdW42QkxDdlhsOUlDR0Rw?=
 =?utf-8?B?T0RCZkVLQ2hqdEd2VjRhRGVzcERlU1QzWDhyci9MZUJ4Y2NDa3QzMitHcFpN?=
 =?utf-8?B?cFQ0WHdtOXJsNjUxckFualhWb3NzYXF1cU5VWk5Lc2h3Qndlcm9NSUN3VmZQ?=
 =?utf-8?B?M3hWSEMvNXF5UlA4VXNtRm5HRGNPS1BQc3UyejJ5TVNHbzVSelMxYnIxWFF4?=
 =?utf-8?B?OTQ3c0R2eGpKU29UUkoxaUVIazV2cnBMZXJ4Nmt2QkVBUTRiSTYrMVN3Y2I1?=
 =?utf-8?B?VysxZjhDWG02eU9EL2R2am9TZ0hFQy9KSFB2aXVFNXBObjA4UlFpemlNdmhw?=
 =?utf-8?B?TEoyYWZOdExZVGZVSlVGM0JXbzRUNVlUcUtZM2lRcGN3VmorNHNaOEpJRHJN?=
 =?utf-8?B?RXZyQVhmcHFhNzRBVE9qU1dzUXY1Sll1alh2ZURRS2NORmgvalFVTURjSzUw?=
 =?utf-8?B?RjBmT3MxakM4QURiV1BHbVJoa0lJVHRFVVg0UUVWdEVjS2Q2bTZSVm9MbHQx?=
 =?utf-8?B?ZGpmak1YVmxRQnNuSGVGRmczUjZFcldPMWJiSDhjM0I3cVV4MnRFTEZ6MWU5?=
 =?utf-8?B?MVJRN3dFSjU1UVFXOUJOVnRXNDNhZW4wUXk4eWxETmhyKzBNSjFmS1lCOFRH?=
 =?utf-8?B?QXlvREtYVm5xQ0o0cGFIWllNNkIzK2p6SE1LWm9XY1htdkcyTy9zeHNUU2ZZ?=
 =?utf-8?B?MmlZQVNFOEV6QVI2bTlqK0V3bDVTeFBMc20vT3hQRGw4UWJVeXI1aVM4RmZ4?=
 =?utf-8?Q?/8sM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8a230f-d0d2-4fbd-05e0-08db89ee9fcb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:30:18.1797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCCCIOQwuF4uU9vYEr24/S9QL3OzRBxrZ7x7b+xeS+NwHwCkoXJu5bedXxCmP3Pd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-07-21 04:55, Michel Dänzer
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net">
      <pre class="moz-quote-pre" wrap="">On 7/20/23 22:48, Philip Yang wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 2023-07-20 06:46, Michel Dänzer wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 7/17/23 15:09, Michel Dänzer wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 5/10/23 23:23, Alex Deucher wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">From: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>

Rename smv_migrate_init to a better name kgd2kfd_init_zone_device
because it setup zone devive pgmap for page migration and keep it in
kfd_migrate.c to access static functions svm_migrate_pgmap_ops. Call it
only once in amdgpu_device_ip_init after adev ip blocks are initialized,
but before amdgpu_amdkfd_device_init initialize kfd nodes which enable
SVM support based on pgmap.

svm_range_set_max_pages is called by kgd2kfd_device_init everytime after
switching compute partition mode.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">I bisected a regression to this commit, which broke HW acceleration on this ThinkPad E595 with Picasso APU.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Actually, it doesn't seem to break HW acceleration completely. GDM eventually comes up with HW acceleration, it takes a long time (~30s or so) to start up though.

Later, the same messages as described in <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/2659">https://gitlab.freedesktop.org/drm/amd/-/issues/2659</a> appear.

Reverting this commit fixes all of the above symptoms.


I reproduced all of the above symptoms with amd-staging-drm-next commit 75515acf4b60 (&quot;i2c: nvidia-gpu: Add ACPI property to align with device-tree&quot;) as well.


For full disclosure, I use these kernel command line arguments:

 fbcon=font:10x18 drm_kms_helper.drm_fbdev_overalloc=112 amdgpu.noretry=1 amdgpu.mcbp=1
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Thanks for the issue report and full disclosure, but I am not able to reproduce this issue, with both drm-next branch and amd-staging-drm-next branch tip on gitlab. The test system has same device id, running Ubuntu 22.04, latest linux-firmware-20230625.tar.gz, and same BIOS version.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
FWIW, your system has PCI revision ID 0xC2, while mine has 0xC1.

Also, I'm currently using linux-firmware 20230515. AFAICT there are no relevant changes in 20230625, but I'm attaching the contents of /sys/kernel/debug/dri/0/amdgpu_firmware_info just in case.


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">I attached full dmesg log, could you help check if there is other difference, maybe kernel config, gcc version... it is hard to guess what could cause the basic driver gfx ring IB test timeout.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I suspect the IOMMU page faults logged in my dmesg might be relevant:

 amdgpu: Topology: Add APU node [0x15d8:0x1002]
 amdgpu 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x122201800 flags=0x0070]
 amdgpu 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x1125fe380 flags=0x0070]
 kfd kfd: amdgpu: added device 1002:15d8

There are no such page faults with the commit reverted.

Other than that and the IB test failure messages, our dmesg outputs are mostly identical indeed.</pre>
    </blockquote>
    <p>Yes, I don't have IO_PAGE_FAULT message on my system, thanks for
      the finding, I will continue investigating the root cause. <br>
    </p>
    <p>You are right, the error message could cause gfx ring IB test
      timeout failure, this patch does change the order of driver memory
      allocation. IOMMU is in translation mode on Ubuntu config.</p>
    <p>To help confirm if this is caused by IOMMU, please add this to
      kernel boot option to set IOMMU to passthrough mode, check if this
      can workaround the issue</p>
    <p>iommu=pt</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net">
      <pre class="moz-quote-pre" wrap="">


</pre>
    </blockquote>
  </body>
</html>
