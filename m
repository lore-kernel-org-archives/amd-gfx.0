Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27898C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 15:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDFE6E8B9;
	Thu, 25 Nov 2021 15:22:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9057D6E8B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 15:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8ZtEATmykEGF+cECnk3auhnoBXhpwTCANcpcxy9W7dIapvdXU48ATsjPyyHlgzUCmLoPuEjy2ubPgNyPQmdCWg1XBXabGeQuvO9Qjt7KFyWSqT7sgSgT0PklnRa+mBguGVM9vtpcQKEPt9sOjcr/H1QsbWhBsM/luvXqes1Qw0eMyAnpAoGGH9czIxTYRStfkcIvu4DKpcCj1KISKyS4473JBssLblauEC/PgjqkewYuAdihP/ZLH8zQ6Kkk0V5OIMmT1dyVSaSA9puERSQjQrRZCPmLQjFaus3KeWr76CQ4CsogXsAznByWgYXItPwRQvjiiOsHfd2Ku9oq09d0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvsNajOF2Ymic7+2DiYcDmFApgXq+dclO0qAXBjd5ms=;
 b=chc8FWUpLkVQcEfgz+Uku1n+K6k2wmwBo70obfMEElWYw2GO8hlo/x7T7+9r//nyoBMLKeP7HxhnYljifqD8UVLBAluTXtYCziflF4Bxnn1FRmiw1HwzrhH2aS7rVSszTIUbfY3d1LDov3NCcyl1KHhwgm8+EZOWkNzX/q6RGpELyPDYkThsId11UIGeiXufRdkhr6C7RcNOhakQHOp01jHecNIe5+qrrGoCbzW5B/PzCLlF3suqzIVXNzBr2/a3ITTcMUjvIuP7fcm+NKPoQKfNsFaZnVmiv0M9KjxxjNPcFmVdkbUYZszKSevIVSV86lYMKXepkA633jLyXbDwtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvsNajOF2Ymic7+2DiYcDmFApgXq+dclO0qAXBjd5ms=;
 b=hzvicKY3ZeyM5E8a+HBKj9oCCxs5xAKVfZpsL6tSw+JVQYtH21Ov5xkRYj5JzrCMcd+29pR2Pa+Z6cxUW2x9/+WRBp7BAFhaiErTmilH3OIbHZWGKZF6+/V8ot0iDpNN6t7e7RQuC6W7vN/CuwpuO7r6r2MQm3pDXDEeFlZbqO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.25; Thu, 25 Nov
 2021 15:22:42 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 15:22:42 +0000
Subject: Re: [PATCH v5] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211123192254.21681-1-Philip.Yang@amd.com>
 <3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com>
 <5ec42928-995f-04c6-c7c8-3d2e33744457@amd.com>
 <1d31f11a-9ba5-4973-5875-11ef6e1bcf89@amd.com>
 <a832f0bc-fcb1-4e13-3cf7-c598e96a665b@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <ba64f15e-16f7-014a-e10d-f81602b93294@amd.com>
