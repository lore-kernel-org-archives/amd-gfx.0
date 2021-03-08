Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE05C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D8464ED0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D8464ED0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94276E882;
	Mon,  8 Mar 2021 20:36:49 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A686E882
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 20:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5tchaR6zEtBGAVXIaJWLODsQugva01dz2NMqrjipDAeFf2/24ESViKkvJkv9/3VGeLHLEFIK5cIHtUDazpkBPeipxCiXocOoWwGCnPpdI6IDm3cSyDG3Nosm3paTGEKhN85l3iUrsti2X3q2NBp11Z1hlgG0QHXMVp8YR+lGQahHQiwXgVhPFl5ls08PcxwNYADXzeXF1+n1a0FT3y6sG/vD5NI5ZTWCqarU8qKmpDMnTyGnf79jQIcbzss8D7GUyI8oAUK0PU9rp+s5JfoMy0bAvOgDPraQpsBQxW+JUcji9Hlr3+3uO2MCeY6imjoj714hlGCMH39ouGFsNhc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8wlYnEKi3R0RFfktpV+tMPp+7470sPUjn4se3TvIxg=;
 b=ftv3wEEsej5A5FeOMIPqeF/m0aSEi7fCpoYeLiBQBIHoPs9gxGWs3nIfmKc6uZ9W6tFmoEfRxJNMdJS9cRuxk6gyDCYgL9QIkJow3N5MyX7fTkBWc1uUsgY46k4fxD/Au7gsiqBblxyhgF5tjvAVxif+m/NQMCpBtq9kFSiyh++x2Bq/4xNmkCgMa37eHJlSllk7SvvmPHULUkYzKk2/GOcEX2OM4xiyTynrH5DfFi7XOG1PkZsGgmQ81rHmqtt6LF1mR/aXxtTwxlknD6BVbZO0uBr39gsErsBLsbOym7f3REIoUHK5D29f2ys/a+gTFPy2Nt8ZmjEigREpnoW19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8wlYnEKi3R0RFfktpV+tMPp+7470sPUjn4se3TvIxg=;
 b=VYPxodoXQHqsFK4N/eVZv15B+TpweEwIt4MEwxk1Zgr/sCbS2NIWIX1XQkhvdyJubQ7F9pVBgNPAWkI6nT+X2QZS2klGut9toAfQhHQZ1AST4Gu4jcJRgPa9GdXWS3gI6WxVL1tSN8gJhXyhoWI7MOxaRnbJDo+32sraQ/mesG0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2354.namprd12.prod.outlook.com (2603:10b6:207:44::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 20:36:46 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 20:36:45 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: fb BO should be ttm_bo_type_device
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210308153705.37414-1-nirmoy.das@amd.com>
 <20210308153705.37414-3-nirmoy.das@amd.com>
 <409b3da2-1f31-89f8-be28-0fb7854d594d@amd.com>
 <CADnq5_NJJu3h==aqvhx4Cb+ScD4Yk6PtktYOxWxreBa8trL5oQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <632651ac-d622-f34c-6af5-aa787dce44be@amd.com>
Date: Mon, 8 Mar 2021 21:36:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CADnq5_NJJu3h==aqvhx4Cb+ScD4Yk6PtktYOxWxreBa8trL5oQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:2b85:c5c:9126:a9e4]
X-ClientProxiedBy: AM0PR10CA0125.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::42) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:2b85:c5c:9126:a9e4]
 (2a02:908:1252:fb60:2b85:c5c:9126:a9e4) by
 AM0PR10CA0125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 20:36:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44508498-97f2-4561-9211-08d8e271e3e5
