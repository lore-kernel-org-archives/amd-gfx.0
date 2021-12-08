Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8FCC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 17:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 578F16E484;
	Wed,  8 Dec 2021 17:29:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFEA6E484
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 17:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBA4O5L7bAJ1W2ZZDLpbnYXBPCObn5U7XgV5gtgBrv5633BwhSo6PLkRi8UN1vllIck9yqi95l3DbPcI+keGtU5UxXwGNIkXg2UeETjEbUxEvCJQ5dkNItNSBPFNEa9ioE6Qhmw3+/xDmiCYispqdmWaALKLk07v9lcoLAkfJ8zdY8Qi3rHnJ2ugeR9GoPwAkF0hjZpw/TMWzzKQI4KUuDMaZBzGUc2AnyFpnahrEYFmJv3CCYBzx51O8SE+RCU0/pV+Gk2U30iQgO8RTlYBnPPhKzQ0reXOV6nq/y49xhg1DuQiVOp+psW4X0NpeaApQ4lnZb/B1TAIiA2SM4taQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3n/CXI//Icogr8qJaBRfziVLDtA9HrsG6+J/7L8qUiE=;
 b=CSOBIFoD3+jr5gJ1ShkITQ+hQSi48ybPra39Jnggjb99bCtnmcwGkRSvHqVmaau1DGtxxEpD/eWZyyRKz+xTEesUggshmTDOuGI8HmpEnYqfUrMkmiqgM3P1GlsKqP0Veu5IVrG1k7kvwQYoL8GgRPgfJv0hikYp1hfeNrWpwU4fb4jVfxVpRwkvriLHNhbUgzU/UADtyV6X12vGWKAw72o1kwnHaNOfRqX/iG9Rk3nBItgNw2cJ6UU+L8lqY3bXsAQB+R7uXsMYqxr/ZNUUL1YdeEYr+s/f3lRuIy2a9rScdndQYK9h52h+6ZwGKGlOprE+WUXYOwX7SiMUbRdwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3n/CXI//Icogr8qJaBRfziVLDtA9HrsG6+J/7L8qUiE=;
 b=iS7H92r95l+uhui49Yc9xg4iKOK7yiC+cBLFPqYbE0YBtjpjdVBQ9L9iaskqFIZGnca6AR29IFzBxrI23PcxMBXzdJsLIgiwmArqG0s10Ar2X32ybUvUDEkKK0QXjtYd2J2WPO3WddgEpjBcxMPvOuz8Is3lHOP6NYtcT+aeGIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 17:29:19 +0000
Received: from CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::d3e:78b2:716a:3302]) by CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::d3e:78b2:716a:3302%6]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 17:29:19 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: Fix svm_range_is_same_attrs
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211208082457.918004-1-Felix.Kuehling@amd.com>
 <20211208082457.918004-2-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <ead31f7a-67ee-10b2-6f81-9ee40748057d@amd.com>
Date: Wed, 8 Dec 2021 12:29:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211208082457.918004-2-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::11) To CH0PR12MB5138.namprd12.prod.outlook.com
 (2603:10b6:610:bd::17)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14 via Frontend Transport; Wed, 8 Dec 2021 17:29:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb0269e4-82ff-45fc-0579-08d9ba704432
