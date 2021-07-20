Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60ABC07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953A161009
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953A161009
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CDC89E35;
	Tue, 20 Jul 2021 15:13:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E7189E08
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAyoAillS2hZCnxDmHHvWPyzhihkNrspM+wQ6qZDAa1Hq76YGFV3IRCrx9iUmqNXJhXGN0aQxehkVOZWAi6xXCTKHrjhS47U3EVYQaxVBbzHul4HputKpxq92dm5sCymyCnN6dD3Q1+LW9BlDRQR+JNi9hYtlRVk2SUVvDYcYEMTCapimyy01S5S4C9r2+32jpEDLPwaiW8jxo4TMO1BNCTCx5fEzLJaSXcD3w1MDg/Quj/gGxqS6C2pCK2BK0Xd9Y7QozGYqEgeFEGms786ElkCb+hyWifpAXn+/8cKh7RN8Ai1kZ15IoEfJID7bh9joPEiuvhDL86/1SUSDnh/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZLV7P2chgCxplyRwEyMkJsImbD/PavLuFA8jcnjCpE=;
 b=PaACWcmECqWub9lhYZsjqryNeBLTjOAbxd5H4rCrnIjj/U2Inx8UJry8W/a2/hoCFMIdFtjbMB65JZ7sgqlfHJVpJbHA6uuF5bWX0sOsK6agJwrdUuvun5eCDAZJmpGCpknFPKLWCqXg6aiGP+CKFKOzLt+rualmsijUcsmQzBnqXcngEJ6Qxfe/LxXu2/rBNrC5CyEnxdJ5VPi88pWblSImwUinCYyY21WwndO+zN5/GtleTiWixqaCJ1FI9utLvSDZodZOlv6os72OlwDRJLTMn0zAzHfHlIo34plTo1VdaNCZ3ytGIzkYDQoqLg7P7ht/QV9iICHxf1hLXvxzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZLV7P2chgCxplyRwEyMkJsImbD/PavLuFA8jcnjCpE=;
 b=k8Ois+Ut1GIh3ueXAj+aM0LSfiOPDLiZvlPMocGZU+iKkzvMd6oVwZp6hXffddEagVS9O5KQY1vHoo9vY7kuB7fQLy5pbQfoas0GfQsrNRsd4WFq1BPmgIpcl9hzvbDTmbzbUqnCBy/39azr3/XKlnsh4x4ZyRUOdRxqSuC6iHE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:13:43 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:13:43 +0000
Subject: Re: [PATCH] drm/amdgpu: Clear doorbell interrupt status after BACO
 exit for SIENNA_CICHLID