X-MS-TrafficTypeDiagnostic: BL0PR12MB2354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23547DC83CD02D2CBCEAB61783939@BL0PR12MB2354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/32/idvvGLxEWWltTR1dcwdTc88d0NJf/WFHRz7lbT6ECIjrqHnLZlMDlPA25enGmZD5llrKGOm67tbEwcHcbM3eEyPVe05CpbqT3CxDeAbm1BvdN3hER4rX/i05+6UJU1i0idAV7Oo5jHpS+pVVq6Ln4Zj6l1Vs7bwgaAlO2MYll977E+e/RzA0xXSh+Gy5ZrFwZS/3eYDFuspf+7V2ZtP8848nVhtlwpwW/No0bUZP0hnF4TiNO9Hb1zFeV0PPLF4WGY5TDyXEU4tlOgcRsLuRPafVio/or3e/wSdJv4uf1KKAxO1NEv3DzWRCzlK0nLcWP8YvdmQr9JkskK3pYqe8ybG328KEqOeCTPnb3c+vs5W1bSCtSjdsvQVwYb5VCqQJRedEfwxuJXEm4HrEQ0Uc2EtqKGhLzuTq3v/SHcDeLaZ2XhDMF/XNBUcFtRI+bSpnCrW2PAjg+vYt3Ab8LAnLUZlIXuiU9FoJlgWi8Dt2Mlvu9WndrYWOEcrA/LA17/uo3Ergwj/QOqUlfg4e2n5LG7YRrzNKcvlUsA5d681FqLbj9L5lIUsSvMjH/UE/FmS9gVH3XoVB54yLBnkP+iz3IqBgp2CXA+3PzXKg1P3iGgtbRCZgzllRZ4fC5kw/kEVLwbGxAKOOfhY/9vGUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(5660300002)(2906002)(966005)(52116002)(6916009)(8676002)(66574015)(8936002)(45080400002)(36756003)(478600001)(2616005)(6486002)(86362001)(53546011)(31696002)(16526019)(66946007)(6666004)(186003)(316002)(4326008)(83380400001)(54906003)(31686004)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TFhtNGVxSTFCZWw3MVJkVnNWdGZZYVg2MTJsNDRZN0pCU0lBeTI2S0xsSkFm?=
 =?utf-8?B?NFhjTHpvV1NablpHc1pGVnc0bnNSMStMUVNLdWZSZjJVNDhFRE1wRnNrR2k0?=
 =?utf-8?B?djdVdFRSVEV4cTliUklGbmtPK09tR3E5NXlVWVNSYmdUYkEzc3BsQTZaclZr?=
 =?utf-8?B?b0xRN1pEWG96MXBSbFZSbUo1MzNhMzFTK3dDZ252TGptQlBId0l3YUVCcDc5?=
 =?utf-8?B?VUwyeTUyaGlZVW1tREJiWldONEJSd2JVa2x4Y25SallxNTY5Vkh5VDdQcEtT?=
 =?utf-8?B?MHBxZGoxR2V5MmVUV29QWUJRb0FBd201M1hhbVNySDdJbTZETlorRlU2VTN6?=
 =?utf-8?B?V3RROTg1bzd4UjR2eEp1TS9JUmptSXBvR2tnMXgwWUxOUjVBb1NnVloxNzZa?=
 =?utf-8?B?dlpJS1BXYi9lMWpsSkZSRlRUdmJpcmJYUVlkV3NUUURDTnlNeVN3UXRHNFlR?=
 =?utf-8?B?aXVhSEx1VmhlditTR3QrY054MlhWTWJQUHRCUWJxazJwb0w3cUU1ZHVOeFJ2?=
 =?utf-8?B?aWdEUGdMbnAvb0VVSVJiY0RBay9wa09nOWpLcG05Z1BIUXBhaTNBV1VKbWox?=
 =?utf-8?B?dnRxemtKNjBaVmdQdUFlMjk4d1ZJcUROcE51S3QwU1ZjWHQ2QVpKaWlVSHow?=
 =?utf-8?B?NTJnSlVIVkdjUnpjL2dHVVZISkNqaTJPQk42bTVtQW0rS0psTE54a3lpWnVI?=
 =?utf-8?B?TGVnWWJHNVdvdlRQV0VlZWVtcFRJbTlRWkxyeDdkMk4yTytQSStaTi9HU0h1?=
 =?utf-8?B?M3JKZHcrekpRUU1vYW9UUTc5WVhqdW1pNCtlY2NDMGd1bkxXRmZsa1dFY0Nx?=
 =?utf-8?B?WTZ6SDh4MFUxbDdOUEN0YkxESldFK1d0VnUxUjd0ZzZub3h0NmlXdXkvMzVS?=
 =?utf-8?B?VlJxdUZoUHpHS1lObDRtSUJtZlYycnpqdTRjeWppdkViOWp0YU5tNVhhMzJy?=
 =?utf-8?B?WE94V253YlBtellpbS9IU25VSUVOVTcvTkY1SlBNS0JQNW05TEsvRFJUTUQ5?=
 =?utf-8?B?WDJjblNWaTlPRzhBc3NVb085TTdCTjFFTFpJbnBhYUpGbUxUMndadGRsUVlE?=
 =?utf-8?B?OWFxUjNPMkRVY1I5eXc0N0VUYTMvelVJNVd3eU1RUGFrcjFBRHBDMFdHZGhq?=
 =?utf-8?B?VG5EZEdpZDdsRDUyRG1HMTdONlJnQ1EyWkFkdFJUSjdxV090SStJSkZIRHEx?=
 =?utf-8?B?ck5Oc0UzNE1TNStJQkpTMDhwNXBUakhTY2dCY21PY2NGSXgyZXZydm81SSt1?=
 =?utf-8?B?aWxGL1BYNG5XdlQ0ajVmclozUUlwcENNN0NVQ0x1cVpCWFMvVzIvUW1FTE8y?=
 =?utf-8?B?QW5uQU5ONUJJcktPT1lVaDlnZmVmS1V1WHpuRFRXMDdYWWMxU3IybFZ1c2pB?=
 =?utf-8?B?U3Z5SnJ3d1NFVmt4Q0FXMWt1VEtjeVNJR2JsK09tbU43d25VN1JYdzhBNGZ2?=
 =?utf-8?B?K0doRG52cCtacXVtRmFLNUNja1VKMlRncmFNRDJXU1ZCY3Z4SlhtOENyaURL?=
 =?utf-8?B?K0RXNEQ2Ynphb3lLdklRSUpmS0c2R0Nyai90SlFwaVFEMzlPVG0zaWN1QzJu?=
 =?utf-8?B?ejgyUHRxVEZRVWc4Q21yYXJ2c0VsUmVROW1qWHRSM0FNNytSeGxrbTc3aFpX?=
 =?utf-8?B?SGowdWVmaCtVbVZkZ3BpdHEyR1F6RjF0NUQwZVdvcFJiWkc0cjdmRjdWZGdq?=
 =?utf-8?B?ODYvMEx0blBmYXhCams5d3NVT3o4TWgzbUFSNHVnaDlMWjc3bTREYkwvd2Jy?=
 =?utf-8?B?cHRIbGdFVWVMektCN1dVRVJ4TDVDMjhJc1lHOVBkNlp3UmRZdFNYeXkyR0RL?=
 =?utf-8?B?aVAwemczTWpBNi82Ujg1bkppeWswVWgvRDRJdFZ5czlOd05NSHQxS0ZXNmJj?=
 =?utf-8?Q?QMqXlnNJhkfXS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44508498-97f2-4561-9211-08d8e271e3e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 20:36:45.7359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoaSc44zantmWwfqvj5V+sbrCYZFM8k56tpeC0DnrrP3g2S9jRx8sXszsQVau/mr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2354
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDMuMjEgdW0gMjE6MzQgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gTW9uLCBNYXIg
OCwgMjAyMSBhdCAzOjIwIFBNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4gd3JvdGU6Cj4+IEFtIDA4LjAzLjIxIHVtIDE2OjM3IHNjaHJpZWIgTmlybW95IERhczoK
Pj4+IEZCIEJPIHNob3VsZCBub3QgYmUgdHRtX2JvX3R5cGVfa2VybmVsIHR5cGUgYW5kCj4+PiBh
bWRncHVmYl9jcmVhdGVfcGlubmVkX29iamVjdCgpIHBpbnMgdGhlIEZCIEJPIGFueXdheS4KPj4g
TWhtLCB3aHkgdGhlIGhlY2sgd2FzIHRoYXQgYSBrZXJuZWwgb2JqZWN0Pwo+IE1heWJlIGJlY2F1
c2UgdGhlIGZiY29uIHdhcyB0aGUgbWFpbiB1c2VyIGZvciB0aGlzIGhpc3RvcmljYWxseSBhbmQK
PiB0aGUgY29kZSB3YXMgY29waWVkIGZyb20gcmFkZW9uIHdoaWNoIGFsc28gc3RpbGwgc2V0cyBp
dCB0byBrZXJuZWwuCgpUaGF0J3MgbW9zdCBsaWtlbHkgd3JvbmcgZm9yIHJhZGVvbiBhcyB3ZWxs
LgoKQWxsIEJPcyB3aGljaCBjYW4gYmUgbWFwcGVkIHVzaW5nIG1tYXAoKSBpbnRvIGFuIHVzZXJz
cGFjZSBwcm9jZXNzIApzaG91bGQgYmUgb2YgdHlwZSBkZXZpY2UgaWYgSSdtIG5vdCBjb21wbGV0
ZWx5IG1pc3Rha2VuLgoKR29pbmcgdG8gZG91YmxlIGNoZWNrIHRoYXQgc3R1ZmYgd2hlbiBJIGhh
dmUgdGltZS4KClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQgTmlybW95LgoKQ2hyaXN0aWFu
LgoKPgo+IEFsZXgKPgo+Pj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0Bh
bWQuY29tPgo+PiBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgo+Pgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZmIuYyB8IDIgKy0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCj4+
PiBpbmRleCA1MWNkNDljNmYzOGYuLjI0MDEwY2FjZjdkMCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwo+Pj4gQEAgLTE0Niw3ICsxNDYsNyBAQCBzdGF0aWMg
aW50IGFtZGdwdWZiX2NyZWF0ZV9waW5uZWRfb2JqZWN0KHN0cnVjdCBhbWRncHVfZmJkZXYgKnJm
YmRldiwKPj4+ICAgICAgICBzaXplID0gbW9kZV9jbWQtPnBpdGNoZXNbMF0gKiBoZWlnaHQ7Cj4+
PiAgICAgICAgYWxpZ25lZF9zaXplID0gQUxJR04oc2l6ZSwgUEFHRV9TSVpFKTsKPj4+ICAgICAg
ICByZXQgPSBhbWRncHVfZ2VtX29iamVjdF9jcmVhdGUoYWRldiwgYWxpZ25lZF9zaXplLCAwLCBk
b21haW4sIGZsYWdzLAo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR0
bV9ib190eXBlX2tlcm5lbCwgTlVMTCwgJmdvYmopOwo+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHR0bV9ib190eXBlX2RldmljZSwgTlVMTCwgJmdvYmopOwo+Pj4gICAg
ICAgIGlmIChyZXQpIHsKPj4+ICAgICAgICAgICAgICAgIHByX2VycigiZmFpbGVkIHRvIGFsbG9j
YXRlIGZyYW1lYnVmZmVyICglZClcbiIsIGFsaWduZWRfc2l6ZSk7Cj4+PiAgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUy
Rmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDY2hyaXN0aWFuLmtvZW5pZyU0
MGFtZC5jb20lN0NiZTQxODlhYTM2M2M0ZjY1ZjM4MjA4ZDhlMjcxOTQ5ZSU3QzNkZDg5NjFmZTQ4
ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1MDgzMjQ3NDU3MTEzOTQlN0NVbmtu
b3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENK
QlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9Tll2NUJhRmhVN2hh
aFZuTjRlMDg2UUZ2NzFHQVhFWkxlRm5uMmVzSzA0byUzRCZhbXA7cmVzZXJ2ZWQ9MAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
