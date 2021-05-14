Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C821FC43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8613361155
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8613361155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278BA6E3D8;
	Fri, 14 May 2021 21:05:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50516E3D8;
 Fri, 14 May 2021 21:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kneMUcdE+X6FIii7jAkmTzvFOnjmia5beWn5XG0Y9Amv1Fk1cJB0JGSbPfU5pyyhYuHQ/+FnBZBiPkG5EdB4XGxAqu4U48RcTaihOqNrvl+QSiTvmIePQsryVEBuKZi71qFXdKuYLy8NM0ma3sWNi1FYFZ/cDszw7u1Z1Y3009LD2/BMGrG6gWUhtZuaH8l/owLR0SJDdL5IenjCvlORoLc6FzA98w/3WSW5VR62lki/kSGZosLzUVyq6e3T5haVd1iI/esCZZ5ERBXr1ZCgA3yR/SoTrr1Swi6P/sX1jcTbZFohO5tRkJBr6kmeICV4KSElLd+g4bdv13puOIhtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFun7dYPzbuGjULGPvjXbBcqCHIO5gB9lvOiVQEe04M=;
 b=jg/6NvFu7McSx7p/gSgs0AVZKX++jzj8Htasw6/mhSkRzr4lBuALrVVxPeEbo47/921vSShrVQtJvexfTIFjc6RFo49U4bAZJIOMb4VPKL+xBr30d+H1Ja8iYT7O3skOFIjc0qiCuhst0BN9EfEXkZw4AX0pD/MA1Tb+P5KB4ZnluqGeAwrMqHAO5k1OMH9SXAXfrezhruoyswveLhpGtMX4zugj0J2usD58r+6RUy/IxxWxZQzrR+xpo9JzOuYkxv55oJtg8UKc1lcPF87CV8v2Gk6hXA5vMbyz2RqXq7B1IY/ach0bGTSxM5bGRBV0HMCSWUlJfEw4BZGv/XVQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFun7dYPzbuGjULGPvjXbBcqCHIO5gB9lvOiVQEe04M=;
 b=HgsDxDvR4rcCk8ovSfc4kAH7yWFQggRVj9fL6M5HhG9WaCkTTWoiB91nszscrD+Fvv+VXHsX+iS626WZPqVovI3SFuAPqjfqH2qdDGu/onXSItzvtOQP/0ORKTQq1189KZxtBeQHu38DxqiaY3BkUWMS4z5QixiGodVF+5U1nYA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0254.namprd12.prod.outlook.com (2603:10b6:301:57::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 21:04:56 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25%4]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 21:04:56 +0000
Subject: Re: [RFC PATCH 1/3] drm/color: Add RGB Color encodings
To: Sebastian Wick <sebastian@sebastianwick.net>
References: <20210426173852.484368-1-harry.wentland@amd.com>
 <20210426173852.484368-2-harry.wentland@amd.com> <YIcBUl+94sHJsT8B@intel.com>
 <0090ce07-6102-59e7-bc8c-3528297aa5ae@amd.com>
 <a49e967a0082727757143828770bd671@sebastianwick.net>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <cac44e69-85cb-661b-4a5e-33fafee8ea3d@amd.com>