To: Chengzhe Liu <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210720075737.1583824-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <38849956-c545-6e8c-a935-67a01999a9e8@amd.com>
Date: Tue, 20 Jul 2021 11:13:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210720075737.1583824-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 15:13:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3814b4f1-0cd2-427a-9993-08d94b90f68d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36905ADC7A6527AFB421C69599E29@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqpCagJHEdwkVQKO9iBRVJGPT4kaHRrzxHm1wrFAGo+yMeCzx8oaKCs4kjjT5MPCzkFyPBCASyePu1F0kAioBHc+FLoPgo7TBuLT4dEJNa9ipksqqjP4bg3aqNs/97rJkJapccYyuGAsCCgF0hNUO9zrMjQc4aTHDcgYMK5/Fpt3vea7wHSYjDqjB1z79/5QqqSCPJAq6IWl98r5C58TYcrM39X5buoUHpVxQiqpb1Kk47YEwSjV7RLniC5RT7s/GvQErGonPRIIABwE6PnbMdXVR20I8UrlZBLgjgZZy5NqxBGCyqPfW+mPSXlF/srNY8vzZCFTp61MICD+/p4Aas/zSlQa8HqkvVBzMt6djwYfL/le9uWsCxBqfsNX9SBfVYwB0+yxTqAaB4u5KOYJ+++DVcxWjNQpMImBk7ikNzfxXMgEtPzhjOqAEjHKuqiCbPNeW9ypjPbG4z2Mh06tg4i7Nmc+FFsCzEyyR7YaEsasyMeu3tIEbK2dMJWv85LTksXC2cXVtBBzoUjstiUy0VJOETPIEin8zPip3TaE7xjwdc/wGXzwJlx8/y1LH71ygEMF1eh7KB9Djh8MZG0UtcJu5vyhOamMU2OMGCq30Ke3bQl4p5XY5upuh2F9Gt9kKaOPkFduRMn+sTIS2D6T87M4KoNoVZPUQr10Vx7xIGXaSGV3xhYOhV1P0nIQI2bJDnz9/gkGVmku2L++mOXMs8swmwzjChiFSQclwezYL0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(5660300002)(6506007)(26005)(8676002)(186003)(478600001)(66556008)(31696002)(53546011)(36756003)(2616005)(956004)(55236004)(4326008)(66476007)(8936002)(44832011)(2906002)(86362001)(31686004)(54906003)(6512007)(316002)(66946007)(38100700002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRxMUhkZCtrdk1OVG5KSkhRY25MczU1MFdIRzh4TWVZb2VMMmpoR0ZiWkd6?=
 =?utf-8?B?WjhteFpjbTB5Qm1EcE9CNmRqN3Q4bXVXYk53NUFxWUI3RlZTKzRRYWRFN3pH?=
 =?utf-8?B?YUVLVG12MnVtNlgzbldSZXN6UDZlUWEyalBLOGkvUFVHNGtpQ0FVM1UyK0o5?=
 =?utf-8?B?L2xEV29EOUJjUDQyRmtOMzBMbEhWK0hmalJObGdIb000N2Rmanh5SDVUK3VM?=
 =?utf-8?B?bHR1Sll0WlNkYjZRNWpqaG40dUNjZVF1YlROQURabVpLbFFLaDJRaVJnT1dp?=
 =?utf-8?B?OGd5VWJsSjdkcS8wYVEydGZqQVN1cm1wSkxTZlBnWFdZWkFoT1YxRk9HbDZh?=
 =?utf-8?B?NzZ1VEVqWFB0UWRFSisxdGprRzFjL2IrYkxzQTVpRTA4bGpOYThiYzZGK1BI?=
 =?utf-8?B?SFdYRDE5cTFVSmkzcUhrdGRPQmtlenM4ZFBvWnRZZEVGUjc4SVJib0R5ZnFZ?=
 =?utf-8?B?SGZ3TlpJajdVT0sxVXhWS0h3K3lqQm1Ja09mNTM4TjFLK204dTAzRHNYVWtj?=
 =?utf-8?B?b2txYy9ZVXBTMjIwUzBEbXNWZTlFNGI4UDRLS0IyU1A1WFBlN0VJREozR00y?=
 =?utf-8?B?cSsxYkplNFJVcExCYXpjNitHQWJxcXhaV3NIYjZseDlXN1AveVFRVVgxRTlQ?=
 =?utf-8?B?M1NDN3ZNZ0ZlNzh1R3hnUUpKaFNrdHJuenpaMGVXWHR6aENzOFpEZG0yN3o4?=
 =?utf-8?B?OWxLMkdUWEZVaGYrT0kxUWZoOWRTR3lOMGZKTE9Wd2JGekwwVkpWUHZqdURY?=
 =?utf-8?B?UGlZQk5HU1VqMHVObzFxZjdDcGN5bjBRWmpZcW0yb2lDTjFJbmoxQUR1OFNY?=
 =?utf-8?B?VEV3LzE1RmloSlVrN05kZUt5ei9kTnM3VVdIT3UxZWJEbG5GS1VTN0FMbjg1?=
 =?utf-8?B?TmZVT0tGK2E1RHpuNitsS1V6VXhVaFUxcVhLS0FUL0N3dU81bWhYbkV3UmQ4?=
 =?utf-8?B?cW83MEtPVk11d2RmaUFjNGJPbU1uYnAwRm5VY0ZjS3NvSzIvVGpvdVVrU0Rk?=
 =?utf-8?B?Kysvbk0vL2U4dFdVMmlUTGFvaSt1ejVaNXVpWWVNTWxoY0ZIcDg3OTA5UlRk?=
 =?utf-8?B?SEtLTjZYQ1pBMUFtQ0tHYlBnT2Z6VlJ5YW91SFpmZm13K0piZ3g3U1h1Y3c1?=
 =?utf-8?B?c3U4Z3pSb0hSbWFDUk9lODRLNmVqSjg0UkQzZWNwVUIzOTRabjNHUFJKbWFY?=
 =?utf-8?B?Nm5MbGNBZjdzSlRQc1dCOERPakVlK3QvUlJ2SjU5cVFnbG10QWJiL2ZrQldv?=
 =?utf-8?B?RGM0djErQnhuWEE2Yy8rakd6TGxpV2RDcW9aL1ErNnNyZUZvRGpncmNaMlIv?=
 =?utf-8?B?YmVQbFU0ek1sbnA1WGFwWnhSSFppSUFJRDlEdStjTDR4bXg2amxnM1JCVVRi?=
 =?utf-8?B?MGd1cEdONm91VWNYemNVUnlsdEhEZG92ZSsydHdEWXgwWlN6VENIdmtyakh1?=
 =?utf-8?B?eDRqSFlaU3RZM2ljcFdHbzRaZTdlQjBEWGttaUNHcHRsbzZOOWJHTXltSUNI?=
 =?utf-8?B?VVUyY1NVVG5RN2hubC9vYTdHQm40WmtYWWhLKzBrUlZTY3lpTWUyc1k0OWhF?=
 =?utf-8?B?dlBrWUJRekJWcVVqaHJ4bnFMTDByL1FSTWZ2L0d0V1BTQnV1QUlSOGhnV2tO?=
 =?utf-8?B?dXE2dUtXUXNYcERWTVovVTlVUmF2d21EZWZseDR5ZElibmJtMnFMRDFrdXlU?=
 =?utf-8?B?RW13S1FqTjF3TGFMMnBVbkd3Z3FsWjJ6b2ZrT1pQR3l4SHBjQi96LzdFMDJN?=
 =?utf-8?Q?RkVNTB6ifRIFvG1Bb6rCYsZTDvo19Q7t4e7Hc5E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3814b4f1-0cd2-427a-9993-08d94b90f68d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:13:43.5393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvKt1jDCT7ROGBCLqWVj/bCCwdovatj3D2+y4PBoLw6Z9LXu6Yj10SYSt7+tYVCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0039731042=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0039731042==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Yeah, looks fine.<br>
      <br>
      A few nitpicks:<br>
      <br>
      The title seems too long. You can just say &quot;Sienna Cichlid&quot;, as
      opposed to using the macro name in the title.<br>
      Perhaps you can add Sienna Cichlid in the description of the
      commit as well.<br>
      <br>
      On 2021-07-20 3:57 a.m., Chengzhe Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210720075737.1583824-1-ChengZhe.Liu@amd.com">
      <pre class="moz-quote-pre" wrap="">In passthrough mode, if we unloaded driver in BACO mode(RTPM). Kernel would</pre>
    </blockquote>
    <br>
    Unfinished sentence above. Perhaps you mean to say:<br>
    <br>
    <i>On Sienna Cichlid, in pass-through mode, if we unload the driver<br>
      in BACO mode (RTPM),</i><i> </i><i>then the kernel would receive
      thousands<br>
      of interrupts.</i><br>
    <br>
    Note the use of present (neutral) tense--it's stating a fact.<br>
    <blockquote type="cite" cite="mid:20210720075737.1583824-1-ChengZhe.Liu@amd.com">
      <pre class="moz-quote-pre" wrap="">
receive thousands of unhandled interrupts. That's because there was
doorbell moniter interrupt on BIF, so KVM would keep injecting</pre>
    </blockquote>
    <br>
    Spell: monit<b>o</b>r.<br>
    Use present tense to state a fact: <i>so KVM keeps injecting ...<br>
      <br>
    </i>
    <blockquote type="cite" cite="mid:20210720075737.1583824-1-ChengZhe.Liu@amd.com">
      <pre class="moz-quote-pre" wrap="">
interrupt to guest VM. So we should clear door bell interrupt status</pre>
    </blockquote>
    <br>
    <i>interrupt<b>s</b> to the guest VM. So we should clear the
      doorbell interrupt ...</i><br>
    <br>
    <blockquote type="cite" cite="mid:20210720075737.1583824-1-ChengZhe.Liu@amd.com">
      <pre class="moz-quote-pre" wrap="">
after BACO exit.

Signed-off-by: Chengzhe Liu <a class="moz-txt-link-rfc2396E" href="mailto:ChengZhe.Liu@amd.com">&lt;ChengZhe.Liu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 37fa199be8b3..109a76ca4535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5265,6 +5265,9 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	    adev-&gt;nbio.funcs-&gt;enable_doorbell_interrupt)
 		adev-&gt;nbio.funcs-&gt;enable_doorbell_interrupt(adev, true);
 
