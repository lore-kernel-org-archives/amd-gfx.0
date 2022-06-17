Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7BFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0299010F648;
	Fri, 17 Jun 2022 19:13:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3144610F648
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/WiIjwxVydyk1UMyBTq8J0ydWHesi98UVl3D+IoWMPSAilK5oX1drH2XOhtcu5ul0GrFOAhai2Ad377GBhlktqGYuQ/EJrN6V3p0yXfusfRxabEA6V22kPi6N3zGl2iAYU89CcpLzXz13wzCeZeLQHVBpV3M0MeOgMq2UGSRjxKCH4RYDWcCj8oZJxeVRRZG7DzWetUjsU86WfNDx9oeST6Cc/fYlASU7RPjqq+D1EgeqXTtgheIgvVIHRblwz05SE1TQoe4icRrCzeYNIHqTndzX3zEoLGggnlhAEexd00Fae7i4Nld3GQzFna05zXJs1nc6zZkhOuA8U6x7T/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkUJ3+XQ2g02hb+MGaVRnzUmPqUN1keZxV8DogJHgpE=;
 b=GD4uVwucrjOwD6l5AZawGJCif3cR08SMOXc2B5juPw7/D8VHCnw8CrAX9Bt4cSIWV8no3Bj78umCuVHshhIuICWvUrgoz/oRxXx58rQPyl9t5qeZqoMTZXMMNydjUsAdocdGgdXnPaIgW8XWfViFfVMEZqMThqFW31EAJZicBEhLlUM5JAdNU02prHJwjUtj4JB8Zds8hQ7idc+2FNxYl/R+QYdU1Ogx7zZ5JoskVwn/bZJUvXTl+/A05GCJrLGAlNVW3FC1nO4zLvi2/f0kcyRQNipMpz6G388pzRssnrshcKHyvLFqTSEh4FAgHiHJYR0sIbUcGcHGHHRbW/7WHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkUJ3+XQ2g02hb+MGaVRnzUmPqUN1keZxV8DogJHgpE=;
 b=4cPN/1BOxMlUUe3n9rhIzHv9Z6RAAy//FHTZgLKrVbt+hc5f21DJPaMD8M8zVegtFombC1mU9gEc01Kju3TtoqLOw8iKUUPdYfFEWfNw7SZbr/k/4BXsGLyOd9GL207pM3JpDncPy/C52FkoUcc1zx5Q2ieAnyIP5PDpmdj9TBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MWHPR1201MB2526.namprd12.prod.outlook.com (2603:10b6:300:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Fri, 17 Jun
 2022 19:13:03 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%6]) with mapi id 15.20.5353.017; Fri, 17 Jun 2022
 19:13:02 +0000