Date: Fri, 14 May 2021 17:04:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <a49e967a0082727757143828770bd671@sebastianwick.net>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YQBPR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::34) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YQBPR01CA0098.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Fri, 14 May 2021 21:04:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0be6a9eb-8898-4897-f205-08d9171becf9
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0254E3C9267A660DF44FA1908C509@MWHPR1201MB0254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwPVuFKN7uhBV9pMQBGM6siTs2AiUYeaItrdux6x3UIVSRQU+7oMIxIBCEQPDHZauYg9EZY2r9x3YL/IS8dyHnGJiL5WXfT1leoP6qyPLNOc6L1PpzbLXmTsFAJHHgP6SPrwbZmKVuVyEJQsddSy6+7AD7446t5lj+HLwf0EtxzzpBlf+7zV2rBWCxeRy+yZGa3my27oT9vyyCoSufh24X6wUVUH25sK3KyVz/07YDsi21ykSsc4mrPuhMP5h+67nkAH/Yr8W02T3fskjxe4FiF8pPPOtCO55keOozdi2oGjd5/YToxTT633lkSUoDzPeiuFy8rqkcDKv6xHTplq8PrpFLNKyP/toWExqVP/g4LqTAws0cvcUtc6KzrZSY/XE8d7iRSa53etobtanN/8BmT7zhCyqAYCzuGx51glxR037iPS7IXBVLKAoGdkNMSHZrrXX/U4QA3mUaP1xrLwKZhJ/vxMHbBtc5FLi0ydmZWR4u58flnOqQDB1QUkGMRg7wM+EHFyrI727Fr+FYggnGvNPZ162C1YeHxML0eokfMI1Hf967IwIwxD2dBig4lSa3Elfz5wKQXlfufcvMeuvXlxbHawzF0D9oyF20Z7IJ8Sx2l3Wk84XE5sbhMwhP60XGYQirJkq+lvvw5JaEKVTIEzJ3fEH0Oig1bHJPAX17RDV77yNUCVutkmsGrERjFas+J3BMo9Hy+lo6qmbKvgR3dbU/nY4arcdNmCUtgKrjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(44832011)(186003)(66946007)(16526019)(66476007)(6486002)(66556008)(66574015)(2906002)(5660300002)(31696002)(8936002)(31686004)(26005)(316002)(8676002)(966005)(478600001)(54906003)(956004)(2616005)(83380400001)(86362001)(53546011)(16576012)(36756003)(4326008)(38100700002)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Sk01bmEyS3FFUXNtZld1VjFpaUErN3VCcHRtQ2VaT2xtWHFqQmEyeDVVMGN5?=
 =?utf-8?B?eWtrd1VmbU9OYUwvR2FjYnZXSjhneGdQRmFDNGQ3UWdTYXJmMS9jUCtSeGZP?=
 =?utf-8?B?UENRcGdFTHZyL3RmRHFWQjd5MTVaOTZwS3BQeGJ6QUU1eEExQzhnNTZqUE0v?=
 =?utf-8?B?MDdiWEFmbGRLL0dZK3pEY3Q5UEFPdHpMTHBYREZFTy8wNVp2Nmo5blZUT0lV?=
 =?utf-8?B?ZFpvS3ArTlRSa2tqcjZ4NXdtMFhsRW5BYml2cXVySHlBQmpKdVozSkk2MjQ2?=
 =?utf-8?B?eDhGVGZjVUFyYldpak5Ic0VLNUpGS2l2NHJVWi9uNzd5ZnFxN1YyRVo3RFo3?=
 =?utf-8?B?RTZTR0JtakpnTjEycmpmNGRsdE1EQWdRcXVjVGJCR3hQeUZBOVN3QTJGU2FI?=
 =?utf-8?B?WUNwMFVERW84b1NEc0ZCZTlTUUsyRFoxUUF4U1VFdHBKNHRtNmZyZWFKZWs2?=
 =?utf-8?B?ZFJoa29SYW56MFhST1d1VVRXU2dLQ1IwK2JPeHQzcGdRRzVSOG52TTVuVnBk?=
 =?utf-8?B?Q291ZFVHdGlTaTkzNGxKLzJ6U1doL0E2S2ZreW9UNUJRVnY3TGdoNEVmOEpO?=
 =?utf-8?B?d1lubTlPcjRaWCtnWis0Z3AyMXBIVHRib0YvaW9IUGpYbE9kQUduc2xrcHht?=
 =?utf-8?B?TDdnL1k4MURsajN2dDhHdDRiQXJQMzVZRVVzanJEVjZNRlpYUHdZWVJzM1dB?=
 =?utf-8?B?MDJGbVBGTXN0YjJBVCtJZFhYTWd0M3JXcDhXTi9RWFQ0ZXozd21KY2huMmFu?=
 =?utf-8?B?blg2c1F3am5nTWkxMnN4N1U2KzZHRnBHRk41ZjNmbFN4dHhZWERBRzRvL0J0?=
 =?utf-8?B?Q3BnUjhEM0VJYU1tcFVMNHRIeXNXSWN2TDlmVmY1MkpyNjZvME9RbVdQek5h?=
 =?utf-8?B?K0JrdDBNRkYzZmlJcmNFN2ZNd3E4NzZrb3BqTTJ2cUZ1ZG5EUG9Ma2VvVnkz?=
 =?utf-8?B?c3BUYzZSaVVYK3hoRDlIbjVkdFpYNDhjZkIxN296N2llejZldzQyMUlxQVR2?=
 =?utf-8?B?VmxJakZ2N3d2UmQ0bzFZb2RQU3Y1cjV2ZFlockRQSnQ3SWc2d1Rrd3B3RWlF?=
 =?utf-8?B?V1ByK2QxdVpuVUtIcnJIcVpuRnVXdFI0VWtpb3pYRk5ZZE5tRU13MVRQazRl?=
 =?utf-8?B?L2orSDlVdGhDM01VZklLU0NSQzhLcnF1eWFaYWtxZCtUUjFOa2piTEhwcHhy?=
 =?utf-8?B?b0VieEJIRlhjNWRtR2tsSmdTN01ZUVlFTURuQ2FOMEcxSERWbS9WM2I2RVlP?=
 =?utf-8?B?TjZmM2o2YWs1Q2ZEaHpQcUZjNzRzbnFyOXFwYnFwWCtnM296VmRhZUFDQUhM?=
 =?utf-8?B?K3AydVIxaFFvODZJd2htdjNBcFBjMVpHMFZ1dUU4U21BWURiYmhTbFh3L2NM?=
 =?utf-8?B?RDZpWjVZOCtiZ3phNlNKS3lZeTVKb3dQSGJReUN0VWpMbmdnb2Yzc0xHZlpK?=
 =?utf-8?B?YVRPTzRscXNyM1Mrbmw0N1o5UW5TUGp3SG1IMDN0S0NVVzcyRWl2MGxWOW1x?=
 =?utf-8?B?OGJVbnhHaGxpVVdnUkpTb3h3UytNSzdrY25LQlBZMlFPNTl3S0JGWmpQT2Jj?=
 =?utf-8?B?ZmNBc2VjdnRlUVljRmhmTXk2bmxxc2dzMFM4R3lSVEVMRFpHODBIV1hQZVlk?=
 =?utf-8?B?YlJ3UXI0UzlrenNxR2I4MXdmM3YyOTVhNXpwWVJ0QkNxWWl2OTZvUzNNbXNj?=
 =?utf-8?B?Qi81UlMxRXBaYzM2ZGx4ekhrQ0wvT3UzVUpEajZRbU1RUUNDM2Z1ZFJsWlBE?=
 =?utf-8?Q?ZSKZ+wRqO1KYQ8NqL/el0houo4Pq9x/ppwTWDQt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be6a9eb-8898-4897-f205-08d9171becf9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 21:04:55.9942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8PVBQic9Nz5CpO2UVlniuw19mPTrYUh2HExhZoOCtqQzXyUPy6khfynKmC6+H9BXiFbEVxVkHvX3P0d4/5sLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0254
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
Cc: Deepak.Sharma@amd.com, aric.cyr@amd.com, Krunoslav.Kovac@amd.com,
 mcasas@google.com, Shashank.Sharma@amd.com, dri-devel@lists.freedesktop.org,
 Shirish.S@amd.com, ppaalanen@gmail.com, Uma Shankar <uma.shankar@intel.com>,
 hersenxs.wu@amd.com, amd-gfx@lists.freedesktop.org,
 laurentiu.palcu@oss.nxp.com, Bhawanpreet.Lakha@amd.com,
 Nicholas.Kazlauskas@amd.com,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Vitaly.Prosyak@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA0LTMwIDg6NTMgcC5tLiwgU2ViYXN0aWFuIFdpY2sgd3JvdGU6Cj4gT24gMjAy