+	if (amdgpu_passthrough(adev) &amp;&amp; adev-&gt;nbio.funcs-&gt;clear_doorbell_interrupt)
+		adev-&gt;nbio.funcs-&gt;clear_doorbell_interrupt(adev);
+
 	return 0;</pre>
    </blockquote>
    <br>
    Seems like a long line--perhaps checkpatch.pl would complain about
    it.<br>
    You can break it after the &amp;&amp;:<br>
    <br>
    <font face="monospace">if (amdgpu_passthrough(adev) &amp;&amp;<br>
      &nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;...)</font><br>
    <br>
    <blockquote type="cite" cite="mid:20210720075737.1583824-1-ChengZhe.Liu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 45295dce5c3e..843052205bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -95,6 +95,7 @@ struct amdgpu_nbio_funcs {
 	void (*program_aspm)(struct amdgpu_device *adev);
 	void (*apply_lc_spc_mode_wa)(struct amdgpu_device *adev);
 	void (*apply_l1_link_width_reconfig_wa)(struct amdgpu_device *adev);
+	void (*clear_doorbell_interrupt)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 7b79eeaa88aa..044dc63d2e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -508,6 +508,25 @@ static void nbio_v2_3_apply_l1_link_width_reconfig_wa(struct amdgpu_device *adev
 	WREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL, reg_data);
 }
 