Date: Thu, 25 Nov 2021 10:22:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <a832f0bc-fcb1-4e13-3cf7-c598e96a665b@gmail.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:208:35::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL0PR02CA0113.namprd02.prod.outlook.com (2603:10b6:208:35::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Thu, 25 Nov 2021 15:22:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df920650-0892-475f-857a-08d9b0276ce5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5054:
X-Microsoft-Antispam-PRVS: <DM4PR12MB505490D768BC04FDF5221AB9E6629@DM4PR12MB5054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bdx8fqjNBZ/ISIMCW0bxIeMvR7YPMmUe2yk9MQY57IHqekx76mizMURFuSzEHTXeHDRT4M0aSsFreRWWtlvpTFdSK1uDilMKa/nmyHK7iJ2+Hl4Ch6h4S2HjfKE7ljspIWoce8bQWXq7cVq5ngxEvrvedY/vNpxHYbMHWdPfbHh5G8c66PF2HqMzULK8cF6mcK2AUpwXoEfSQy3Uev27LS3Suj09TuiftzTlROkXFEP14Ocj8ffIOefZiw6dcfgH4IOzTPeUNW4ruwyemTl94A7ho3e3VDI7DrOPifYLn47YMp3NpdAOhNBIX1ayaGU4xkH+Fnxyyd9F/V3ZRq+08A4tsMI/mvrHrVppTz8aVPk4u6mBdk8aPTb3vOOzXnw60YApf2inbnFfAywiYZphuHOqCxFWrnML4NP+KlZjCBuNMRZsD3A8cmXjbsiBIu6tbEV4ZtwOLx/H0E5fPnKrj23sPPh9N6cmZyURZq7uki8guL3NfwEg3jvOFT/E9eyZq2BT248jZKrZf+ZogkQnfj3QJ4dN5nx6LdZIKey5LHx24uU0QQpP1CA6eHM64XYVXW7KbG3ltTkgscbvRAjXOAyx02OnwlwD4mH6FJR7Mn0ISVlswDKweWmFrGcPZf6YerTZqVnS8+jE6Ph72HeDo5QvsHyme11dtbolbIQO/iWIy8qDuACkfuxzbNklilnl/iE1Qu9bLIKmXMI9w2MGmky2LlfVJC09qIZ6K3hiX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(31696002)(186003)(66946007)(26005)(31686004)(110136005)(36756003)(508600001)(66556008)(53546011)(66574015)(16576012)(316002)(2616005)(4326008)(956004)(6486002)(2906002)(4001150100001)(38100700002)(8936002)(8676002)(83380400001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M280ZGcrR094c0ZTNHFYMXdGMVZFQXhUNEhEMlh4VFJBbEpjZXNSWTg2VStF?=
 =?utf-8?B?Vm9NdnVKakswc1owRnQvc2hHQjk3Qk9tN3dwNzFsTjlHcjMvODZhL0JnZmp0?=
 =?utf-8?B?TDBOTy9pTXdZVEFUOFhNRnNoTENSQlRLRVQ4cmxwR2FwNlZLVmZGVm02RWYw?=
 =?utf-8?B?dDhXVlRYSFFFNW41UXc5NkhsNDZ2RmlsVVhTdkVLS3RObGJRZ1hzejNqdlhp?=
 =?utf-8?B?bjgwRERrMHJCbkNETWFad2pndGxmRFIwZXBnRHFvTjBhUXozbHJkM20wczRn?=
 =?utf-8?B?cVdqcncvYXEzemVXU0lIZk95VGNQRFNVQ253S2VqT0cva1dUeVdtbGZ1Mmh5?=
 =?utf-8?B?KzlSTGJZclFheVI3MytyN0JteWt3cGM2NFdJMkhoRG5xK0IyR3RCOGYyc2NJ?=
 =?utf-8?B?STZnWlJ6RnJJMnlUQ2VEM0wvaFBINmlqQ2JjL1FqL0hPa2V3VnB6KzNoajJu?=
 =?utf-8?B?OGpsejBoMXVUeU9rYXM1UnRnUU45MC9ReHNYcWFKN0NYbGJXRVp2VmhTYkJV?=
 =?utf-8?B?aFllbU45SENYM3drQnBIWDBySVVIbG9HVy9HNXhkOTZFQ3NDYU9janZ0aTYy?=
 =?utf-8?B?SENadjE0bzRwbGpqRmtWa3FkTm9DcWk2bnVaWnJ1M2hTQXYycWhkRloxRXF3?=
 =?utf-8?B?ejJmOWM1TWo0REhSc2g4VnIzVE01NW9VWTZvb3pRYjRjLzVlUXk5amoyVGZU?=
 =?utf-8?B?VUE3WHArd2p4TTRXVHFZUEI5L1JOVjNQRThjWGFoOGJYVFJkbCszcW9WZGcv?=
 =?utf-8?B?d2c1dTF1V3I0VHR5ZHYvM3VvWXRFRDVKQ1dTMHgwM1FzSXV5T3RZd3puNVNv?=
 =?utf-8?B?bE1uT1VnNEZlcktXNVkwRVYwRFVwMnBwZkNMM0RJOXhSUUNSZmNtbW1OWGxB?=
 =?utf-8?B?QlZLaG9hZUNmTUVuRS9pbzBMUWpkNzU2cTdaRFZ2NU9sVmU1dUhUNk5WY0sy?=
 =?utf-8?B?MnZCUTEvYUFsOUxMU1lNNDZQZU0yRDNoWEZZYk9lZjFPV3JROHZxZjZ4dTJy?=
 =?utf-8?B?YlpST1lma2tHRW5OWFFJQ1Rka0JKYkk4OUNPd1FmT0krYjYwWVB4bmJRUGNV?=
 =?utf-8?B?aFA0UCtRL2NwSVg4bkY1NXc0V3BHL2JORVFuZUdLTWlkZnNBVTRHbk1ZMDZG?=
 =?utf-8?B?VStsRkZCK1dFS0dHaDg1Z2ZsRVZWR2pXL0NLdkx1WDZFczM4U3ZYWmpGNC83?=
 =?utf-8?B?UGtjN1ZGOFN0WTg5MWFKbk16SDVKUHUrRUFOR0VxSFR2bmJWN3RNU3RTckFo?=
 =?utf-8?B?RVNLTW1Kc2VOOVNnK3lYQTVDRXlYcEdSczI5cXZQTlhBZ1k5UnhObWhmWnlv?=
 =?utf-8?B?NU9nbUlXdXhLcmtrdmdmNTA0dEhrOGVFZmtQSWZkQ3h5NEFhTE1TRlZXb0tR?=
 =?utf-8?B?WlV2T3IrdkJtOVhEa3BVa1pNYWlMZEZaSjlOQlpjVWV1YXdMRzN0NmJrWVBG?=
 =?utf-8?B?ZjlmY0YrK3V4VVd2K0hLNkhVb20rYzJONWwyUlcycnNlU2ZXUS8rbStidzdq?=
 =?utf-8?B?bnlyRTB5SWpWei9TV1ozYjkyaGN1RTliY2JsWEZ2bzZxb205Y1ZPaVZENmtZ?=
 =?utf-8?B?VDR4d2RnWk9RY1VtMUR3bDN0SENhRVNlbld5MGM5cjd2VlB3UDNoQWNmRC9E?=
 =?utf-8?B?YUFZVFQ5OC9PZ05DOXpJaEJnRUlRNGZqQXAzM1R1Z0xwN2o0WjZnWHNTOEtP?=
 =?utf-8?B?MW4wbVNWQ1BFUUg4ZW9QdVlXMkRQZHBnL1dNQndpVUJTUE9Da2ROUUwwK25k?=
 =?utf-8?B?MVJVcUozWS9kZW0xZ20zZW95L21ndjZteHNCeGNiVDFISTgvbFdWbHBuRis2?=
 =?utf-8?B?Wm1nQnlUR2kyTlZHcCtkd2NkSGxwSDZvYmlkbi84dWJONXFaelROb1VXT2xi?=
 =?utf-8?B?S3QrOGladjJjTGJjSW9BeGRjK2FPNC9jZ1ROM3k5VTdMN3JNMm1GSGQ5MGor?=
 =?utf-8?B?OEd5WFkrZmRuSDdrTEt0UVJMQXZVOGhHQStFd1lUODdQUUR4dkhBUmE4MEFJ?=
 =?utf-8?B?TEtueXBLcTgzc2V0bGFGSFRuaTNBY3RiU2QxQ0lFT2Vuck9Lb25XYWVkVUI5?=
 =?utf-8?B?RFJEZUNZUDF2VEhPU1JYNjdhMDI1Wm5wYXBWay9wMjhXMjBsTTEvemwrTnFR?=
 =?utf-8?Q?bQYU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df920650-0892-475f-857a-08d9b0276ce5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 15:22:42.8423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eocCsIzOikvg9LckGuaTBg1ZwQua8eSy8DVR2UPdx4ks7P9Et1uVHtNG0YVD6s75
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-25 2:03 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a832f0bc-fcb1-4e13-3cf7-c598e96a665b@gmail.com">Am
      24.11.21 um 21:20 schrieb Felix Kuehling:
      <br>
      <blockquote type="cite">Am 2021-11-24 um 10:23 a.m. schrieb philip
        yang:
        <br>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">&nbsp;&nbsp; &nbsp; #define
              amdgpu_ih_get_wptr(adev, ih)
              <br>
              (adev)-&gt;irq.ih_funcs-&gt;get_wptr((adev), (ih))
              <br>
              &nbsp;&nbsp; #define amdgpu_ih_decode_iv(adev, iv) \
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;irq.ih_funcs-&gt;decode_iv((adev), (ih),
              (iv))
              <br>
              +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
              <br>
              +&nbsp;&nbsp;&nbsp;
              (WARN_ON_ONCE(!(adev)-&gt;irq.ih_funcs-&gt;decode_iv_ts) ?
              0 : \
              <br>
            </blockquote>
            Please drop that WARN_ON_ONCE here.
            <br>
            <br>
          </blockquote>
          Agree, will drop it.
          <br>
          <br>
        </blockquote>
        I suggested this. We're assuming that this function will never
        be called
        <br>
        on hardware that doesn't support time stamps, and that all
        hardware with
        <br>
        time stamps will implement the decode_iv_ts function. But it's
        good to
        <br>
        get a log message if that assumption is ever broken, rather than
        just
        <br>
        silently getting wrong results.
        <br>
      </blockquote>
      <br>
      Well exactly that's the point, you won't get wrong results but a
      NULL pointer exception instead.
      <br>
      <br>
      So we already have a backtrace in the logs.
      <br>
    </blockquote>
    <p>The check will avoid NULL pointer access backtrace, so WARNING
      backtrace is obvious, useful for future chips to implement
      decode_iv_ts interface or use the helper function.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:a832f0bc-fcb1-4e13-3cf7-c598e96a665b@gmail.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        &nbsp;&nbsp; Felix
        <br>
        <br>
        <br>
        <blockquote type="cite">Regards,
          <br>
          <br>
          Philip
          <br>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
