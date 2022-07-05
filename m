Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C463C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 19:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10EE93CCA;
	Tue,  5 Jul 2022 19:53:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B685793D31
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 19:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq2eFzq9p1KE85yOsELZ00EZqyDj7qJU9LVlFB5BFWjvtpWHN99NorRB2GgjYnmouXD/B6PalwIjNc2hOpIIpw8dG2/RXWDvBSeE1qPe5szxH23bRu+w43FEl4Y9DUeyaWf5yQlIgKakz2+CQQeetByAZvQeH/3O7l3e7/18qd7UZQ+bdKrTL03Tq/ibShwggcm1pb+qW5jZ2a7OnAByHIuZslrurXbaT2zGykabnYs9yiDH5UkeluBFkmbO35aaqpgYnnmNK8cYtO5UsrseASqSQRQYgtKJKjQ5L42IPbMhCDq3HTPvd7UypTJ3Dx6QIIPzDb4Jnm7IiwLnmUXYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hlIrQhw/+z5P+qgKJmgelrHl55WNGNc8kaKXgHBRak=;
 b=AYXeOwlj+eg+sVIiZj9YA9bLhfTg/aZUbUfY1pJwdcJHpepuWTGIpKzO3kGpjDAoUWE5LDq+Rx5BJnR4bnoi3oiIuzpjMo4IoEZzNC478Q8tZfgzAf396ghWOQCvmgbvPanX70mKz+i4ZqonG7OQZbwNOYkOC/9wr6K2eKJ5BOj3X2Oefi/vOZNgWouLbPbKd9PoajSw7TIJFd7Jfap8jyPEjjHojeaBDoVBHovVn8Tz4G2JDPMqAnN9mm6oYVHS3xA3SXYVUoW9rvcKFOZTK9YVDflYrbRz065D6heY07qVKK8EGM3ZILKdPbJA59vowpV1XncavqrJF8yIdxYXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hlIrQhw/+z5P+qgKJmgelrHl55WNGNc8kaKXgHBRak=;
 b=OmK4uDa7BbkSXJkzIEwVGcsQJhoL4KOvzYxT4r9PNyeQv8VfKt732LezUKvk0iFO/7wBEnsHj9evpPjpBINL7vI/YBxMtCkctT1HBFWq7Mi7+8DKiU7Liw7k586dupi+A9+KGFvj5GNSyPDxmbzAbdu86evh+TTaFN17cCdxwP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BN8PR12MB2930.namprd12.prod.outlook.com (2603:10b6:408:69::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 19:53:14 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595%5]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 19:53:14 +0000
Message-ID: <137353cc-ce2d-433a-ef82-bb7ac75fd1c7@amd.com>
Date: Tue, 5 Jul 2022 15:53:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdkfd: Remove queue sysfs and doorbell after
 unmapping
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip Yang <Philip.Yang@amd.com>
References: <20220611010334.23401-1-Philip.Yang@amd.com>
 <2f71d9b5-59aa-45cb-0245-7dc139f108b1@amd.com>
 <2a06bc46-1b6f-c3c3-a842-d49ea4980391@amd.com>
 <f330f4bc-427d-c2de-fe14-745569e9e4de@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <f330f4bc-427d-c2de-fe14-745569e9e4de@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:208:32a::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddc2a718-5d0a-4e70-8d5d-08da5ebfff23