+static void nbio_v2_3_clear_doorbell_interrupt(struct amdgpu_device *adev)
+{
+	uint32_t reg, reg_data;
+
+	if (adev-&gt;asic_type != CHIP_SIENNA_CICHLID)
+		return;
+
+	reg = RREG32_SOC15(NBIO, 0, mmBIF_RB_CNTL);
+
+	/*Clear Interrupt Status*/</pre>
    </blockquote>
    <br>
    You could make it more readable:<br>
    <br>
    <font face="monospace">/* Clear the interrupt status.<br>
      &nbsp;*/<br>
      if ((reg &amp; ...) == 0) {</font><br>
    <br>
    Regards,<br>
    Luben<br>
    <br>
    <blockquote type="cite" cite="mid:20210720075737.1583824-1-ChengZhe.Liu@amd.com">
      <pre class="moz-quote-pre" wrap="">+	if ((reg &amp; BIF_RB_CNTL__RB_ENABLE_MASK) == 0) {
+		reg = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
+		if (reg &amp; BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_STATUS_MASK) {
+				reg_data = 1 &lt;&lt; BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_CLEAR__SHIFT;
+				WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, reg_data);
+		}
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v2_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v2_3_get_hdp_flush_done_offset,
@@ -531,4 +550,5 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.program_aspm =  nbio_v2_3_program_aspm,
 	.apply_lc_spc_mode_wa = nbio_v2_3_apply_lc_spc_mode_wa,
 	.apply_l1_link_width_reconfig_wa = nbio_v2_3_apply_l1_link_width_reconfig_wa,
+	.clear_doorbell_interrupt = nbio_v2_3_clear_doorbell_interrupt,
 };
</pre>
    </blockquote>
    <br>
  </body>
</html>

--===============0039731042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0039731042==--