X-MS-TrafficTypeDiagnostic: CH0PR12MB5299:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB529963C373A9F123205032FFE66F9@CH0PR12MB5299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ic4vkj0GPRjkqrJvAaFPRQ2Rpi5KXQLPGHlnofy8BduiMPZ5DKufnR0hvJ/GyRY10y9/D43KPzXN1i1Tu98rKiJAHb3L5IZ8NKhLyieQ6ZLeFIClxJg75qRQF+MpMEJiOmD96iHxMu5Ztwcd7br9uyf8Wd45V+YqxidlR4RD+5o2JEQ+7vOCy6/davn7pRpAQ1Z7L2bwD6b1GJInRWiVZLT2PLyzZfSxEGbEy0HizzmebsiNvN8RjztBxgW7QUZTMGTZaPEiePV7QgkU5JLo5HJvo88Sac/fYS1j37WpJyC5DHtM1ZmfdJJsHekueWCEilEOXgRiwYHYOq8PWaHqov0nP2Dl+jWzt/bJxqz8A8J+NIUccRienQLqwDJVT+BzJWA6Mus9zxKWbcOPSLIn0arURnv769N3XfNdi1vgm89lHNLM88wkNzhiC3pbv89k5jA4oXCHqyaL68PPu0QQLMl9C6ezdc3Sbbmk0pAfsybL23tglUxarzIFSnVgjV5pGrghLxRWSxCjJ3kKCGrL1wXL0cENcxjkvYfx3dA1toJsjOU2bka/7Zso/pSl9J05Rv4E4ci7jcTItjMmwFcnvZbEAbJYVRrZuLTozHuBA+jgnWXZFC9Q4CbHFT9S6T0hjrqEhLbE89tYsx+VArMOalg2OXuzcgHJz/kRqYTWU3CmLfLeUX34wPyUE1EnSWY3WiBFxn4HDEK02BNNQVeP3sqWg5nVGUR5dwOkS2XbEEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(66946007)(5660300002)(38100700002)(66476007)(956004)(6486002)(66556008)(8676002)(4326008)(8936002)(508600001)(36756003)(31696002)(31686004)(316002)(83380400001)(53546011)(2906002)(26005)(186003)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmwva2hXUXJjcUFGbXJUODlRd3psVVlrYkNPUDdJVzdjckl0RzcvOVhQTFQv?=
 =?utf-8?B?ZHBkRTUwaE5XejFNV3g4Mm1XNnordWdlNURyS1VSY3dpeUtsMDhRbUc1OWdm?=
 =?utf-8?B?Mm5yL2tPdEVDMUFhalpjQzFHbFZJTTR4SXk0d01zNkZCeE5QY3pCNjJJTUpa?=
 =?utf-8?B?SUJNNlFoWGcyYndoaXFPUmFmclhocllLeHNIdUI1N2dMeWRxNys4dHRKQ1hs?=
 =?utf-8?B?SW03WlVUNFdFRzJiQTZCQ3JxcFBTQTZXdWxTUmh1dTdWZkgyTlRNMmlpL01F?=
 =?utf-8?B?cnorWU51b05uV1JweG1kelkzekRUS2RHbUFmMStmNi9mOEtzOXdMTzNoYlhM?=
 =?utf-8?B?STVKaUMzSFBKSU9abHVzelBsUEZIY1dEZE5tQTdUemZlTmxUS2J0V05qVkpS?=
 =?utf-8?B?UWQwZXF5c3pCMW1YbnhyZ3kyMVlnQm9hOE9kK3FmTnhOcW9UajBlQ3YyeWw5?=
 =?utf-8?B?cjhEY0lONHgwYXVkdE9CMzZ3dXdySFIyWmFIcFh2ckw3Ri96a3BVOWJGZmtY?=
 =?utf-8?B?TlpGWGZ3Z1I5aVhUZ2gra3JjbGZDZlF2cFpWSEpVREpDUVN2SEZZVHNXWElu?=
 =?utf-8?B?VlRySjhxVEdzVXNIVDBKeWRBT1lpWTJGdENPUW9wdGQwb1J6Vy83RFZVZm93?=
 =?utf-8?B?MEs2THE2NXl4ZkcydWh0WHVUUjhNSlZFYzAyZWtETmcrdzllZWhwM2xVNVhB?=
 =?utf-8?B?eTM4Q0RRVnU2OWx3SFlhMTk1dU01ck5oYy95dWV0c0lSUUJuaDhpTWtsdlNE?=
 =?utf-8?B?cCtvN2ZJaWNaWWJwQjdxaXJzMWpqM2NSWmtrbnZjTCt2MEsvUUZTWWc3Ukk4?=
 =?utf-8?B?MDBOL2hHWFhGVWJNVGt2KzNnSkRNTTkwa0p0TWVEWXFrelk2K3VLVXZiLzBO?=
 =?utf-8?B?Q0hqTHlQWjUvcjJ0UVh3bC9KYXd2NGZnQWNpWmgwVDZyVTNyd1JTcmdxMUN3?=
 =?utf-8?B?aTZraFg0MEJvZ3ZFWUlXZTBkeU05aGsrWXdseFVuUGhKSGdMeENaWU0vbC9P?=
 =?utf-8?B?RjNtVXFqeEQ4dUpNWW5VcTdSamlGdjJzRm9TVyt4LzVlOU40MUdxV3BxYmdw?=
 =?utf-8?B?dnVldStTYnpGR2JOL0pJeVhxTDZNZUZ1NFpGUllCY3NtNjlSNEdMSjFWbCtP?=
 =?utf-8?B?bVR2S3JjeDd3VnVXMTB1QmZxSVN2dUdBWFZmRkpXdDcrN1JPL3d4bTh2NjJD?=
 =?utf-8?B?cDgxeWQ2dDNkdUpURStvTStsb2ZQWUVySVRsdklLZG5pcGZtalhnMCs3MU9G?=
 =?utf-8?B?ZUNJNDIyMkxtSnV3SWlmWXBDN3JONFp0TzQ0Z3hGaDBSbkIyYXlQbytHUWNF?=
 =?utf-8?B?MU90eFBsMmZENUpRUlpBRFZ1VS9YQ216S2xJT25VNHBRQzBhYWxSbFduOHpX?=
 =?utf-8?B?S0l2d2NUdjlObWkvQXhtWG1qblE5dHFJOTVZajNubHh2TFd3aDZ3U3A5WmtS?=
 =?utf-8?B?Ym10clNhMHRsMEpTb1gwZE1oS2Z2ZXlkalVmblRSTHNPeFhpV0J1NWNyRUgx?=
 =?utf-8?B?YUMwRUx2WVdHdlRwaGtBZFZzSm9hN3BSQWN3ZWVCeXdFQzE4eWkwWG5xNTNx?=
 =?utf-8?B?SWZ6MUlldVdaMUtRMFBRQkRMN3J1TUpzTDFSVXpmazg5K015V0tKcUhHaUVH?=
 =?utf-8?B?WWk5bDNXTytubVRQajNIOEx1TEN2aHB6VThEL0V4Ym5zOFZPNllsbGpqQnlp?=
 =?utf-8?B?YmN2eVV4dDlacUVXK043VzltZ05LOFk0cGVnTjM1ajJZbEx0TVZONDRlUnRY?=
 =?utf-8?B?czlpRk0rYitQcGtVK29Zc3NueFNudTBBM2I5TXlxVWt4Y0kyM0JVMXBCV2VS?=
 =?utf-8?B?SHRFcjYvQUdoNVF4SzFNTXhHS3hhK29jNlc4RGU2UGNYZXhlZk1hWmdxRDEz?=
 =?utf-8?B?SVRONmVxSysxR0VsVndsNUJ2MFhOMFR6RVBvMzlVWFpMWWpBTVpjRERKVTV5?=
 =?utf-8?B?MDFVdVZ5VmpmTTdkMTNSQU03dlBmNzBldC82WDNheHNZYUk5Q0s2R3luZkxZ?=
 =?utf-8?B?bXVWR3RjWjBycHBMZFBjUUh1c1B1cHRHR1ZvYTRJZklmNmlFOVBLWW9TUzZX?=
 =?utf-8?B?RGgxcXY5d1JPcitSaXJNd1FaazhiWXhTUllzRkxFc1JxRU5vbDl1M2Q2SUhQ?=
 =?utf-8?Q?TxpA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0269e4-82ff-45fc-0579-08d9ba704432
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:29:19.3805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PzGCvBaG/X2z9hImjv86XqJkrscyJxlXNuSGm9HCdP2pW/YDAgI8W5nGm2xqkFF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
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
Cc: alex.sierra@amd.com, philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-12-08 3:24 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211208082457.918004-2-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">The existing function doesn't compare the access bitmaps and flags.
This can result in failure to update those attributes in existing
ranges when all other attributes remained unchanged.

