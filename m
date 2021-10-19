Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59080C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 13:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEBE61378
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 13:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DEBE61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D626EBD0;
	Tue, 19 Oct 2021 13:54:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF0D6E887
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 13:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEKNRKZgj8s4lR6oKHsQaSYfQc1As3fJN3y8cOz7mFqTEbXy5dsYkwoTs44/iCLdpUbyNQsEHahGYxSPAZfJlJngYUhRDDXxN02HivjTOl0GPIjL9oPZTG5qXZKm1Tj2jIM1d7n4MGjO5mMw6SdrRqef9r7W9jZTfQEyRF+xmnYtxu6itCw3x6spyvDPp57a5BdkcjsbSLskQB0AZtBcWorN8eAeTpJWjCpAMAlFO0LX8mlTtOJo8iTJLfE9zQeaRNijqJhTysxCMJMIb6379tpE8cwZcVX5QEsLxYT1RbG1YxLt9N3cDy9gdblElqVHB9zHGyLkF9HnNSxlsn3CGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzpaDcMmJw3eL/TMRndlfh7om37aEX8dFdXahoRX9Bg=;
 b=b10T/kPk7WS7bJvK/oZ97rK8ZvoCh0/RMGChPovSvjFET/clqNrVQOb0IHlfJshL+t3ljHlOYf6z9hw0+emZAfyMCz6PQxEHqyUWUuLs0BBE96YRC/EFlDmM22+nvDPamubYyNfkQh0ghwTZ+IiCiQSnTI8GERRrUnK4fH5e1uaESwgFNWPRVvHvjDw12x809tULwrf/ICPBoxwONyJ7FFwcLZw6Ghlk+4y+ci6bH81ro713lLTE96j4S0v2iEaa4mugWsna9xUCkonOUk4DaIKKWy2Ke9vhDaF+aAS//WsgGJ1rLOLp+TxpcbqmXY8phBEuM+xrozjCJ4eHTGq8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzpaDcMmJw3eL/TMRndlfh7om37aEX8dFdXahoRX9Bg=;
 b=oObxk4t2iKj/DcxfpX+mYp0uhHPGV3TLDPYkVQIBQ2Ar1fZshpikKlIAAB90omETQYG8a3cMVJTLqjwonHuq8ASiBwZlLQObBJhM9fZ/XJb9Ag50BbxQX8QT30lc5q8Maii7ctF/VN6Y41LAGFKM/89iZb8wwqaetzH2mdSmKxs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 13:54:41 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 13:54:40 +0000
Message-ID: <a0939873-8599-c47c-15ec-cfb5018edf57@amd.com>
Date: Tue, 19 Oct 2021 09:54:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
 <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
 <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
 <DM6PR12MB26196111DA43A1EE11266558E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BL1PR12MB51443E4EA64480401839E135F7BC9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <091c6805-a72c-a286-f7fb-9d5d5da344d3@amd.com>
 <DM6PR12MB3324CDCA68D04483A57C150985BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <DM6PR12MB3324C490C0CF191F6F34602C85BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <831e76f9-4fad-da9f-7baf-1e0dc92a378a@amd.com>
 <DM6PR12MB3324ECC96ADE558E587AAFF085BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