Message-ID: <283395a3-d24f-f8aa-bbad-0c4be08aa415@amd.com>
Date: Fri, 17 Jun 2022 15:13:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] drm/amdkfd: Add queue to MES if it becomes active
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20220615215651.14502-1-Philip.Yang@amd.com>
 <a70defa4-6268-406e-ff69-fb5f8aa6989c@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <a70defa4-6268-406e-ff69-fb5f8aa6989c@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f597919-d018-4fc5-5661-08da50956689
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2526:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2526C5C89A4DD34A7008F7FFE6AF9@MWHPR1201MB2526.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzUAsbS0KDVcdNl+bJZHcHYgth4nleJUFacQq1DhZpMkqG0OetkUDUKPuqw4oFc/lxVQRensIGvU1yGOuDIerIKOwtUdcmm/0liNvCev/KVvstdjU/P1Mdn35AsvImZaopNqhpy4BH2ExMGpQzBM0LZTenWflQEKMGXh09vB/6p1LGLEyVYqNcPy4CCI3rhz8esn3UJTSBPDhF12fnUc1nQ4e9avdVrXzY8VBQYUr79sv/qhYIwA0WgdwRAGDfxkLXQC8s0XGuI9C8SvQDZmpjRsiIAkK2hvAHBsHF7JYcgrWfhFSfbgM7FNzF7D0+eQfh4kFW7RsQnFLBODbcqoMcwOC0eMKVBIlAkqakuTkXlPGHH/FSfDXVouP5kUp+P6jGUOrVqulKBDyDsaTHLjUvDck8XmuFbAqzfFcmced8nR6zrUAeQXZm2juNohHLKDCCSxsxpkCLxy6CyvO5XePzxHwq/GKruLRA1Avfn3RTdJBsK6ETfdFfNqB2MEWCy+PndHc506j6pvCnU3WO3OsAjbkcCgq28XtWkCUf3qvt3zDfin1LVExbQBOEhPoqgUHCzQmHEXzHDI+XRHvutrMzp9Xv1q8z0CcMuJiuRKZOwjGJ/rJTFerNLkDEO9Rds3b7KDsngpX2OK9VxB8RTizyPbIWuUAyBEEklhDdubIrqzCYGtrAb9bD3mi2b2dW370boU+niwS+VKLFvz659q0CZjK0CVfbyZRAwnguII5s4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(6486002)(8936002)(498600001)(5660300002)(6512007)(53546011)(6506007)(31696002)(2906002)(26005)(186003)(2616005)(66556008)(66476007)(316002)(83380400001)(36756003)(8676002)(6636002)(110136005)(38100700002)(66946007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2hxUm5lc1B2R1JjUS8xQkJ5SlJtQ1dYWkVjSUNjOEZ3WmRzNjNRa0FhbWcy?=
 =?utf-8?B?eTFvVHRqSEQ4a3pNeDZyU3cwcWxFRGc2UkF2TE82NnB5aWJNa29qVW1Calhs?=
 =?utf-8?B?TWdYZFlBZFd4bXd5YXlweFcvN1JtUzR0STZDem5xNkFFbkozUVUzSEt2NlJV?=
 =?utf-8?B?b1J4M05nUU5GQlMxbmd1WTRhUmsyNERWQzkxcjZIM0Yvc0tCY3dBMWVyQnha?=
 =?utf-8?B?L2haZmZsN01yN1JEcEh4ZDM4dlJsMjZFTFZCUGRhcDVpUHd0Z01oS2VxS2tv?=
 =?utf-8?B?a1lySUJyekVzWVZFbnV2R2ZSUDVDdTI3eTRFeUM1bEljRzZFTmdjcFBqaDhw?=
 =?utf-8?B?MXluVzg3RTZzWTJweHd3N1lHaGN1QTE4S2VjY3k2OWNKRW1BNDdmZTF5Mmdu?=
 =?utf-8?B?NzdxSm5VSVRjdnlwRWtDczBiY1RtZEhLOTFEalEyYW4xczJQeXgwZmdodHh5?=
 =?utf-8?B?QkNIbVZNQjNNNGZ2TXFVdEFUeTJ6eW16K3c2VitHS2hlWjFZNFNXZGJxQ1gz?=
 =?utf-8?B?WU01Tzl6a3FuRUJHcHhpakVvdzNKcWo5dklGRUJnZlZtc0UvNFNOTkNlTkJL?=
 =?utf-8?B?T01STGtrNTNPL1hWc2pIZys4Mk9tcFd4NFJIendQZjdabWpFNjB6c2psMnFJ?=
 =?utf-8?B?S1RqUDR1Q05JZXhabUdpSHZzdFFyNDZhY25jcFpIZDh4UjhkQTVnMFJsY1Fz?=
 =?utf-8?B?dWtNek81UjBLdm5mL1IzVElhNCtISTJOT1VIWjZwQ0JhVVAzTmNWSElLV0Ux?=
 =?utf-8?B?VmVEMlduR045R2dtYmtUaGRFdDRZT1lPOXNxbnJXTmFLcVhwZC8rVFNFRHdS?=
 =?utf-8?B?cVJhblcrUWFKYmdKcWdJbHlYeC9WVmFHZi9CTHpqUG1uY0RPVHVQTDhUUVdL?=
 =?utf-8?B?M1Vya1phR1NlNUhyKzJ4K25XalJuU1ZJdFF3YWhWMVdMTzJmUHFzbWZsSWhE?=
 =?utf-8?B?bWdCRFp0UmdzcGdKYTdVdDFMaXIyTk1xaUV0UWRRcUhjNUdRVEdFK2xBQnc0?=
 =?utf-8?B?SHo5V3lXK3BwOWZoeCtnYmljek1uVmJNUGtSSjdJZ1RCb1ZicXFuTUluWXQ2?=
 =?utf-8?B?MTJtK1VEU054N2lIQ25qUS9hT3YwcTd1T2R4RlljYnA0d0JDWXlQYWlscVZl?=
 =?utf-8?B?OUVzRjAyN1lxZG1YUGZqQ05CaHE5dmQ4OUFPRTdmSE9XbXd3MlFoSCswZTZO?=
 =?utf-8?B?dnNibVdvcFg3NzAzUEtmejJXMEdDNmd3RnhhaHVDdkpVM09oaVM2R1IzMFNm?=
 =?utf-8?B?OHpaWC9Rd0FYWU1VVjI1R2RWOW5DY2NWOHN6SzRsSFE1VlIwbHl0V1ZCNUdR?=
 =?utf-8?B?MTNCaFJ2by9jWWxiSlIxMWwzSGFCcEtNbUxzWmYzTzNyM01UMER1QnpSR2dS?=
 =?utf-8?B?d0doSDVjMEc0YTN6d014b091Y0RqeEtpU0RqZ3AvN2hmc25VMHE3dWZZSFpZ?=
 =?utf-8?B?Z2t0Q0ovUU5wZFhmRGI2K2ZpYUhYOCt0K0x0S3U4ZGtvMWRpSUdGZll4eTFE?=
 =?utf-8?B?Y0RvUGhpOXhqMENxQmk5NnZtaW9NdHFTTzBqdTRCYWJhVjhyaExtV1R5bnc1?=
 =?utf-8?B?cVRhYVpyVFoyTmtpZHl2OUlSdTZMT1Y4VEJrYngyREVmaXgxVDdvaEd6QXQ3?=
 =?utf-8?B?djErNzloRHlsQjVZVy9QVHp0TVFVZndmb2F2NFVrNGhCMlRtZjVOZ3dZbm1m?=
 =?utf-8?B?RUlVYkdRMnlyV093Vk1YcGdrTFRzT2RCaDA5b1JPTm8rdUxkc0tVMEkxMTFC?=
 =?utf-8?B?OVZVSW5VK2NBa096bm5Ed2tGVUhOc1htVFd2NWxIcWJ4czBROWVtUmIrTkNR?=
 =?utf-8?B?VER2OE1iTUIxZlBzTWVCS0Vvd29MUjVIOG9xUXk0Qll6cDBJcnZLMGtDdGpB?=
 =?utf-8?B?OU15Z1M2MFNyeURSUnJkVmRpZ1ZFSTF2Q0dvQVV0dDZGY2xDNEdBSXlNQnBv?=
 =?utf-8?B?bWVtYUpZMzJwT2w4RnhVYkxXM3J1QjVTQUlxeEhibERpYU9UUDlHYmw1NXJj?=
 =?utf-8?B?aC95SDF5THJhUkpyc2x2dVBiNzFuSFhBVk5GYlNmb2MxVS9NVjRGTkF5ZTE2?=
 =?utf-8?B?MGRkTXJDOE9qVC9jcUh1VUk0MEFCVG93ZXNyQ3d6NnF3cm1MazZsS3hGa0lr?=
 =?utf-8?B?d01Wb09rWnVHQ3VGMVBLV25PQ21sTmhrNG1zRXFqaGVmZlRTMDlieVM5a281?=
 =?utf-8?B?NjFiVWQrOXZvdjVLSzhXSHlQVXNtWHZtUlA5Z0ZmOXV1bm1YY1ZoVWF3MEZ5?=
 =?utf-8?B?MWhKVUdGb2QyZnZRUzUzZXpEL284ck1sMzRzNU92azBUdTZMTkVHaHpoVi9q?=
 =?utf-8?B?Mnh0bVdWVkl6RGZsWGlHVnRkQmc2REJCNkRadC9lbmQ3UHVzOWczdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f597919-d018-4fc5-5661-08da50956689
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:13:02.8691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Skmaf3Ek1BQ5LtqNqjIeU2K+6whJlIjhvPvmyKnp21VSD1BqWUNz5+TUwvuVwPk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2526
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
    <div class="moz-cite-prefix">On 2022-06-16 10:49, Eric Huang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a70defa4-6268-406e-ff69-fb5f8aa6989c@amd.com">Does it
      break the case of q-&gt;gws with q-&gt;properties.is_active ==
      true?
      <br>
      <br>
    </blockquote>
    <p>Thanks for catching this, it breaks pqm_set_gws, I will revert
      this and send v2 for review.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:a70defa4-6268-406e-ff69-fb5f8aa6989c@amd.com">Regards,
      <br>
      Eric
      <br>
      <br>
      On 2022-06-15 17:56, Philip Yang wrote:
      <br>
      <blockquote type="cite">We remove the user queue from MES
        scheduler to update queue properties.
        <br>
        If the queue becomes active after updating, add the user queue
        to MES
        <br>
        scheduler, to be able to handle command packet submission.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6
        ++++--
        <br>
        &nbsp; 1 file changed, 4 insertions(+), 2 deletions(-)
        <br>
        <br>
        diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        index e1797657b04c..67ae5b6385a2 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        @@ -866,8 +866,10 @@ static int update_queue(struct
        device_queue_manager *dqm, struct queue *q,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dqm-&gt;active_queue_count to determine whether a new
        runlist must be
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * uploaded.
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active &amp;&amp; !prev_active) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd, q);
        <br>
        +&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_queue = true;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prev_active)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd, q);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!q-&gt;properties.is_active &amp;&amp;
        prev_active) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decrement_queue_count(dqm, &amp;pdd-&gt;qpd, q);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (q-&gt;gws &amp;&amp; !q-&gt;properties.is_gws)
        {
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