Because the access and flags attributes modify only some bits in the
respective bitmaps, we cannot compare them directly. Instead we need to
check whether applying the attributes to a particular range would
change the bitmaps.

A PREFETCH_LOC attribute must always trigger a migration, even if the
attribute value remains unchanged. E.g. if some pages were migrated due
to a CPU page fault, a prefetch must still be executed to migrate pages
back to VRAM.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 69 +++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed4430e31307..9ea3981545e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -704,6 +704,63 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 	}
 }
 
+static bool
+svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
+			uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
+{
+	uint32_t i;
+	int gpuidx;
+
+	for (i = 0; i &lt; nattr; i++) {
+		switch (attrs[i].type) {
+		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
+			if (prange-&gt;preferred_loc != attrs[i].value)
+				return false;
+			break;
+		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
+			/* Prefetch should always trigger a migration even
+			 * if the value of the attribute didn't change.
+			 */
+			return false;
+		case KFD_IOCTL_SVM_ATTR_ACCESS:
+		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
+		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
+			gpuidx = kfd_process_gpuidx_from_gpuid(p,
+							       attrs[i].value);
+			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
+				if (test_bit(gpuidx, prange-&gt;bitmap_access) ||
+				    test_bit(gpuidx, prange-&gt;bitmap_aip))
+					return false;
+			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
+				if (!test_bit(gpuidx, prange-&gt;bitmap_access) ||
+				    test_bit(gpuidx, prange-&gt;bitmap_aip))</pre>
    </blockquote>
    <p>Because prange-&gt;bitmap_access and prange-&gt;bitmap_aip are
      mutually exclusive, this can be</p>
    <pre class="moz-quote-pre" wrap="">if (!test_bit(gpuidx, prange-&gt;bitmap_access))</pre>
    <blockquote type="cite" cite="mid:20211208082457.918004-2-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
+					return false;
+			} else {
+				if (test_bit(gpuidx, prange-&gt;bitmap_access) ||
+				    !test_bit(gpuidx, prange-&gt;bitmap_aip))</pre>
    </blockquote>
    <p>this can be</p>
    <pre class="moz-quote-pre" wrap="">} else if (!test_bit(gpuidx, prange-&gt;bitmap_aip)) {

With those fixed, Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>

Regards,
Philip
</pre>
    <blockquote type="cite" cite="mid:20211208082457.918004-2-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
+					return false;
+			}
+			break;
+		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
+			if ((prange-&gt;flags &amp; attrs[i].value) != attrs[i].value)
+				return false;
+			break;
+		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
+			if ((prange-&gt;flags &amp; attrs[i].value) != 0)
+				return false;
+			break;
+		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
+			if (prange-&gt;granularity != attrs[i].value)
+				return false;
+			break;
+		default:
+			WARN_ONCE(1, &quot;svm_range_check_attrs wasn't called?&quot;);
+		}
+	}
+
+	return true;
+}
+
 /**
  * svm_range_debug_dump - print all range information from svms
  * @svms: svm range list header
@@ -741,14 +798,6 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
 	}
 }
 
-static bool
-svm_range_is_same_attrs(struct svm_range *old, struct svm_range *new)
-{
-	return (old-&gt;prefetch_loc == new-&gt;prefetch_loc &amp;&amp;
-		old-&gt;flags == new-&gt;flags &amp;&amp;
-		old-&gt;granularity == new-&gt;granularity);
-}
-
 static int
 svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		      uint64_t old_start, uint64_t old_n,
@@ -1791,7 +1840,6 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	unsigned long last = start + size - 1UL;
 	struct svm_range_list *svms = &amp;p-&gt;svms;
 	struct interval_tree_node *node;
-	struct svm_range new = {0};
 	struct svm_range *prange;
 	struct svm_range *tmp;
 	int r = 0;
@@ -1801,7 +1849,6 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
 	INIT_LIST_HEAD(remove_list);
-	svm_range_apply_attrs(p, &amp;new, nattr, attrs);
 
 	node = interval_tree_iter_first(&amp;svms-&gt;objects, start, last);
 	while (node) {
@@ -1848,7 +1895,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			prange = old;
 		}
 
-		if (!svm_range_is_same_attrs(prange, &amp;new))
+		if (!svm_range_is_same_attrs(p, prange, nattr, attrs))
 			list_add(&amp;prange-&gt;update_list, update_list);
 
 		/* insert a new node if needed */
</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20211208082457.918004-2-Felix.Kuehling@amd.com">
    </blockquote>
  </body>
</html>