Content-Language: en-CA
In-Reply-To: <DM6PR12MB3324ECC96ADE558E587AAFF085BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::13) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Tue, 19 Oct 2021 13:54:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a32d042a-1646-4526-7d09-08d99307ff3b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3866B287714B7DAE32A458AA99BD9@DM6PR12MB3866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VnUK0wfEMtD0bt8UJV6O+wBXsoUpUI6b9fJEh9WoeCgWP9KQr7zrspWL44+CbZ+CQGyWCIDk4TRY44QztGMw3MnmEfkwUzrqQZREcT9s6bYDM2/y8YI+qJfN6IxFVIArkGCtVG1w8c0OPmNI5lb+QCesnFDELYgpf0zRgent03KiqwO5WQ32PWBsqzXFt2BXdFb2E+6us9dr/XNxEHhbbrLCojmQLpWxuFXJFs2UdfPvAjcxpaY0eSKZh1Klqy9Cyfo2gkFglnHOe3xXL+mZAAnT60Xn9hRDZEtbvIk8EsNz4qppQJLBSC9nEhJmfrPHui8jUZAlcStfH3u7xehSmqhUh25UO1W+HaKa9s7fwbgjHT5wEBnekERliF7JJBo/0PcbZ8oSzUppMFpZmHe1gGMfMpduJIABNZcLPb9ZyakuCKq9wSDVhyeWtn3dIaKhUFaSR/EG3f71uyoaFiaLq98syklMJZlltMGqNIJSG2p7JPGjK6dXyBO7IXZhTeFtcGqp4fbXJefBc3x1R4MvWv7PhWAszo9UWZI482hiHAkQ8qcgFaDoCOpPPiwlXuU8OHjsPQneuZstlS9e9V/Fq5a+jWybeFN8dCF8Uac8vsJOKmlud8QtVv9/2/PRkixQGwguioetFPX/agC+OudMBFZfONWXLFlNRfzX9QVa2P1APiZrE7apZ60QFOgs3W5+yr476Z5L47m8eKvl1UrDgQ2+R5Zab81uDc+wFqf3nLEQk8V5+HUmJHH+DpIuJyG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(36756003)(4326008)(53546011)(110136005)(2906002)(316002)(8936002)(5660300002)(186003)(508600001)(4001150100001)(38100700002)(2616005)(31696002)(44832011)(31686004)(8676002)(86362001)(16576012)(26005)(956004)(66476007)(66556008)(83380400001)(66946007)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFzdU93VGtwWGMycEFVSC91Q3Y4R1haMSsxTlpXMnVDQzU1TWE4dXdRM2Va?=
 =?utf-8?B?a0grWFNOSFB6L3I4eGk1YVI4OUJnNWpBZTZjWDN0allFNzVWbG01UklpbnZC?=
 =?utf-8?B?ZG9ya0RUTlV2aFZiUjIxZXg3RE0vclNNRVBRNmlxRDkwcitGODZLSmkyZXM4?=
 =?utf-8?B?eEd2dW9jV3NmSlZVOUN2azNRb1F3UzRCUGxVVllKNWlJQjdVUVVoT3dDRXhj?=
 =?utf-8?B?SUJOZGE2R0sybWVHblUwZ2tnTlpVSXNWWFBYck9QVWV6a0NkdUVvOEw5eXBo?=
 =?utf-8?B?cnpZM1F5S2ZWbE1aN2wwNWR5K3JxZmNTeWNDM01ncU1kWHpqU3FLV1BJNUFN?=
 =?utf-8?B?YWNHL1drcjJQbkcrVTBRalU0M1hUbEdOazZFRG84aUJJRXRiT0ptZjIvVlFH?=
 =?utf-8?B?bVBYVUJ0OENUMERoVno3OC9CS0FqR09XZkUvQWhaTGNoOS80aHM4RlJ5YjVT?=
 =?utf-8?B?Wk5taEw0SVBsUWdZL25maDM3VVRrOU1HZ0UwVTd0VHVySy9UbDR0S1J3L0Zv?=
 =?utf-8?B?SW5SUGNHSHUvcm01VGMxS3pJMTUrd1JnWFU2L3p4TjRYWTQydG44Rm9FMThR?=
 =?utf-8?B?VXhMQ3JERlVJa2g4cVAwN3ptZERNOFR4ZUN0T1Q5ZnpyQkw4c0JaM0RENU1v?=
 =?utf-8?B?NmJnbW9QbUVKamg3dDYreFVOZ3ptWDdNZytlejQ4TVBKdTlOem5BbnBEQzYw?=
 =?utf-8?B?aHVUcGRiazJuOUc5TlBsUVZKQkQzSDVYbHhPRVR4WkVydHgwSWZUV2FGRlAx?=
 =?utf-8?B?WC9jMlhPbTlDOENTWEs3eFdvL3hMYnZ2RTlkQzJIbU1URDU4anEvWktQUXJX?=
 =?utf-8?B?V1pCUi9nd2FNOGV1NEdBeXpIVTFZUlJENG51MHorTG1GVm1vMXhiU1ZmMXUv?=
 =?utf-8?B?c1BudXRWekVCWk5vL0xYT2RuZld5eTZ3QytYa3JSODFFNjBMOUx1dDhDcXFE?=
 =?utf-8?B?a2dmRm5RcHFiaFZWYnM5NVRtK2J4NFNZS0dTNlFYMUhKK3ZCeTAwSGRLNWh0?=
 =?utf-8?B?cG4ydUR6dW56alZJTXdTQXBOZXU5QnV5WHhSbXNHYXpQQUQzQ1R4blVGVTRv?=
 =?utf-8?B?cGd0NmhFZXE0UzRrZ3JFMlR0MGFsdlRFYjVNbkk4WVZ0OFozOGpZUnRvS25q?=
 =?utf-8?B?Y25mdGxMY0RQWmxJKys1aWd6dTE1ektLbktrMEVBK1o2cG1qWlVIdmZHV3Ny?=
 =?utf-8?B?Mmd1eEF3T1A5TFBUN3IyZkJwSE55RFR5bC9VQXFkc3kxQ3ZsRUZHSXZtNlZV?=
 =?utf-8?B?ZndkNUdRYXlnczh5VXlleG5DMVRzZ3hxQ0FiTlByeGhPdTNkVFkrUUFnbjRW?=
 =?utf-8?B?Z1VaZlJJOXZJUERydXZEd3lBN3F0N2QyZnNkSExPNUhDWXlqamdLTVZrKzFq?=
 =?utf-8?B?UFVxUTRvWVhOeU9mMkt5Nk81Qy9JMVdlTkdVM1FNVFZwSDM4cUdxbEhOU1gr?=
 =?utf-8?B?TG00bFpXNjNMM1RrbkY2WmhCbDM0M0RtZmZqeGF6YVA3UjJzeEpuK2dyMkVE?=
 =?utf-8?B?ZkdTenArb0swSUlRL3U4L2VGVVd1QldNa0IwVDRxbFMvWkthRENWMlJNUzFo?=
 =?utf-8?B?UGhrSm9VaERTS2RvdDNHYjdHRGZDNlA1ckU3QjNsSURIbFFKQUk4Y1B0akR0?=
 =?utf-8?B?clRmYkhyQkUyZ2tuQmtZYUVEbVlTa1d4ckVmY2pwTVI5SFhwQTRMYVpHejRn?=
 =?utf-8?B?TzRMeWlGODlsWGxRSXZWT0Q2ZUE5SW1kUmlmWEp3dDNRSzJRejlpR1VDdVhh?=
 =?utf-8?Q?t92ukcqTKdedWKy/sokkL52UVLARjrEJAvnhsTG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32d042a-1646-4526-7d09-08d99307ff3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 13:54:40.7337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhPILNE/fU/KHTOUeivZEAU8NUAPP1UoLh/vaol3E3Mcx2uNSUiMJzSMv3xogI7N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">It again fails with the same message! <br>
      But this time it is different!<br>
      Here's why:<br>
      <br>
      <font face="monospace">openat(AT_FDCWD,
        &quot;/sys/class/drm/card0/device/pp_dpm_fclk&quot;, O_RDONLY) = 3<br>
        read(3, &quot;<font color="red"><b>0: 571Mhz \n1: 1274Mhz *\n2: 1221M</b></font>&quot;...,
        8191) = 36<br>
        read(3, &quot;&quot;, 8191)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>
        close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>
        write(2, &quot;python3: /home/ltuikov/proj/amd/&quot;..., 220python3:
        /home/ltuikov/proj/amd/rocm_smi_lib/src/rocm_smi.cc:913:
        rsmi_status_t get_frequencies(amd::smi::DevInfoTypes, uint32_t,
        rsmi_frequencies_t*, uint32_t*): <font color="red"><b>Assertion
            `f-&gt;frequency[i-1] &lt;= f-&gt;frequency[i]' failed.</b></font><br>
        ) = 220<br>
        mmap(NULL, 4096, PROT_READ|PROT_WRITE,
        MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f531f9bc000<br>
        rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0<br>
        rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) = 0<br>
        getpid()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 37861<br>
        gettid()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 37861<br>
        tgkill(37861, 37861, SIGABRT)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>
        rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0<br>
        --- SIGABRT {si_signo=SIGABRT, si_code=SI_TKILL, si_pid=37861,
        si_uid=1000} ---<br>
        +++ killed by SIGABRT (core dumped) +++<br>
        Aborted (core dumped)<br>
        <font color="red"><b>$cat
            /sys/class/drm/card0/device/pp_dpm_fclk</b><b><br>
          </b><b>0: 571Mhz </b><b><br>
          </b><b>1: 1274Mhz *</b><b><br>
          </b><b>2: 1221Mhz </b><b><br>
          </b><b>$_</b></font></font><font color="red"><b><br>
        </b></font><br>
      Why is the mid frequency larger than the last?<br>
      Why does get_frequencies() insists that they be ordered when
      they're not? (Does the tool need fixing or the kernel?)<br>
      <br>
      The current patchset doesn't report 0, and doesn't report any
      current if 0 would've been reported as current. But anything else
      is reported as it would've been reported before the patch. And I
      tested it with vanilla amd-staging-drm-next--same thing.<br>
      <br>
      Regards,<br>
      Luben<br>
      <br>
      <br>
      On 2021-10-19 09:25, Russell, Kent wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB3324ECC96ADE558E587AAFF085BD9@DM6PR12MB3324.namprd12.prod.outlook.com">
      <meta name="ProgId" content="Word.Document">
      <meta name="Generator" content="Microsoft Word 15">
      <meta name="Originator" content="Microsoft Word 15">
      <link rel="File-List" href="cid:filelist.xml@01D7C4CB.4CFC7E60">
      <link rel="Edit-Time-Data" href="cid:editdata.mso">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><!--[if gte mso 9]><xml>
<o:OfficeDocumentSettings>
<o:AllowPNG/>
</o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DocumentKind>DocumentEmail</w:DocumentKind>
<w:TrackMoves/>
<w:TrackFormatting/>
<w:EnvelopeVis/>
<w:ValidateAgainstSchemas/>
<w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
<w:IgnoreMixedContent>false</w:IgnoreMixedContent>
<w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
<w:DoNotPromoteQF/>
<w:LidThemeOther>EN-US</w:LidThemeOther>
<w:LidThemeAsian>X-NONE</w:LidThemeAsian>
<w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
<w:Compatibility>
<w:DoNotExpandShiftReturn/>
<w:BreakWrappedTables/>
<w:SnapToGridInCell/>
<w:WrapTextWithPunct/>
<w:UseAsianBreakRules/>
<w:DontGrowAutofit/>
<w:SplitPgBreakAndParaMark/>
<w:EnableOpenTypeKerning/>
<w:DontFlipMirrorIndents/>
<w:OverrideTableStyleHps/>
</w:Compatibility>
<w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
<m:mathPr>
<m:mathFont m:val="Cambria Math"/>
<m:brkBin m:val="before"/>
<m:brkBinSub m:val="&#45;-"/>
<m:smallFrac m:val="off"/>
<m:dispDef/>
<m:lMargin m:val="0"/>
<m:rMargin m:val="0"/>
<m:defJc m:val="centerGroup"/>
<m:wrapIndent m:val="1440"/>
<m:intLim m:val="subSup"/>
<m:naryLim m:val="undOvr"/>
</m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false" DefSemiHidden="false" DefQFormat="false" DefPriority="99" LatentStyleCount="376">
<w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
<w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
<w:LsdException Locked="false" Priority="9" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
<w:LsdException Locked="false" Priority="9" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
<w:LsdException Locked="false" Priority="9" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
<w:LsdException Locked="false" Priority="9" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
<w:LsdException Locked="false" Priority="9" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
<w:LsdException Locked="false" Priority="9" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
<w:LsdException Locked="false" Priority="9" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
<w:LsdException Locked="false" Priority="9" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index 4"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index 5"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index 6"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index 7"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index 8"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index 9"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" Name="toc 1"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" Name="toc 2"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" Name="toc 3"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" Name="toc 4"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" Name="toc 5"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" Name="toc 6"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" Name="toc 7"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" Name="toc 8"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" Name="toc 9"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Normal Indent"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="footnote text"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="annotation text"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="header"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="footer"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="index heading"/>
<w:LsdException Locked="false" Priority="35" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="caption"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="table of figures"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="envelope address"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="envelope return"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="footnote reference"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="annotation reference"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="line number"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="page number"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="endnote reference"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="endnote text"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="table of authorities"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="macro"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="toa heading"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Bullet"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Number"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List 4"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List 5"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Bullet 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Bullet 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Bullet 4"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Bullet 5"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Number 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Number 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Number 4"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Number 5"/>
<w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Closing"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Signature"/>
<w:LsdException Locked="false" Priority="1" SemiHidden="true" UnhideWhenUsed="true" Name="Default Paragraph Font"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Body Text"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Body Text Indent"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Continue"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Continue 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Continue 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Continue 4"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="List Continue 5"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Message Header"/>
<w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Salutation"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Date"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Body Text First Indent"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Body Text First Indent 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Note Heading"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Body Text 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Body Text 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Body Text Indent 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Body Text Indent 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Block Text"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Hyperlink"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="FollowedHyperlink"/>
<w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
<w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Document Map"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Plain Text"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="E-mail Signature"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Top of Form"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Bottom of Form"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Normal (Web)"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Acronym"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Address"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Cite"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Code"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Definition"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Keyboard"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Preformatted"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Sample"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Typewriter"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="HTML Variable"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Normal Table"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="annotation subject"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="No List"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Outline List 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Outline List 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Outline List 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Simple 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Simple 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Simple 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Classic 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Classic 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Classic 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Classic 4"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Colorful 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Colorful 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Colorful 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Columns 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Columns 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Columns 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Columns 4"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Columns 5"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Grid 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Grid 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Grid 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Grid 4"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Grid 5"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Grid 6"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Grid 7"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Grid 8"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table List 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table List 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table List 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table List 4"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table List 5"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table List 6"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table List 7"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table List 8"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table 3D effects 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table 3D effects 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table 3D effects 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Contemporary"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Elegant"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Professional"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Subtle 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Subtle 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Web 1"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Web 2"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Web 3"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Balloon Text"/>
<w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Table Theme"/>
<w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
<w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
<w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
<w:LsdException Locked="false" Priority="61" Name="Light List"/>
<w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
<w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
<w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
<w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
<w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
<w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
<w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
<w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
<w:LsdException Locked="false" Priority="70" Name="Dark List"/>
<w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
<w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
<w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
<w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
<w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
<w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
<w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
<w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
<w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
<w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
<w:LsdException Locked="false" Priority="34" QFormat="true" Name="List Paragraph"/>
<w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
<w:LsdException Locked="false" Priority="30" QFormat="true" Name="Intense Quote"/>
<w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
<w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
<w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
<w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
<w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
<w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
<w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
<w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
<w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
<w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
<w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
<w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
<w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
<w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
<w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
<w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
<w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
<w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
<w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
<w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
<w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
<w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
<w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
<w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
<w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
<w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
<w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
<w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
<w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
<w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
<w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
<w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
<w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
<w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
<w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
<w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
<w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
<w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
<w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
<w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
<w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
<w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
<w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
<w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
<w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
<w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
<w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
<w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
<w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
<w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
<w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
<w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
<w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
<w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
<w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
<w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
<w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
<w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
<w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
<w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
<w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
<w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
<w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
<w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
<w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
<w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
<w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
<w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
<w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
<w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
<w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
<w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
<w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
<w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
<w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
<w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
<w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
<w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
<w:LsdException Locked="false" Priority="19" QFormat="true" Name="Subtle Emphasis"/>
<w:LsdException Locked="false" Priority="21" QFormat="true" Name="Intense Emphasis"/>
<w:LsdException Locked="false" Priority="31" QFormat="true" Name="Subtle Reference"/>
<w:LsdException Locked="false" Priority="32" QFormat="true" Name="Intense Reference"/>
<w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
<w:LsdException Locked="false" Priority="37" SemiHidden="true" UnhideWhenUsed="true" Name="Bibliography"/>
<w:LsdException Locked="false" Priority="39" SemiHidden="true" UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
<w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
<w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
<w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
<w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
<w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
<w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
<w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
<w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
<w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
<w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
<w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
<w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
<w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
<w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light Accent 1"/>
<w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
<w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
<w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
<w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
<w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful Accent 1"/>
<w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful Accent 1"/>
<w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light Accent 2"/>
<w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
<w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
<w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
<w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
<w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful Accent 2"/>
<w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful Accent 2"/>
<w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light Accent 3"/>
<w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
<w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
<w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
<w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
<w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful Accent 3"/>
<w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful Accent 3"/>
<w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light Accent 4"/>
<w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
<w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
<w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
<w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
<w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful Accent 4"/>
<w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful Accent 4"/>
<w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light Accent 5"/>
<w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
<w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
<w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
<w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
<w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful Accent 5"/>
<w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful Accent 5"/>
<w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light Accent 6"/>
<w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
<w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
<w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
<w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
<w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful Accent 6"/>
<w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful Accent 6"/>
<w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
<w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
<w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
<w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
<w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
<w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
<w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
<w:LsdException Locked="false" Priority="46" Name="List Table 1 Light Accent 1"/>
<w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
<w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
<w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
<w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
<w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful Accent 1"/>
<w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful Accent 1"/>
<w:LsdException Locked="false" Priority="46" Name="List Table 1 Light Accent 2"/>
<w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
<w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
<w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
<w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
<w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful Accent 2"/>
<w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful Accent 2"/>
<w:LsdException Locked="false" Priority="46" Name="List Table 1 Light Accent 3"/>
<w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
<w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
<w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
<w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
<w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful Accent 3"/>
<w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful Accent 3"/>
<w:LsdException Locked="false" Priority="46" Name="List Table 1 Light Accent 4"/>
<w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
<w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
<w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
<w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
<w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful Accent 4"/>
<w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful Accent 4"/>
<w:LsdException Locked="false" Priority="46" Name="List Table 1 Light Accent 5"/>
<w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
<w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
<w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
<w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
<w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful Accent 5"/>
<w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful Accent 5"/>
<w:LsdException Locked="false" Priority="46" Name="List Table 1 Light Accent 6"/>
<w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
<w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
<w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
<w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
<w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful Accent 6"/>
<w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful Accent 6"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Mention"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Smart Hyperlink"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Hashtag"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Unresolved Mention"/>
<w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true" Name="Smart Link"/>
</w:LatentStyles>
</xml><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536869121 1107305727 33554432 0 415 0;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-469750017 -1073732485 9 0 511 0;}@font-face
	{font-family:"Times New Roman \;color\:black";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-format:other;
	mso-font-pitch:auto;
	mso-font-signature:0 0 0 0 0 0;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;
	text-underline:single;}a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	text-decoration:underline;
	text-underline:single;}p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-style-unhide:no;
	margin:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	mso-style-unhide:no;
	margin:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}p.xmsipheadera4477989, li.xmsipheadera4477989, div.xmsipheadera4477989
	{mso-style-name:x_msipheadera4477989;
	mso-style-unhide:no;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}p.xmsochpdefault, li.xmsochpdefault, div.xmsochpdefault
	{mso-style-name:x_msochpdefault;
	mso-style-unhide:no;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}p.msipheader9f8d35bc, li.msipheader9f8d35bc, div.msipheader9f8d35bc
	{mso-style-name:msipheader9f8d35bc;
	mso-style-unhide:no;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}span.xmsohyperlink
	{mso-style-name:x_msohyperlink;
	mso-style-unhide:no;
	color:#0563C1;
	text-decoration:underline;
	text-underline:single;}span.xemailstyle18
	{mso-style-name:x_emailstyle18;
	mso-style-unhide:no;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:Calibri;
	color:windowtext;}span.EmailStyle24
	{mso-style-type:personal;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	color:windowtext;}span.EmailStyle25
	{mso-style-type:personal;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	color:windowtext;}span.EmailStyle26
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 10]><style>/* Style Definitions */
table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;}
</style><![endif]--><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheader9f8d35bc" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
            Official Use Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><span style="mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New Roman&quot;">It
            was the rocm-smi -c flag. Maybe some work was done to make
            it more robust, that would be nice. But the -c flag is
            supposed to show the current frequency for each clock type.
            -g would do the same, but just for SCLK.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New Roman&quot;">Kent<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="mso-fareast-font-family:&quot;Times New
                    Roman&quot;">From:</span></b><span style="mso-fareast-font-family:&quot;Times New
                  Roman&quot;"> Tuikov, Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>
                  <br>
                  <b>Sent:</b> Tuesday, October 19, 2021 12:27 AM<br>
                  <b>To:</b> Russell, Kent <a class="moz-txt-link-rfc2396E" href="mailto:Kent.Russell@amd.com">&lt;Kent.Russell@amd.com&gt;</a>;
                  Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
                  Quan, Evan <a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan@amd.com">&lt;Evan.Quan@amd.com&gt;</a>;
                  Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated
                    moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  <b>Cc:</b> Kasiviswanathan, Harish <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 0/5] 0 MHz is not a valid
                  current frequency<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <p class="MsoNormal"><span style="mso-fareast-font-family:&quot;Times New
                Roman&quot;">Kent,<br>
                <br>
                What is the command which fails?<br>
                I can try to duplicate it here.<br>
                <br>
                So far, things I've tried, I cannot make rocm-smi fail.
                Command arguments?<br>
                <br>
                Regards,<br>
                Luben<br>
                <br>
                On 2021-10-18 21:06, Russell, Kent wrote:<o:p></o:p></span></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="msipheader9f8d35bc" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                Official Use Only]</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="mso-fareast-font-family:&quot;Times New
                Roman&quot;">&nbsp;</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New Roman&quot;">The
                * is required for the rocm-smi’s functionality for
                showing what the current clocks are. We had a bug before
                where the * was removed, then the SMI died
                fantastically. Work could be done to try to handle that
                type of situation, but the SMI has a “show current
                clocks” and uses the * to determine which one is active</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New Roman&quot;">&nbsp;</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New Roman&quot;">Kent</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New Roman&quot;">&nbsp;</span><o:p></o:p></p>
            <div style="border:none;border-left:solid blue
              1.5pt;padding:0in 0in 0in 4.0pt">
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal" style="mso-outline-level:1"><b><span style="mso-fareast-font-family:&quot;Times New
                        Roman&quot;">From:</span></b><span style="mso-fareast-font-family:&quot;Times New
                      Roman&quot;"> amd-gfx <a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                      <b>On Behalf Of </b>Russell, Kent<br>
                      <b>Sent:</b> Monday, October 18, 2021 9:05 PM<br>
                      <b>To:</b> Tuikov, Luben <a href="mailto:Luben.Tuikov@amd.com" moz-do-not-send="true">&lt;Luben.Tuikov@amd.com&gt;</a>;
                      Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                      Quan, Evan <a href="mailto:Evan.Quan@amd.com" moz-do-not-send="true">&lt;Evan.Quan@amd.com&gt;</a>;
                      Lazar, Lijo <a href="mailto:Lijo.Lazar@amd.com" moz-do-not-send="true">
                        &lt;Lijo.Lazar@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                      <b>Cc:</b> Kasiviswanathan, Harish <a href="mailto:Harish.Kasiviswanathan@amd.com" moz-do-not-send="true">
                        &lt;Harish.Kasiviswanathan@amd.com&gt;</a><br>
                      <b>Subject:</b> RE: [PATCH 0/5] 0 MHz is not a
                      valid current frequency</span><o:p></o:p></p>
                </div>
              </div>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <p class="msipheader9f8d35bc" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                  Official Use Only]</span><o:p></o:p></p>
              <p class="MsoNormal"><span style="mso-fareast-font-family:&quot;Times New
                  Roman&quot;">&nbsp;</span><o:p></o:p></p>
              <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New
                  Roman&quot;">+Harish, rocm-smi falls under his purview
                  now.</span><o:p></o:p></p>
              <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New
                  Roman&quot;">&nbsp;</span><o:p></o:p></p>
              <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New
                  Roman&quot;">Kent</span><o:p></o:p></p>
              <p class="MsoNormal"><span style="mso-bidi-font-family:&quot;Times New
                  Roman&quot;">&nbsp;</span><o:p></o:p></p>
              <div style="border:none;border-left:solid blue
                1.5pt;padding:0in 0in 0in 4.0pt">
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal" style="mso-outline-level:1"><b><span style="mso-fareast-font-family:&quot;Times New
                          Roman&quot;">From:</span></b><span style="mso-fareast-font-family:&quot;Times New
                        Roman&quot;"> Tuikov, Luben &lt;<a href="mailto:Luben.Tuikov@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Luben.Tuikov@amd.com</a>&gt;
                        <br>
                        <b>Sent:</b> Monday, October 18, 2021 4:30 PM<br>
                        <b>To:</b> Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a>&gt;;
                        Quan, Evan &lt;<a href="mailto:Evan.Quan@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Evan.Quan@amd.com</a>&gt;;
                        Lazar, Lijo &lt;<a href="mailto:Lijo.Lazar@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Lijo.Lazar@amd.com</a>&gt;;
                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                        Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Kent.Russell@amd.com</a>&gt;<br>
                        <b>Subject:</b> Re: [PATCH 0/5] 0 MHz is not a
                        valid current frequency</span><o:p></o:p></p>
                  </div>
                </div>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <div>
                  <p class="MsoNormal"><span style="mso-fareast-font-family:&quot;Times New
                      Roman&quot;">I think Kent is already seen these
                      patches as he did comment on 1/5 patch.<br>
                      <br>
                      The v3 version of the patch, posted last week,
                      removes the asterisk to report the lowest
                      frequency as the current frequency, when the
                      current frequency is 0, i.e. when the block is in
                      low power state. Does the tool rely on the
                      asterisk? If this information is necessary could
                      it not use amdgpu_pm_info?<br>
                      <br>
                      Regards,<br>
                      Luben<br>
                      <br>
                      On 2021-10-18 16:19, Deucher, Alexander wrote:</span><o:p></o:p></p>
                </div>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="mso-fareast-font-family:&quot;Times New
                      Roman&quot;">&nbsp;</span><o:p></o:p></p>
                  <div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;mso-fareast-font-family:&quot;Times
                          New Roman \;color\:black&quot;">We the current
                          behavior (0 for clock) already crashes the
                          tool, so I don't think we can really make
                          things worse.</span><o:p></o:p></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;mso-fareast-font-family:&quot;Times
                          New Roman \;color\:black&quot;">&nbsp;</span><o:p></o:p></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;mso-fareast-font-family:&quot;Times
                          New Roman \;color\:black&quot;">Alex</span><o:p></o:p></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;mso-fareast-font-family:&quot;Times
                          New Roman \;color\:black&quot;">&nbsp;</span><o:p></o:p></p>
                    </div>
                    <div class="MsoNormal" style="text-align:center" align="center"><span style="mso-fareast-font-family:&quot;Times New
                        Roman&quot;">
                        <hr width="98%" size="1" align="center"> </span></div>
                    <div id="divRplyFwdMsg">
                      <p class="MsoNormal" style="mso-outline-level:1"><b><span style="mso-fareast-font-family:&quot;Times
                            New Roman \;color\:black&quot;">From:</span></b><span style="mso-fareast-font-family:&quot;Times New
                          Roman \;color\:black&quot;"> Quan, Evan <a href="mailto:Evan.Quan@amd.com" moz-do-not-send="true">&lt;Evan.Quan@amd.com&gt;</a><br>
                          <b>Sent:</b> Thursday, October 14, 2021 10:25
                          PM<br>
                          <b>To:</b> Lazar, Lijo <a href="mailto:Lijo.Lazar@amd.com" moz-do-not-send="true">&lt;Lijo.Lazar@amd.com&gt;</a>;
                          Tuikov, Luben <a href="mailto:Luben.Tuikov@amd.com" moz-do-not-send="true">&lt;Luben.Tuikov@amd.com&gt;</a>;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                            amd-gfx@lists.freedesktop.org</a> <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                            &lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                          Russell, Kent <a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">
                            &lt;Kent.Russell@amd.com&gt;</a><br>
                          <b>Cc:</b> Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                          <b>Subject:</b> RE: [PATCH 0/5] 0 MHz is not a
                          valid current frequency</span><span style="mso-fareast-font-family:&quot;Times New
                          Roman&quot;"> </span><o:p></o:p></p>
                      <div>
                        <p class="MsoNormal"><span style="mso-fareast-font-family:&quot;Times
                            New Roman&quot;">&nbsp;</span><o:p></o:p></p>
                      </div>
                    </div>
                    <div>
                      <div>
                        <p class="xmsipheadera4477989" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                            Official Use Only]</span><o:p></o:p></p>
                        <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                        <p class="xmsonormal">+Kent who maintains the
                          Rocm tool<o:p></o:p></p>
                        <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                        <div style="border:none;border-left:solid blue
                          1.5pt;padding:0in 0in 0in 4.0pt">
                          <div>
                            <div style="border:none;border-top:solid
                              #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                              <p class="xmsonormal" style="mso-outline-level:1"><b>From:</b>
                                amd-gfx <a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> <b>On Behalf Of </b>Lazar,
                                Lijo<br>
                                <b>Sent:</b> Thursday, October 14, 2021
                                1:07 AM<br>
                                <b>To:</b> Tuikov, Luben <a href="mailto:Luben.Tuikov@amd.com" moz-do-not-send="true">&lt;Luben.Tuikov@amd.com&gt;</a>;
                                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                                <b>Cc:</b> Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                                <b>Subject:</b> Re: [PATCH 0/5] 0 MHz is
                                not a valid current frequency<o:p></o:p></p>
                            </div>
                          </div>
                          <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                          <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                              Official Use Only]</span><o:p></o:p></p>
                          <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                          <div>
                            <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                                Official Use Only]</span><o:p></o:p></p>
                            <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                            <div>
                              <div>
                                <p class="xmsonormal" style="background:white"><span style="color:#212121">&gt;Or maybe
                                    just a list without default hint,
                                    i.e. no asterisk?</span><o:p></o:p></p>
                              </div>
                              <div>
                                <p class="xmsonormal" style="background:white"><span style="color:#212121">&nbsp;</span><o:p></o:p></p>
                              </div>
                              <div>
                                <p class="xmsonormal" style="background:white"><span style="color:#212121">I think this
                                    is also fine meaning we are having
                                    trouble in determining the current
                                    frequency or DPM level. Evan/Alex?
                                    Don't know if this will crash the
                                    tools.</span><o:p></o:p></p>
                              </div>
                              <div id="x_ms-outlook-mobile-signature">
                                <div>
                                  <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                                </div>
                                <p class="xmsonormal">Thanks,<br>
                                  Lijo<o:p></o:p></p>
                              </div>
                              <div class="MsoNormal" style="text-align:center" align="center"><span style="mso-fareast-font-family:&quot;Times New Roman&quot;">
                                  <hr width="98%" size="1" align="center"> </span></div>
                              <div id="x_divRplyFwdMsg">
                                <p class="xmsonormal" style="mso-outline-level:1"><b><span style="color:black">From:</span></b><span style="color:black"> Tuikov, Luben
                                    &lt;<a href="mailto:Luben.Tuikov@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Luben.Tuikov@amd.com</a>&gt;<br>
                                    <b>Sent:</b> Wednesday, October 13,
                                    2021 9:52:09 PM<br>
                                    <b>To:</b> Lazar, Lijo &lt;<a href="mailto:Lijo.Lazar@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Lijo.Lazar@amd.com</a>&gt;;
                                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>
                                    &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                                    <b>Cc:</b> Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a>&gt;<br>
                                    <b>Subject:</b> Re: [PATCH 0/5] 0
                                    MHz is not a valid current frequency</span>
                                  <o:p> </o:p></p>
                                <div>
                                  <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                                </div>
                              </div>
                              <div>
                                <div>
                                  <p class="xmsonormal" style="margin-bottom:12.0pt">On
                                    2021-10-13 00:14, Lazar, Lijo wrote:<br>
                                    &gt;<br>
                                    &gt; On 10/13/2021 8:40 AM, Luben
                                    Tuikov wrote:<br>
                                    &gt;&gt; Some ASIC support low-power
                                    functionality for the whole ASIC or
                                    just<br>
                                    &gt;&gt; an IP block. When in such
                                    low-power mode, some sysfs
                                    interfaces would<br>
                                    &gt;&gt; report a frequency of 0,
                                    e.g.,<br>
                                    &gt;&gt;<br>
                                    &gt;&gt; $cat
                                    /sys/class/drm/card0/device/pp_dpm_sclk<br>
                                    &gt;&gt; 0: 500Mhz<br>
                                    &gt;&gt; 1: 0Mhz *<br>
                                    &gt;&gt; 2: 2200Mhz<br>
                                    &gt;&gt; $_<br>
                                    &gt;&gt;<br>
                                    &gt;&gt; An operating frequency of 0
                                    MHz doesn't make sense, and this
                                    interface<br>
                                    &gt;&gt; is designed to report only
                                    operating clock frequencies, i.e.
                                    non-zero,<br>
                                    &gt;&gt; and possibly the current
                                    one.<br>
                                    &gt;&gt;<br>
                                    &gt;&gt; When in this low-power
                                    state, round to the smallest<br>
                                    &gt;&gt; operating frequency, for
                                    this interface, as follows,<br>
                                    &gt;&gt;<br>
                                    &gt; Would rather avoid this -<br>
                                    &gt;<br>
                                    &gt; 1) It is manipulating FW
                                    reported value. If at all there is
                                    an uncaught <br>
                                    &gt; issue in FW reporting of
                                    frequency values, that is masked
                                    here.<br>
                                    &gt; 2) Otherwise, if 0MHz is
                                    described as GFX power gated case,
                                    this <br>
                                    &gt; provides a convenient interface
                                    to check if GFX is power gated.<br>
                                    &gt;<br>
                                    &gt; If seeing a '0' is not
                                    pleasing, consider changing to
                                    something like<br>
                                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;NA&quot; - not available
                                    (frequency cannot be fetched at the
                                    moment).<br>
                                    <br>
                                    There's a ROCm tool which literally
                                    asserts if the values are not
                                    ordered in increasing order. Now
                                    since 0 &lt; 550, but 0 is listed as
                                    the second entry, the tool simply
                                    asserts and crashes.<br>
                                    <br>
                                    It is not clear what you'd rather
                                    see here:<br>
                                    <br>
                                    $cat
                                    /sys/class/drm/card0/device/pp_dpm_sclk<br>
                                    0: 550Mhz<br>
                                    1: N/A *<br>
                                    2: 2200MHz<br>
                                    $_<br>
                                    <br>
                                    Is this what you want to see?
                                    (That'll crash other tools which
                                    expect %uMhz.)<br>
                                    <br>
                                    Or maybe just a list without default
                                    hint, i.e. no asterisk?<br>
                                    <br>
                                    $cat
                                    /sys/class/drm/card0/device/pp_dpm_sclk<br>
                                    0: 550Mhz<br>
                                    1: 2200MHz<br>
                                    $_<br>
                                    <br>
                                    What should the output be?<br>
                                    <br>
                                    We want to avoid showing 0, but
                                    still show numbers.<br>
                                    <br>
                                    Regards,<br>
                                    Luben<br>
                                    <br>
                                    &gt;<br>
                                    &gt; Thanks,<br>
                                    &gt; Lijo<br>
                                    &gt;<br>
                                    &gt;&gt; $cat
                                    /sys/class/drm/card0/device/pp_dpm_sclk<br>
                                    &gt;&gt; 0: 500Mhz *<br>
                                    &gt;&gt; 1: 2200Mhz<br>
                                    &gt;&gt; $_<br>
                                    &gt;&gt;<br>
                                    &gt;&gt; Luben Tuikov (5):<br>
                                    &gt;&gt;&nbsp;&nbsp;&nbsp; drm/amd/pm: Slight
                                    function rename<br>
                                    &gt;&gt;&nbsp;&nbsp;&nbsp; drm/amd/pm: Rename
                                    cur_value to curr_value<br>
                                    &gt;&gt;&nbsp;&nbsp;&nbsp; drm/amd/pm: Rename
                                    freq_values --&gt; freq_value<br>
                                    &gt;&gt;&nbsp;&nbsp;&nbsp; dpm/amd/pm: Sienna: 0
                                    MHz is not a current clock frequency<br>
                                    &gt;&gt;&nbsp;&nbsp;&nbsp; dpm/amd/pm: Navi10: 0
                                    MHz is not a current clock frequency<br>
                                    &gt;&gt;<br>
                                    &gt;&gt;&nbsp;&nbsp;
                                    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp;
                                    | 60 +++++++++------<br>
                                    &gt;&gt;&nbsp;&nbsp;
                                    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp;
                                    | 73 ++++++++++++-------<br>
                                    &gt;&gt;&nbsp;&nbsp; 2 files changed, 86
                                    insertions(+), 47 deletions(-)<br>
                                    &gt;&gt;<o:p></o:p></p>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </blockquote>
                <p class="MsoNormal"><span style="mso-fareast-font-family:&quot;Times New
                    Roman&quot;">&nbsp;</span><o:p></o:p></p>
              </div>
            </div>
          </blockquote>
          <p class="MsoNormal"><span style="mso-fareast-font-family:&quot;Times New
              Roman&quot;"><o:p>&nbsp;</o:p></span></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>