MS0wNC0yNiAyMDo1NiwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4+IE9uIDIwMjEtMDQtMjYgMjow
NyBwLm0uLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6Cj4+PiBPbiBNb24sIEFwciAyNiwgMjAyMSBh
dCAwMTozODo1MFBNIC0wNDAwLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPj4+PiBGcm9tOiBCaGF3
YW5wcmVldCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KPj4+Pgo+Pj4+IEFkZCB0
aGUgZm9sbG93aW5nIGNvbG9yIGVuY29kaW5ncwo+Pj4+IC0gUkdCIHZlcnNpb25zIGZvciBCVDYw
MSwgQlQ3MDksIEJUMjAyMAo+Pj4+IC0gRENJLVAzOiBVc2VkIGZvciBkaWdpdGFsIG1vdmllcwo+
Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQmhhd2FucHJlZXQgTGFraGEgPEJoYXdhbnByZWV0Lkxh
a2hhQGFtZC5jb20+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5Lndl
bnRsYW5kQGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2RybV9jb2xv
cl9tZ210LmMgfCA0ICsrKysKPj4+PiDCoCBpbmNsdWRlL2RybS9kcm1fY29sb3JfbWdtdC5owqDC
oMKgwqAgfCA0ICsrKysKPj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQo+
Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV9jb2xvcl9tZ210LmMKPj4+PiBpbmRleCBiYjE0ZjQ4OGM4ZjYu
LmExODNlYmFlMjk0MSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2NvbG9y
X21nbXQuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fY29sb3JfbWdtdC5jCj4+Pj4g
QEAgLTQ2OSw2ICs0NjksMTAgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBjb2xvcl9lbmNv
ZGluZ19uYW1lW10gPSB7Cj4+Pj4gwqDCoMKgwqDCoCBbRFJNX0NPTE9SX1lDQkNSX0JUNjAxXSA9
ICJJVFUtUiBCVC42MDEgWUNiQ3IiLAo+Pj4+IMKgwqDCoMKgwqAgW0RSTV9DT0xPUl9ZQ0JDUl9C
VDcwOV0gPSAiSVRVLVIgQlQuNzA5IFlDYkNyIiwKPj4+PiDCoMKgwqDCoMKgIFtEUk1fQ09MT1Jf
WUNCQ1JfQlQyMDIwXSA9ICJJVFUtUiBCVC4yMDIwIFlDYkNyIiwKPj4+PiArwqDCoMKgIFtEUk1f
Q09MT1JfUkdCX0JUNjAxXSA9ICJJVFUtUiBCVC42MDEgUkdCIiwKPj4+PiArwqDCoMKgIFtEUk1f
Q09MT1JfUkdCX0JUNzA5XSA9ICJJVFUtUiBCVC43MDkgUkdCIiwKPj4+PiArwqDCoMKgIFtEUk1f
Q09MT1JfUkdCX0JUMjAyMF0gPSAiSVRVLVIgQlQuMjAyMCBSR0IiLAo+Pj4+ICvCoMKgwqAgW0RS
TV9DT0xPUl9QM10gPSAiRENJLVAzIiwKPj4+Cj4+PiBUaGVzZSBhcmUgYSB0b3RhbGx5IGRpZmZl
cmVudCB0aGluZyB0aGFuIHRoZSBZQ2JDciBzdHVmZi4KPj4+IFRoZSBZQ2JDciBzdHVmZiBqdXN0
IHNwZWNpZmllcyB0aGUgWUNiQ3I8LT5SR0IgY29udmVyaXNvbiBtYXRyaXgsCj4+PiB3aGVyZWFz
IHRoZXNlIGFyZSBJIGd1ZXNzIHN1cHBvc2VkIHRvIHNwZWNpZnkgdGhlIHByaW1hcmllcy93aGl0
ZXBvaW50Pwo+Pj4gQnV0IHdpdGhvdXQgc3BlY2lmeWluZyB3aGF0IHdlJ3JlIGNvbnZlcnRpbmcg
KnRvKiB0aGVzZSBtZWFuIGFic29sdXRlbHkKPj4+IG5vdGhpbmcuIEllLiBJIGRvbid0IHRoaW5r
IHRoZXkgYmVsb25nIGluIHRoaXMgcHJvcGVydHkuCj4+Pgo+Pgo+PiBJZiB0aGlzIGlzIHRoZSBp
bnRlbnRpb24gSSBkb24ndCBzZWUgaXQgZG9jdW1lbnRlZC4KPj4KPj4gSSBtaWdodCBoYXZlIG92
ZXJsb29rZWQgc29tZXRoaW5nIGJ1dCBkbyB3ZSBoYXZlIGEgd2F5IHRvIGV4cGxpY2l0bHkKPj4g
c3BlY2lmeSB0b2RheSB3aGF0ICp0byogZm9ybWF0IHRoZSBZQ2JDciBjb2xvciBlbmNvZGluZ3Mg
Y29udmVydCBpbnRvPwo+PiBXb3VsZCB0aGF0IGJlIGEgY29tYmluYXRpb24gb2YgdGhlIG91dHB1
dCBjb2xvciBlbmNvZGluZyBzcGVjaWZpZWQgdmlhCj4+IGNvbG9yc3BhY2VfcHJvcGVydHkgYW5k
IHRoZSBjb2xvciBzcGFjZSBlbmNvZGVkIGluIHRoZSBwcmltYXJpZXMgYW5kCj4+IHdoaXRlcG9p
bnQgb2YgdGhlIGhkcl9vdXRwdXRfbWV0YWRhdGE/Cj4+Cj4+IEZ1bmRhbWVudGFsbHkgSSBkb24n
dCBzZWUgaG93IHRoZSB1c2Ugb2YgdGhpcyBwcm9wZXJ0eSBkaWZmZXJzLAo+PiB3aGV0aGVyIHlv
dSB0cmFuc2xhdGUgZnJvbSBZQ2JDciBvciBmcm9tIFJHQi4gSW4gZWl0aGVyIGNhc2UgeW91J3Jl
Cj4+IGNvbnZlcnRpbmcgZnJvbSB0aGUgZGVmaW5lZCBpbnB1dCBjb2xvciBzcGFjZSBhbmQgcGl4
ZWwgZm9ybWF0IHRvIGFuCj4+IG91dHB1dCBjb2xvciBzcGFjZSBhbmQgcGl4ZWwgZm9ybWF0Lgo+
Pgo+Pj4gVGhlIHByZXZpb3VzIHByb3Bvc2FscyBhcm91bmQgdGhpcyB0b3BpYyBoYXZlIHN1Z2dl
c3RlZCBhIG5ldwo+Pj4gcHJvcGVydHkgdG8gc3BlY2lmeSBhIGNvbnZlcnNpb24gbWF0cml4IGVp
dGhlciBleHBsaWNpdGx5LCBvcgo+Pj4gdmlhIGEgc2VwYXJhdGUgZW51bSAod2hpY2ggd291bGQg
c3BlY2lmeSBib3RoIHRoZSBzcmMgYW5kIGRzdAo+Pj4gY29sb3JzcGFjZXMpLiBJJ3ZlIGFsd2F5
cyBhcmd1ZWQgdGhlIGVudW0gYXBwcm9hY2ggaXMgbmVlZGVkCj4+PiBhbnl3YXkgc2luY2Ugbm90
IGFsbCBoYXJkd2FyZSBoYXMgYSBwcm9ncmFtbWFibGUgbWF0cml4IGZvcgo+Pj4gdGhpcy4gQnV0
IGEgZnVsbHkgcHJvZ3JhbW1hYmxlIG1hdHJpeCBjb3VsZCBiZSBuaWNlIGZvciB0b25lCj4+PiBt
YXBwaW5nIHB1cnBvc2VzL2V0Yywgc28gd2UgbWF5IHdhbnQgdG8gbWFrZSBzdXJlIGJvdGggYXJl
Cj4+PiBwb3NzaWJsZS4KPj4+Cj4+PiBBcyBmb3IgdGhlIHRyYW5zZmVyIGZ1bmMsIHRoZSBwcm9w
b3NhbHMgc28gZmFyIGhhdmUgbW9zdGx5IGp1c3QKPj4+IGJlZW4gdG8gZXhwb3NlIGEgcHJvZ3Jh
bW1hYmxlIGRlZ2FtbWEvZ2FtbWEgTFVUcyBmb3IgZWFjaCBwbGFuZS4KPj4+IEJ1dCBjb25zaWRl
cmluZyBob3cgcG9vciB0aGUgY3VycmVudCBnYW1tYSB1YXBpIGlzIHdlJ3ZlIHRocm93bgo+Pj4g
YXJvdW5kIHNvbWUgaWRlYXMgaG93IHRvIGFsbG93IHRoZSBrZXJuZWwgdG8gcHJvcGVybHkgZXhw
b3NlIHRoZQo+Pj4gaHcgY2FwYWJpbGl0aWVzLiBUaGlzIGlzIG9uZSBvZiB0aG9zZSBpZGVhczoK
Pj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2RyaS1kZXZlbC8yMDE5
LUFwcmlsLzIxMjg4Ni5odG1sIEkgdGhpbmsgdGhhdCBiYXNpYyBpZGVhIGNvdWxkIGJlIGFsc28g
YmUgZXh0ZW5kZWQgdG8gYWxsb3cgZml4ZWQKPj4+IGN1cnZlcyBpbiBjYXNlIHRoZSBodyBkb2Vz
bid0IGhhdmUgYSBmdWxseSBwcm9ncmFtbWFibGUgTFVULiBCdXQKPj4+IGR1bm5vIGlmIHRoYXQn
cyByZWxldmFudCBmb3IgeW91ciBody4KPj4+Cj4+Cj4+IFRoZSBwcm9ibGVtIHdpdGggZXhwb3Np
bmcgZ2FtbWEsIHdoZXRoZXIgcGVyLXBsYW5lIG9yIHBlci1jcnRjLCBpcwo+PiB0aGF0IGl0IGlz
IGhhcmQgdG8gZGVmaW5lIGFuIEFQSSB0aGF0IHdvcmtzIGZvciBhbGwgdGhlIEhXIG91dCB0aGVy
ZS4KPj4gVGhlIGNhcGFiaWxpdGllcyBmb3IgZGlmZmVyZW50IEhXIGRpZmZlciBhIGxvdCwgbm90
IGp1c3QgYmV0d2Vlbgo+PiB2ZW5kb3JzIGJ1dCBhbHNvIGJldHdlZW4gZ2VuZXJhdGlvbnMgb2Yg
YSB2ZW5kb3IncyBIVy4KPiAKPiBJbnRyb2R1Y2luZyBhbm90aGVyIEFQSSBpZiBoYXJkd2FyZSBp
cyBzdWZmaWNpZW50bHkgZGlmZmVyZW50IGRvZXNuJ3QKPiBzZWVtIGxpa2UgdGhlIHdvcnN0IGlk
ZWEuIEF0IGxlYXN0IGl0IHNvdW5kcyBhIGxvdCBtb3JlIHRyYWN0YWJsZSB0aGFuCj4gdGVhY2hp
bmcgdGhlIGtlcm5lbCBhYm91dCBhbGwgdGhlIGRpZmZlcmVudCB1c2UgY2FzZXMsIG9waW5pb25z
IGFuZAo+IG51YW5jZXMgdGhhdCBhcmlzZSBmcm9tIGNvbG9yIG1hbmFnZW1lbnQuCj4gCj4gSW4g
dGhlIGVuZCBnZW5lcmljIHVzZXIgc3BhY2UgbXVzdCBhbHdheXMgYmUgYWJsZSB0byBmYWxsIGJh
Y2sgdG8KPiBzb2Z0d2FyZSBzbyB0aGUgd29yc3QgY2FzZSBpcyB0aGF0IGl0IHdvbid0IGJlIGFi
bGUgdG8gb2ZmbG9hZCBhbgo+IG9wZXJhdGlvbiBpZiBpdCBkb2Vzbid0IGtub3cgYWJvdXQgYSBu
ZXcgQVBJLgo+IAo+PiBBbm90aGVyIHJlYXNvbiBJJ20gcHJvcG9zaW5nIHRvIGRlZmluZSB0aGUg
Y29sb3Igc3BhY2UgKGFuZCBnYW1tYSkgb2YKPj4gYSBwbGFuZSBpcyB0byBtYWtlIHRoaXMgZXhw
bGljaXQuIFVwIHVudGlsIHRoZSBjb2xvciBzcGFjZSBhbmQgZ2FtbWEKPj4gb2YgYSBwbGFuZSBv
ciBmcmFtZWJ1ZmZlciBhcmUgbm90IHdlbGwgZGVmaW5lZCwgd2hpY2ggbGVhZHMgdG8gZHJpdmVy
cwo+PiBhc3N1bWluZyB0aGUgY29sb3Igc3BhY2UgYW5kIGdhbW1hIG9mIGEgYnVmZmVyIChmb3Ig
YmxlbmRpbmcgYW5kIG90aGVyCj4+IHB1cnBvc2VzKSBhbmQgbWlnaHQgbGVhZCB0byBzdWItb3B0
aW1hbCBvdXRjb21lcy4KPiAKPiBCbGVuZGluZyBvbmx5IGlzICJjb3JyZWN0IiB3aXRoIGxpbmVh
ciBsaWdodCBzbyB0aGF0IHByb3BlcnR5IG9mIHRoZQo+IGNvbG9yIHNwYWNlIGlzIGltcG9ydGFu
dC4gSG93ZXZlciwgd2h5IGRvZXMgdGhlIGtlcm5lbCBoYXZlIHRvIGJlCj4gaW52b2x2ZWQgaGVy
ZT8gQXMgbG9uZyBhcyB1c2VyIHNwYWNlIGtub3dzIHRoYXQgZm9yIGNvcnJlY3QgYmxlbmRpbmcg
dGhlCj4gZGF0YSBtdXN0IHJlcHJlc2VudCBsaW5lYXIgbGlnaHQgYW5kIGtub3dzIHdoZW4gaW4g
dGhlIHBpcGVsaW5lIGJsZW5kaW5nCj4gaGFwcGVucyBpdCBjYW4gbWFrZSBzdXJlIHRoYXQgdGhl
IGRhdGEgYXQgdGhhdCBwb2ludCBpbiB0aGUgcGlwZWxpbmUKPiBjb250YWlucyBsaW5lYXIgbGln
aHQuCj4gCgpUaGUgb25seSByZWFzb24gdGhlIGtlcm5lbCBuZWVkcyB0byBiZSBpbnZvbHZlZCBp
cyB0byB0YWtlIGZ1bGwgYWR2YW50YWdlCm9mIHRoZSBhdmFpbGFibGUgSFcgd2l0aG91dCByZXF1
aXJpbmcgS01TIGNsaWVudHMgdG8gYmUgYXdhcmUgb2YKdGhlIGRpZmZlcmVuY2UgaW4gZGlzcGxh
eSBIVy4KCkhhcnJ5Cgo+IFdoYXQgb3RoZXIgcHVycG9zZXMgYXJlIHRoZXJlPwo+IAo+IEluIGdl
bmVyYWwgSSBhZ3JlZSB3aXRoIHRoZSBvdGhlcnMgdGhhdCB1c2VyIHNwYWNlIG9ubHkgd2FudHMg
YSBwaXBlbGluZQo+IG9mIHRyYW5zZm9ybWF0aW9ucyB3aGVyZSB0aGUgbWVjaGFuaXNtLCB0aGUg
b3JkZXIgYW5kIGlkZWFsbHkgdGhlCj4gcHJlY2lzaW9uIGlzIGRlZmluZWQuCj4gCj4+IEhhcnJ5
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4PgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