X-MS-TrafficTypeDiagnostic: BN8PR12MB2930:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6qb4vWzI9VPBc6H3WWqCYTlj/f0moOKQw4h0ucReiCOrABFRARn5GDKrtUeYyohdHYNoRnvQFpn74gnTe0dw/u6en8fWk1PU5baSd5O0/c9CsCbcCJOlKvd7yszE+bBb2w071yck2vYdPPDzrJZPYvNP8ACmOSeZO0jDrr+6im4hUbDrNoXKcEtuD2H/D1PaQmYG1lOZKNsM0lc0yPQ14j44xilKo0mqG6HWWsLrBEx1hpWo4gLEnD5ED9j8vOFv7nJ7SdF3ozmyx26a5s5FPVwiHl58eBkJKY6YEKMS0XV9rymI0G9wwyjLm9HcsFYCrBX/zYBFiXcWAU7R5pVStcCJtm2yWUp/4iN0h6GRR6ufEi8WvGkPaikLt0Odpt6qhH2SfQaZ9LMH3uisCofZ5NrlHrtDzHyvPXsr/ELdWqODT05VYrQMZIdFck0uR/KUHUykvbs7t01r8IA/Oo6J+aACu/9DhR3sGkg7P83LTCDDOcB606/G30xOoYjM8Kxqy1rGkbsIFM3ZLCEeyZFRTrDovrvN1WIA+Ak4sWAZVMxoRhEiSfHXxUPWIMsl8L5B07mzz3BOWMKacmhzSHZi+gDY1H16ehNj71Ore4/Enz1hPilXeocA6PueyCVal8EBGVYN5KDXEiptQ8t2NbOsC5GJPFud5EUMN1HuKWiy2BOjpAVkrx7dMVlwW68skgHT1JE6Tc0LzJCENkELCWuFR8/d3RrNtNogiREo3rvlerELovWC3R3Xi9ln0AxnzVb1aRDMmIKrL7qWff8XCcTXj1Ru/ZPpFMRzzRvYU+txGFUuECLNqz1bWFrDGtdGlkoLo5kONpbB67pPsF+S8fPAfWTA9RhZcUZkjODgmuuEi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(8676002)(66946007)(66556008)(66476007)(2906002)(31696002)(38100700002)(5660300002)(8936002)(41300700001)(83380400001)(26005)(53546011)(2616005)(6512007)(186003)(6506007)(316002)(110136005)(6636002)(6486002)(478600001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEtIczNNeERNYTByOW5Od04rODg4N0MyNlJMdDJ6S3hKOWRyMk45Z3dkcEdm?=
 =?utf-8?B?WlBCTWt0L2ptSkR3U1V3NkZRRWRPWGlQcEtPQUVhem9UcnVpZ0FOYmlNRmZ3?=
 =?utf-8?B?U2M2VzUwbklSdjZVdmtLYkJSaEh2OEZkRXlhaG43aHJNTjJ5ak9xRG9FNzh2?=
 =?utf-8?B?aDMrYmROOC9XSktKQ0YvK2dQdGFnRmk4QjZnTHV6aG5Td1Exc0pyL09MMjNU?=
 =?utf-8?B?TVA5dlVRMWZvc1Z2YUJocVJseGRBMUFsZjJzODBCeXI3M2hpTUx0b3pKZTZ2?=
 =?utf-8?B?NXlsNmsrdHp6Qm1yeTZGT2NJVnBVUUMzNUlIS0s2RjRFMCtxZlpkZHBaNDB3?=
 =?utf-8?B?Z25OdkFNSURncmtjckRRVUM4VDdENFBxY2JpdVFlVzEzc3NaWWRoYWIyd3Qy?=
 =?utf-8?B?ZE51NmlWcDZ3bVB6Z1o1OWx3YUg2eVZQMDh6bkZBY1dYMDE3bURJTFk2OU5o?=
 =?utf-8?B?WWdCMjNER01HMTd3d0pWb2JvWTlEUG5CV2hXZ0hVa2k0Tk5RaHZPUGltZmJn?=
 =?utf-8?B?VWVwRTNaSURRY1gvTmxzUk8zOTEzMmZjaVVpMXVJam4vM3hEUnFQYlFvWGtV?=
 =?utf-8?B?VFQ3TUozMFZYV1pvZXlJb0xpQWJhSHl5WW56U2NjZlFvOU9BT2F3NjAxRDhI?=
 =?utf-8?B?RFVaMm1LbDkvYjJDai9rOGJTcUJjcWNxSzdWUzlMMUdJU2hrckNFL1E4UTNx?=
 =?utf-8?B?Rmw5cEhlYUJWVm1vTTJMNnF2OXNoTlhLcVNyMGxFYUdmcGNicC8reFlWclJp?=
 =?utf-8?B?eXY2OHFibGhiVXFhbFVlWEc2Z0xCMEJlQ085VUYvSXBFbWJXWGszMklnSFhI?=
 =?utf-8?B?b1NhRUdlWEJESXJlUU1QVVg3WDdjdTZzd242OENpRHFyS3BFS2tjNjNTOTNz?=
 =?utf-8?B?bldFTllTck9VUURacWJaSnB2OTl5R1ZVZXdPVGY3Q0EzUlNJaUREaG1weTQ5?=
 =?utf-8?B?VWdSYlV0Nm5VUTlidEl6clFzZnJtWndIR1lTRTFsbnhpMk9PT0t5OEE5N0lW?=
 =?utf-8?B?M1ZLKzc5dEJLWCsvWFNqclUxNzhNcm5ZNlA1RjNBTnE2cVV4YTBEZmJaWUpj?=
 =?utf-8?B?bEMxM2RmNzkyOUtRWlllekhoekxLcFBoWFhra09jVnE0c205MWh6a01PcHFw?=
 =?utf-8?B?cWF2ZlJoVU1kL3pQUWJ4UnB6RUt6WUovVDZLRll6d3hzVk1zNEw4a211MjBw?=
 =?utf-8?B?ZDBTWUVubUIxWVZzMmNkZzBaWGdOMUMxMG1ydW5xL2xCYS91OFhoNjB1TndP?=
 =?utf-8?B?eVd3MHlsckNQNFhQckFjZjdHSFh0L2ZjTGVWMDB4WHVmY2xPSGNVN1BaUm5T?=
 =?utf-8?B?dUZ4cWdpRlVzTGJ4eTNrekhKK0pCaktPeFM2OEhhdWp3a0lsbFM1bFN4eVZ4?=
 =?utf-8?B?UVpmem1Ia1huRkhtWEFUWkJJSCszcnFseWVwdTVmWTMvWXcxYlZNMGZhUnBo?=
 =?utf-8?B?aU04K2VWVTRkVFJjNVhQTjVBdjZQTktSWUxpdU9hT3c3dXNlZlJvcjBUV1Vr?=
 =?utf-8?B?M3cwNmZyalRCYThUMkFWZUNveFgzM24wZjVPaWR4dFpIMDJMNzZaWldITkpI?=
 =?utf-8?B?YlFsR3FoakRxR1hheXY3Q3dtUGtHb250cTVHTklQYmdRTzN4VVRZYitUbU8r?=
 =?utf-8?B?M0pteUFEamhPVGRsUG9FdHoyK1d5QkVQRWNOdkJnV1pQczE3UkNGSHNmVW4y?=
 =?utf-8?B?S2xhZUgxb2c2WEl2VzFOYm5VSHE3Z01vNjk5YWpWeFFKY1BQUkxTTmlKcWlm?=
 =?utf-8?B?RHJCdTFPWXJQM2VUT3cwYWJTeVlaYjFtb3gwenBsTytYVmV3RitFQWJSek1K?=
 =?utf-8?B?MUhiVEMxYktvSlhmZlNlWFBwVGd1alZYN21ZcUtSVWxiZEwwME85U0xSNjdt?=
 =?utf-8?B?Q1Uya1Evdk13Q3FvM2xoN2lzbVBpQWYxVVRycUlmTlpHRGt3aXNIT2JnMWts?=
 =?utf-8?B?L2lWNWQwbmRnWkVpaW0vaHAwZXdsY2FmL05rN1JWYTlicjFuZEQvWnBVNjcy?=
 =?utf-8?B?bjVaa0RYczY0OERoUHZNd2ZhcXpaSW5jMXVNVEFiazY1Nm94bzBjS2dlZXlZ?=
 =?utf-8?B?NG9SRHlWcEhmczZRWFVFQ2MrSUhneTFIRHlqUDNwYkhIWk16MVgzb0txekt6?=
 =?utf-8?Q?AAIA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc2a718-5d0a-4e70-8d5d-08da5ebfff23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:53:13.9568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JgzPJMBiE1f19C+ipiwUELzTnrGNCpoQnMC8zxjzwSWjP61GQT6Va3AuWPVJleF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2930
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
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-07-05 15:12, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f330f4bc-427d-c2de-fe14-745569e9e4de@amd.com">On
      2022-07-05 15:02, philip yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2022-07-05 14:48, Felix Kuehling wrote:
        <br>
        <blockquote type="cite">On 2022-06-10 21:03, Philip Yang wrote:
          <br>
          <blockquote type="cite">If destroying/unmapping queue failed,
            application may destroy queue
            <br>
            again, cause below kernel warning backtrace.
            <br>
            <br>
            For outstanding queues, either applications forget to
            destroy or failed
            <br>
            to destroy, kfd_process_notifier_release will remove queue
            sysfs
            <br>
            objects, kfd_process_wq_release will free queue doorbell.
            <br>
            <br>
            &nbsp; refcount_t: underflow; use-after-free.
            <br>
            &nbsp; WARNING: CPU: 7 PID: 3053 at lib/refcount.c:28
            <br>
            &nbsp;&nbsp; Call Trace:
            <br>
            &nbsp;&nbsp;&nbsp; kobject_put+0xd6/0x1a0
            <br>
            &nbsp;&nbsp;&nbsp; kfd_procfs_del_queue+0x27/0x30 [amdgpu]
            <br>
            &nbsp;&nbsp;&nbsp; pqm_destroy_queue+0xeb/0x240 [amdgpu]
            <br>
            &nbsp;&nbsp;&nbsp; kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
            <br>
            &nbsp;&nbsp;&nbsp; kfd_ioctl+0x27d/0x500 [amdgpu]
            <br>
            &nbsp;&nbsp;&nbsp; do_syscall_64+0x35/0x80
            <br>
            <br>
            &nbsp; WARNING: CPU: 2 PID: 3053 at
            drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:400
            <br>
            &nbsp;&nbsp; Call Trace:
            <br>
            &nbsp;&nbsp;&nbsp; deallocate_doorbell.isra.0+0x39/0x40 [amdgpu]
            <br>
            &nbsp;&nbsp;&nbsp; destroy_queue_cpsch+0xb3/0x270 [amdgpu]
            <br>
            &nbsp;&nbsp;&nbsp; pqm_destroy_queue+0x108/0x240 [amdgpu]
            <br>
            &nbsp;&nbsp;&nbsp; kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
            <br>
            &nbsp;&nbsp;&nbsp; kfd_ioctl+0x27d/0x500 [amdgpu]
            <br>
            <br>
            Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c&nbsp; | 4
            ++--
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2
            +-
            <br>
            &nbsp; 2 files changed, 3 insertions(+), 3 deletions(-)
            <br>
            <br>
            diff --git
            a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            index e1797657b04c..1c519514ca1a 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            @@ -1876,8 +1876,6 @@ static int destroy_queue_cpsch(struct
            device_queue_manager *dqm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
            dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; deallocate_doorbell(qpd, q);
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((q-&gt;properties.type == KFD_QUEUE_TYPE_SDMA) ||
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (q-&gt;properties.type ==
            KFD_QUEUE_TYPE_SDMA_XGMI)) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);
            <br>
            @@ -1898,6 +1896,8 @@ static int destroy_queue_cpsch(struct
            device_queue_manager *dqm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; deallocate_doorbell(qpd, q);
            <br>
            +
            <br>
          </blockquote>
          <br>
          I'm not sure what this change is meant to do. I don't see an
          early return in this function, so deallocate_doorbell will
          always be executed either way.
          <br>
        </blockquote>
        <br>
        If app destroy queue deallocate_doorbell, but then unmap queue
        failed, app will destroy queue again when app exit,
        deallocate_doorbell second time will trigger the WARN backtrace.
        <br>
        <br>
      </blockquote>
      I get that. But even with your change, deallocate_doorbell will
      still be executed if the queue unmap fails because there is no
      early return or &quot;goto error&quot;.
      <br>
    </blockquote>
    Yes, that was fixed in patch v2. [PATCH v2 2/2] drm/amdkfd: Free
    queue after unmap queue success<br>
    <blockquote type="cite" cite="mid:f330f4bc-427d-c2de-fe14-745569e9e4de@amd.com">
      <br>
      <br>
      <blockquote type="cite">As queue_count and q-&gt;list is used to
        alloc ring buf in execute_queues_cpsch, so this change causes
        regression on gfx9, I will submit new patch to handle unmap
        failed case with MES and fix those issues.
        <br>
        <br>
      </blockquote>
      I think the intention of the code was to treat HWS in a way that
      does not prevent queue destruction. Basically, there is not point
      reporting HWS errors to the application because the application
      cannot do anything about them anyway. Eventually it will cause a
      GPU reset and the application will be killed. If you look at how
      -ETIME is handled in pqm_destroy_queue, you see that it finishes
      the job regardless.
      <br>
      <br>
      However, this has always been somewhat inconsistent. With MES
      maybe it's getting worse because there may be other error
      conditions we didn't hit before. Are you seeing those backtraces
      on a GPU with MES by any chance?
      <br>
      <br>
    </blockquote>
    <p>Thanks for the info, MES returns other error code than -ETIME, so
      pqm_destroy_queue don't finish the destroy procedure and return
      error code to user space. Seems we just need change MES error
      handle the same way as old HWS, to finish the job regardless.<br>
    </p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:f330f4bc-427d-c2de-fe14-745569e9e4de@amd.com">Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unconditionally decrement this counter, regardless
            of the queue's
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * type
            <br>
            diff --git
            a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
            <br>
            index dc00484ff484..99f2a6412201 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
            <br>
            @@ -419,7 +419,6 @@ int pqm_destroy_queue(struct
            process_queue_manager *pqm, unsigned int qid)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pqn-&gt;q) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_del_queue(pqn-&gt;q);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm = pqn-&gt;q-&gt;device-&gt;dqm;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm-&gt;ops.destroy_queue(dqm,
            &amp;pdd-&gt;qpd, pqn-&gt;q);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {
            <br>
            @@ -439,6 +438,7 @@ int pqm_destroy_queue(struct
            process_queue_manager *pqm, unsigned int qid)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;shared_resources.enable_mes)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn-&gt;q-&gt;gang_ctx_bo);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_del_queue(pqn-&gt;q);
            <br>
          </blockquote>
          <br>
          This part makes sense.
          <br>
          <br>
          Regards,
          <br>
          &nbsp; Felix
          <br>
          <br>
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uninit_queue(pqn-&gt;q);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
