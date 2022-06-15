Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08BAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 22:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1137710E871;
	Wed, 15 Jun 2022 22:41:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041DA10E871
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 22:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ2I/zCNUcxO9Hj7qJVF2PoStwCTI5KA2eluRQ2NVSd5f80CaA2Z1wcv7s+r1XsDcVxKwbTMJY1fJEGoUZrAXPFUQEm8XaI2lfZAKUlfQheR5zkRkMnWKo3zgHEoJ18QOb08+xTNpFkAkTtzucCdzEEFvd7Kt7GjWtdjQ03JMvyb8Sf7SbxSy0d4+Y7WMrYGYe4P5tNiRA9tVV4SM8EB2YmPu/0XoThAEoNJYA/96Y1Zmd4R9NOPFO2ZMAG7W5sjF/osJprjySu+aNiyurpICKYZJ98yypx3xR7lRxScmCS7Jau2ltRmWVdINx1uX3fqjCzpSfztktg81WmqvRTTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HDFPLERMhSnFrtXZmc+ee1wP+hMSgGcGeG+yJ5TS3I=;
 b=Hiu1+v88wFBMttOsVmvjDcLzxLW7ifM2O30QrIQWAQzm0+x9bJt79hDkO9OVDbZw8Qum4Bq90zJ0Lns81p5jRIsY9kPNeCpPJZHsARfBoFQHM4PGlHIMwLXvvPrUN9eloeeC758pdtwSG+ySINeG+Xq8Oimkf0mTtJ1AD9+VpweJXEnQcbKd6rD+Wbc2rtVMhIqliDZVCUOC0yp/4CbxGVR9+5qLsLgnjldI1ThPh20G62b+mZ5O4N2rkzUPGfTabiB2BIPBA4wBVga/skJ3SHkglahw2YB9mwoQXjwwiRyw42/BLSVOMtaRtzUFodf/oV/SmeaRcmSmnZ9zc6QQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HDFPLERMhSnFrtXZmc+ee1wP+hMSgGcGeG+yJ5TS3I=;
 b=NmDlXxYqpTfdN0m0fjOFUW6a5qxdc4XN7ltLX5IkWn5rY9Llg/q680uv9KCYmGVBwAfRkPiTZF/QKCzG+cuWIdLOsBrYG7WxEi7a9D44/ZZRohm4eltrQ09lSXjyTztI/z9je1KjSsiVmSbWToHTRnvOqUBLfm+uXbUi6WlXqek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 22:41:28 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%6]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 22:41:28 +0000
Message-ID: <63a5f706-6d6e-d30a-ad12-7308d44a6984@amd.com>
Date: Wed, 15 Jun 2022 18:41:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Sider, Graham" <Graham.Sider@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
 <20220613152001.3045911-2-Graham.Sider@amd.com>
 <453d57bf-e1b1-9dcb-9022-21444d2c64a8@amd.com>
 <DM6PR12MB30675F77909B21063CD01B8A8AAD9@DM6PR12MB3067.namprd12.prod.outlook.com>
 <26836141-d84a-363e-32c8-bd65dc8cdd22@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <26836141-d84a-363e-32c8-bd65dc8cdd22@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:208:e8::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94902453-3d25-436e-8e4a-08da4f202f6f
X-MS-TrafficTypeDiagnostic: DS7PR12MB6071:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6071F357AD848E5A2EC4BECBE6AD9@DS7PR12MB6071.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IckTE8SH2zQS1tv+Idoliykv6emL/Jk0Nm28TBKIe+zMSWeO+Q6D4HHlwcjuc/C7bvwL7lJpunwbT4CEcc/RGunzXsG+AGfjDDwcueVaAHlzYUMle/+jVGy+DWFza4tkoBRHmekazM0pleplN4sCkCnvbiWAR+3g4V/K0A/9QMZB0in2PmjFEubRVNwhvBWtklhM//3UinQDxau0U/7aZDiK7lG5F+D04c6yoC5CSv5s2WwsdJFYdK9ln/gpT8Ar2VBUFrmtbonnkoFSt/XmohRjPd+tfOhb+VRESgzSK7tj9aN+rAFT7dcW0Bi1VbdmcuEmvcg920crmBok/N+WzwbXQQMgXTkPf0lOrH8f/fxjMyK1XWKiobACN+Zc5kfkjJ0EfyN4nsCWCZIwqvo0eem0rGYjElAvV5A3WWcc0wu9XPYftN0QU1B2UB6pi1yGH2rJMW/w+Tk7IPm9Kc7qRmxHnjPwD6tf7yq86L2M+AarBF3eKFQMVHSZ2vkeBj9p2loMCwYvISPOz5CoV4e1rGj2hq3P+Qd7A4FUS+xLoRYyOSTblp8e1mP1oSKiTZq/UYuYnJECCdwM2WEQmpN9qQKkMR+bO/GfITp/Snp0Tvzocm3H0zKsopUTuHTMydwTy2ETuB/lOX+NQywgaB5rAyl1Dj+hzAVCXF2yHkNpsx47vZCvPNhGOoagepnvotgHR7kpJ6XKCjqm04E6rgWLSXwezKvg5UBv45f67N8A6+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(66556008)(8676002)(4326008)(66946007)(66476007)(508600001)(6512007)(316002)(8936002)(2616005)(6486002)(26005)(38100700002)(53546011)(6506007)(31696002)(66574015)(83380400001)(36756003)(2906002)(30864003)(186003)(31686004)(5660300002)(54906003)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRzdmVDdnFEOWdwREVnOXFlUnRuWW0yRkUxZUtvQ0lqU1BBY0oyMVRVQWli?=
 =?utf-8?B?TEZtdGZyS1Bka1h1YjZpTEFVVGdDSjdUdjZ4cFFLSW9xR3EwK2FncG9GTG5t?=
 =?utf-8?B?bWpkeUJtMnkycXB4cGQ0VmR6bDZFQVY4NnFNdnBxMS9UU2JIbFNwUmMwVmVD?=
 =?utf-8?B?Y2dvZithUDljdWVXbjVrK1RQZE50T0FobWdqTnVoaTUzbTZEK3ZEQmRiU1NF?=
 =?utf-8?B?S2V3UTBFTHlNVSs2cnVOYXhUTC8zR3drTVhxZzFmUDdMeUhDSWtOVUMxNkNu?=
 =?utf-8?B?dkRPZjVWN0dqNCtKc1NZM0ZJNVg1M1p5aGVuSEhDQkRLc0pQUHd1SjZ5RHZU?=
 =?utf-8?B?OEpvbjVlbUs0d281Z01CS09xTlZMQ29Nai9yWGhINW5xQWxubGVOTHcrbDNy?=
 =?utf-8?B?ZlI0dUN2cVEyL3FWR0x2SGlLTXhScXJjZ2JNUlN4UVBTbGRVZWQ3cmw5QXlo?=
 =?utf-8?B?YVNLc0Y2Y0YzS3ltYVJyZVQwWUcvcnVYczFxUE9PaEV3TDJ6aEdkQlBQM2d6?=
 =?utf-8?B?L3kzTUwxbXpJZXNIaWhkRVduOE01eFNoSWtBTGpqYXdsL2RERVRUUE9wdnBu?=
 =?utf-8?B?eXZ3YlNrcU9pMTRLYWN1SzdyRndiMzNqYTUxWXc3UWQreE0rODFpMkFTd2s3?=
 =?utf-8?B?QVYvWUZJbVc2S2V2ZklOK3E1aGlEekF6SmtvdkdXL0FCdGwzeEd1VVJNbUdy?=
 =?utf-8?B?R0dXckcvcXpPWk9JVnFaYytiOFBUSmcxalhheXpzcWU4WEtXMGdTdVNsZk9E?=
 =?utf-8?B?akFpcitGVUNGM21uc2JDeTN6TjlNd1VkMlZQdjVyUjZHV1hTN3o0MkhKUDZi?=
 =?utf-8?B?WmdPYkFLWGFSQTBxdXBiY1V3TDIrSG50MDNMeWN0WkhMUGM5ckx4VzE2SjVv?=
 =?utf-8?B?N1BDNm1ReWJ4VmdJaXRGR1NlaWdJT1A2aFU1a0FCRDFlQnhQMDNPeW8vZHdV?=
 =?utf-8?B?Z0lnakNvMURnam85c2tmRmRoVTZiNFBYUnk3RG1QRUNTU3loVE1QYWZTWnpq?=
 =?utf-8?B?UFhxb3ZOdW1zcDB1MzA4SDRLdVhyclVLa2hwelNjem9hblZWd0gxdXQ2V3F6?=
 =?utf-8?B?NERCaG1wdzd1N09jVkc1ZnhZTkZMc05sRnZxaU9CNVliYVVQYUxXYnBCcVJC?=
 =?utf-8?B?VnlIVTVydEJRUnV3TlEwa3VRS2RZM3lqQ3ExMjBPcjBkeFZ4NDZNYmNBOHJW?=
 =?utf-8?B?MUVMMno3RVNhN1hSaEFpdXYrUmlBMkg0a2dRNDRzaklWUStvN3NBWDRGMnZq?=
 =?utf-8?B?cnR0Q0NuS0ZYc0Roc0hvREJsNVU5SjNVQVJEb3cxNU80MXh2WWVtSXN4SDFo?=
 =?utf-8?B?azVncmRnbnhQYmpFb0ZYNUxIdkpZRUhKampic2ZoOG56VUMrN1VxRmIzSnZO?=
 =?utf-8?B?NEp5Tk42ZkVHNHZqdE10ZHVaaUJta25vNjN1R0owSkpjN0NYQk9KSmxBZ3Jw?=
 =?utf-8?B?TW1yRjVKdWo3SUZKTVdKY0xhelg4bDFvQlN0SHR6aFgvUVRjNTZ3SmRNcUsx?=
 =?utf-8?B?K2Nnd3BYMGIwTmNtenFzRWVYZ2UvRTFBNjREMlB5SGpzNktLSjYyMHI3eU9D?=
 =?utf-8?B?VXlYNUFQQk80VUJvNFlWR1hQK3A1Q0lITU00N0wzcnE5bEt2MzNEL0lsOXVr?=
 =?utf-8?B?dlVKRjdxWjhXUG0rTGRuV1pEQW5jcVVBc0laMnFCaHRvdVJrcUFQY3YxckRB?=
 =?utf-8?B?b0hldlhEbkdrQlJJbnlVaGRZaWIxM0dwK2JRM0ZsYStFTWZjT25QZXJPNytY?=
 =?utf-8?B?T25mRHRxNlFCRGU3L1B3SENFYkxmWlgxcklYQTFlS2xoT1N1TXR0N3dibzh3?=
 =?utf-8?B?ckF6RlVlbmNubHY4K3NvZEhxZzR1UDJnaThqY2RmazJlS1JPaHJCcVovcFhu?=
 =?utf-8?B?V3ZuSHZvMzNNbHBUL09MekxYQ1BaYkV1bUVlTFRNdXZHaHZYNW9qWGtMUVBT?=
 =?utf-8?B?dXgwVEc2RmFpWHRXT1hyTnpGSk4yL1RuTFZrTWtSNTVIWHlFcGs3bTRaUzd3?=
 =?utf-8?B?akhtMmhEL0IwMU9LMkNEUGpBWjd5TTZ1Mm9Nb3kwaG5ZSmluMmptcnNsM2Iw?=
 =?utf-8?B?cjgwRThrdHJZRFRDNTNEdjcvd0tYbVpPMFhCSjNVbVh2SjRvd1YwaFdFUDRG?=
 =?utf-8?B?Zm1nSDlReU5iRUk5NUh2UVlIU0VNNWR2ZXpYOXJTN0J2L2JKVzFiME01TEE1?=
 =?utf-8?B?VmpwRjROTEpPZ1R2OHhtK1U2dnhDaDJEaHcxbG83dlhBNWJ1R2szU2NNY3c1?=
 =?utf-8?B?b05HTGhacGlUbUI4WG1PYXhySFZYTmhOK0M4Z1oyVW82SlFxZzRQUjExQ0NR?=
 =?utf-8?B?c3ZUNk15a0d3Yjh5VU9pYWkrY1ZsOXQvNmtGb2JEcUw3RHE2WTJudz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94902453-3d25-436e-8e4a-08da4f202f6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 22:41:28.1453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxC2EMaNUeqC3Me4dDLDi+xkmJ8nAcA3cnHbVnkevy7lduDKK0l9fLa35OAp9fN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-06-15 10:06, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:26836141-d84a-363e-32c8-bd65dc8cdd22@amd.com">Am
      15.06.22 um 15:17 schrieb Sider, Graham:
      <br>
      <blockquote type="cite">[AMD Official Use Only - General]
        <br>
        <br>
        <blockquote type="cite">-----Original Message-----
          <br>
          From: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
          <br>
          Sent: Wednesday, June 15, 2022 3:29 AM
          <br>
          To: Sider, Graham <a class="moz-txt-link-rfc2396E" href="mailto:Graham.Sider@amd.com">&lt;Graham.Sider@amd.com&gt;</a>; amd-
          <br>
          <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org">gfx@lists.freedesktop.org</a>
          <br>
          Cc: Joshi, Mukul <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>; Kuehling, Felix
          <br>
          <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Yang, Philip
          <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
          <br>
          Subject: Re: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode
          queue
          <br>
          oversubscription
          <br>
          <br>
          <br>
          <br>
          Am 13.06.22 um 17:20 schrieb Graham Sider:
          <br>
          <blockquote type="cite">Starting with GFX11, MES requires wptr
            BOs to be GTT allocated/mapped
            <br>
            to GART for usermode queues in order to support
            oversubscription. In
            <br>
            the case that work is submitted to an unmapped queue, MES
            must have a
            <br>
            GART wptr address to determine whether the queue should be
            mapped.
            <br>
            <br>
            This change is accompanied with changes in MES and is
            applicable for
            <br>
            MES_VERSION &gt;= 3.
            <br>
            <br>
            v2:
            <br>
            - Update MES_VERSION check from 2 to 3.
            <br>
            v3:
            <br>
            - Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
            <br>
            - Move wptr_bo refcount increment to
            <br>
          </blockquote>
          amdgpu_amdkfd_map_gtt_bo_to_gart
          <br>
          <blockquote type="cite">- Remove list_del_init from
            amdgpu_amdkfd_map_gtt_bo_to_gart
            <br>
            - Cleanup/fix create_queue wptr_bo error handling
            <br>
            <br>
            Signed-off-by: Graham Sider <a class="moz-txt-link-rfc2396E" href="mailto:Graham.Sider@amd.com">&lt;Graham.Sider@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
            <br>
            &nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; | 49
            <br>
          </blockquote>
          +++++++++++++++++++
          <br>
          <blockquote type="cite">&nbsp;&nbsp;
            drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 37
            +++++++++++++-
            <br>
            &nbsp;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c |&nbsp; 9 +++-
            <br>
            &nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c&nbsp; |&nbsp; 2 +
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++
            <br>
            &nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp; | 17
            +++++--
            <br>
            &nbsp;&nbsp; 7 files changed, 110 insertions(+), 8 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
            index 429b16ba10bf..dba26d1e3be9 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
            @@ -301,6 +301,7 @@ int
            <br>
          </blockquote>
          amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device
          <br>
          *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kgd_mem *mem, void
            **kptr, uint64_t *size);
            <br>
            &nbsp;&nbsp; void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kgd_mem *mem);
            <br>
            +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device
            *adev,
            <br>
            +struct amdgpu_bo *bo);
            <br>
            <br>
            &nbsp;&nbsp; int amdgpu_amdkfd_gpuvm_restore_process_bos(void
            *process_info,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **ef);
            <br>
            diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
            <br>
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
            <br>
            index efab923056f4..888d08128a94 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
            <br>
            @@ -2030,6 +2030,55 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
            <br>
            &nbsp;&nbsp; }
            <br>
            <br>
            +/**
            <br>
            + * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and
            <br>
          </blockquote>
          increment
          <br>
          <blockquote type="cite">+reference count
            <br>
            + * @adev: Device to which allocated BO belongs
            <br>
            + * @bo: Buffer object to be mapped
            <br>
            + *
            <br>
            + * Before return, bo reference count is incremented. To
            release the
            <br>
            +reference and unpin/
            <br>
            + * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
            <br>
            + */
            <br>
            +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device
            *adev,
            <br>
            +struct amdgpu_bo *bo) {
            <br>
            +&nbsp;&nbsp;&nbsp; int ret;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; ret = amdgpu_bo_reserve(bo, true);
            <br>
            +&nbsp;&nbsp;&nbsp; if (ret) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to reserve bo. ret %d\n&quot;, ret);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_reserve_bo_failed;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
            <br>
            +&nbsp;&nbsp;&nbsp; if (ret) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to pin bo. ret %d\n&quot;, ret);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_pin_bo_failed;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
          </blockquote>
          <br>
          Oh! Is that something we do for every MQD? When yes that here
          is pretty
          <br>
          much a NAK.
          <br>
          <br>
          We can't do this or create a trivial deny of service attack
          against the kernel
          <br>
          driver.
          <br>
          <br>
          Regards,
          <br>
          Christian.
          <br>
          <br>
        </blockquote>
        Hi Christian, could you elaborate on this? Right now this is
        only being used to pin the queue wptr BO.
        <br>
      </blockquote>
      <br>
      Well is this wptr BO per process, per queue or global?
      <br>
      <br>
      amdgpu_bo_pin() is only allowed if we pin global resources,
      otherwise I have to reject that.
      <br>
    </blockquote>
    <p>wptr BO is per queue, allocated as queue structure, 1 page size
      on system memory.</p>
    <p> KFD limit number of queues globally, max_queues = 127; /* HWS
      limit */, so this will pin max 508KB and take max 127 GART page
      mapping.</p>
    <p>wptr is updated by app and read by HWS, if we don't pin wptr, we
      have to evict queue when wptr bo is moved on system memory, then
      update GART mapping and restore queue.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:26836141-d84a-363e-32c8-bd65dc8cdd22@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Best,
        <br>
        Graham
        <br>
        <br>
        <blockquote type="cite">
          <blockquote type="cite">+
            <br>
            +&nbsp;&nbsp;&nbsp; ret = amdgpu_ttm_alloc_gart(&amp;bo-&gt;tbo);
            <br>
            +&nbsp;&nbsp;&nbsp; if (ret) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to bind bo to GART. ret %d\n&quot;, ret);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_map_bo_gart_failed;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_remove_eviction_fence(
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo,
            bo-&gt;kfd_bo-&gt;process_info-&gt;eviction_fence);
            <br>
            +&nbsp;&nbsp;&nbsp;
            list_del_init(&amp;bo-&gt;kfd_bo-&gt;validate_list.head);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; bo = amdgpu_bo_ref(bo);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +
            <br>
            +err_map_bo_gart_failed:
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(bo);
            <br>
            +err_pin_bo_failed:
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);
            <br>
            +err_reserve_bo_failed:
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return ret;
            <br>
            +}
            <br>
            +
            <br>
            &nbsp;&nbsp; int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kgd_mem *mem, void
            **kptr, uint64_t *size)
            <br>
            &nbsp;&nbsp; {
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
            <br>
            b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
            <br>
            index e9766e165c38..1789ed8b79f5 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
            <br>
            @@ -289,6 +289,7 @@ static int kfd_ioctl_create_queue(struct
            file *filep,
            <br>
          </blockquote>
          struct kfd_process *p,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties q_properties;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t doorbell_offset_in_process = 0;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo = NULL;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;q_properties, 0, sizeof(struct
            queue_properties));
            <br>
            <br>
            @@ -316,12 +317,41 @@ static int
            kfd_ioctl_create_queue(struct file
            <br>
          </blockquote>
          *filep, struct kfd_process *p,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_bind_process;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            +&nbsp;&nbsp;&nbsp; /* Starting with GFX11, wptr BOs must be mapped to GART
            for MES
            <br>
          </blockquote>
          to determine work
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp; * on unmapped queues for
            usermode queue oversubscription (no
            <br>
          </blockquote>
          aggregated doorbell)
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; if (dev-&gt;shared_resources.enable_mes &amp;&amp;
            (dev-&gt;adev-
            <br>
            mes.sched_version &amp; 0xff) &gt;= 3) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mapping *wptr_mapping;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *wptr_vm;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_vm = drm_priv_to_vm(pdd-&gt;drm_priv);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = amdgpu_bo_reserve(wptr_vm-&gt;root.bo,
            false);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_mapping = amdgpu_vm_bo_lookup_mapping(
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_vm, args-&gt;write_pointer_address
            &gt;&gt;
            <br>
          </blockquote>
          PAGE_SHIFT);
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            amdgpu_bo_unreserve(wptr_vm-&gt;root.bo);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!wptr_mapping) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to lookup wptr bo\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = -EINVAL;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_bo = wptr_mapping-&gt;bo_va-&gt;base.bo;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =
            amdgpu_amdkfd_map_gtt_bo_to_gart(dev-&gt;adev,
            <br>
          </blockquote>
          wptr_bo);
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to map wptr bo to GART\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Creating queue for PASID 0x%x on gpu
            0x%x\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;pasid,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;id);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp; err = pqm_create_queue(&amp;p-&gt;pqm, dev, filep,
            &amp;q_properties,
            <br>
          </blockquote>
          &amp;queue_id, NULL, NULL, NULL,
          <br>
          <blockquote type="cite">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &amp;doorbell_offset_in_process);
            <br>
            +&nbsp;&nbsp;&nbsp; err = pqm_create_queue(&amp;p-&gt;pqm, dev, filep,
            &amp;q_properties,
            <br>
          </blockquote>
          &amp;queue_id, wptr_bo,
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, NULL,
            &amp;doorbell_offset_in_process);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err != 0)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;
            <br>
            <br>
            @@ -354,6 +384,9 @@ static int kfd_ioctl_create_queue(struct
            file *filep,
            <br>
          </blockquote>
          struct kfd_process *p,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            <br>
            &nbsp;&nbsp; err_create_queue:
            <br>
            +&nbsp;&nbsp;&nbsp; if (wptr_bo)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, wptr_bo);
            <br>
            +err_wptr_map_gart:
            <br>
            &nbsp;&nbsp; err_bind_process:
            <br>
            &nbsp;&nbsp; err_pdd:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mutex);
            <br>
            diff --git
            a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            index b39d89c52887..d8de2fbdfc7d 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            <br>
            @@ -208,6 +208,7 @@ static int add_queue_mes(struct
            <br>
          </blockquote>
          device_queue_manager *dqm, struct queue *q,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd
            = qpd_to_pdd(qpd);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mes_add_queue_input queue_input;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, queue_type;
            <br>
            +&nbsp;&nbsp;&nbsp; uint64_t wptr_addr_off;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dqm-&gt;is_hws_hang)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIO;
            <br>
            @@ -227,7 +228,13 @@ static int add_queue_mes(struct
            <br>
          </blockquote>
          device_queue_manager *dqm, struct queue *q,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.doorbell_offset =
            q-&gt;properties.doorbell_off;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.mqd_addr = q-&gt;gart_mqd_addr;
            <br>
            -&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =
            (uint64_t)q-&gt;properties.write_ptr;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (q-&gt;wptr_bo) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_addr_off =
            (uint64_t)q-&gt;properties.write_ptr -
            <br>
          </blockquote>
          (uint64_t)q-&gt;wptr_bo-&gt;kfd_bo-&gt;va;
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =
            ((uint64_t)q-&gt;wptr_bo-
            <br>
            tbo.resource-&gt;start &lt;&lt; PAGE_SHIFT) + wptr_addr_off;
            <br>
            +&nbsp;&nbsp;&nbsp; } else
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr = (uint64_t)q-
            <br>
            properties.write_ptr;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.paging = false;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.tba_addr = qpd-&gt;tba_addr;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.tma_addr = qpd-&gt;tma_addr; diff --git
            <br>
            a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
            <br>
            b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
            <br>
            index f1654b4da856..35e74bdd81da 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
            <br>
            @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct
            mqd_manager
            <br>
          </blockquote>
          *mm, void *mqd,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_base_hi =
            upper_32_bits(q-&gt;queue_address &gt;&gt;
            <br>
          </blockquote>
          8);
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            m-&gt;sdmax_rlcx_rb_rptr_addr_lo =
            lower_32_bits((uint64_t)q-
            <br>
            read_ptr);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_addr_hi =
            <br>
            upper_32_bits((uint64_t)q-&gt;read_ptr);
            <br>
            +&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_wptr_poll_addr_lo =
            lower_32_bits((uint64_t)q-
            <br>
            write_ptr);
            <br>
            +&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_wptr_poll_addr_hi =
            <br>
            +upper_32_bits((uint64_t)q-&gt;write_ptr);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset =
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;doorbell_off &lt;&lt;
            <br>
          </blockquote>
          SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
          <br>
          <blockquote type="cite">diff --git
            a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            <br>
            b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            <br>
            index a5d3963537d7..dcddee0d6f06 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            <br>
            @@ -639,6 +639,8 @@ struct queue {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_bo;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gang_ctx_gpu_addr;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo;
            <br>
            &nbsp;&nbsp; };
            <br>
            <br>
            &nbsp;&nbsp; enum KFD_MQD_TYPE {
            <br>
            @@ -1404,6 +1406,7 @@ int pqm_create_queue(struct
            <br>
          </blockquote>
          process_queue_manager *pqm,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file *f,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *properties,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *qid,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd_criu_queue_priv_data
            *q_data,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *restore_mqd,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *restore_ctl_stack, diff --git
            <br>
            a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
            <br>
            b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
            <br>
            index f99e09dc43ea..3a17c1ebc527 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
            <br>
            @@ -190,7 +190,8 @@ void pqm_uninit(struct
            process_queue_manager
            <br>
          </blockquote>
          *pqm)
          <br>
          <blockquote type="cite">&nbsp;&nbsp; static int init_user_queue(struct
            process_queue_manager *pqm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev, struct queue **q,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *q_properties,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file *f, unsigned int qid)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file *f, struct amdgpu_bo *wptr_bo,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int qid)
            <br>
            &nbsp;&nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;
            <br>
            <br>
            @@ -221,6 +222,7 @@ static int init_user_queue(struct
            <br>
          </blockquote>
          process_queue_manager *pqm,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto cleanup;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset((*q)-&gt;gang_ctx_cpu_ptr, 0,
            <br>
          </blockquote>
          AMDGPU_MES_GANG_CTX_SIZE);
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*q)-&gt;wptr_bo = wptr_bo;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;PQM After init queue&quot;);
            <br>
            @@ -237,6 +239,7 @@ int pqm_create_queue(struct
            <br>
          </blockquote>
          process_queue_manager *pqm,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file *f,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *properties,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *qid,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd_criu_queue_priv_data
            *q_data,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *restore_mqd,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *restore_ctl_stack, @@ -299,7
            +302,7
            <br>
          </blockquote>
          @@ int
          <br>
          <blockquote type="cite">pqm_create_queue(struct
            process_queue_manager *pqm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * allocate_sdma_queue() in create_queue() has
            the
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * corresponding check logic.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = init_user_queue(pqm, dev, &amp;q,
            properties, f, *qid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = init_user_queue(pqm, dev, &amp;q,
            properties, f,
            <br>
          </blockquote>
          wptr_bo,
          <br>
          <blockquote type="cite">+*qid);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval != 0)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn-&gt;q = q;
            <br>
            @@ -320,7 +323,7 @@ int pqm_create_queue(struct
            <br>
          </blockquote>
          process_queue_manager *pqm,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = init_user_queue(pqm, dev, &amp;q,
            properties, f, *qid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = init_user_queue(pqm, dev, &amp;q,
            properties, f,
            <br>
          </blockquote>
          wptr_bo,
          <br>
          <blockquote type="cite">+*qid);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval != 0)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn-&gt;q = q;
            <br>
            @@ -457,9 +460,13 @@ int pqm_destroy_queue(struct
            <br>
          </blockquote>
          process_queue_manager *pqm, unsigned int qid)
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;qpd.num_gws =
            0;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;shared_resources.enable_mes)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;shared_resources.enable_mes) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn-&gt;q-&gt;gang_ctx_bo);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pqn-&gt;q-&gt;wptr_bo)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-
            <br>
            adev, pqn-&gt;q-&gt;wptr_bo);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uninit_queue(pqn-&gt;q);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            @@ -900,7 +907,7 @@ int kfd_criu_restore_queue(struct
            kfd_process *p,
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print_queue_properties(&amp;qp);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp; ret = pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev,
            NULL, &amp;qp,
            <br>
          </blockquote>
          &amp;queue_id, q_data, mqd, ctl_stack,
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp; ret =
            pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev, NULL, &amp;qp,
            <br>
          </blockquote>
          &amp;queue_id,
          <br>
          <blockquote type="cite">+NULL, q_data, mqd, ctl_stack,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to create new queue err:%d\n&quot;,
            ret);
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
