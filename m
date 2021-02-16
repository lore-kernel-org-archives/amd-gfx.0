Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00553C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 15:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A39161606
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 15:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A39161606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D6FD6E432;
	Tue, 16 Feb 2021 15:24:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFEF6E432
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 15:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdpDcao5bgEyMi9FWBb0tPBr4N6J36ibrmppuvY/sKgEwQpJCJEszkEl8kkcJaE6o3sFkCzRipptmacnS30QhW4SPdvlzcGFXsnxpsLWCf4nMy62v0OCHgtNQBKIoCF69Cw92wtn6m6EMDNdcq8eUTKsGqz4ldNm2DGoybWqpmFdbpUltQ7IC3o1hr1fHJyp2ogeo+KhImpMuSOyXx7lvuJjf590TVvigaLfTO4nJCXK0QSsrDJjzzeNBLzXmefyzYiVP3Mrpdad9E4rxIT3n3pQ6/cxQEyXevxm3rfAO6Ej7FrKos2SVWnKgVTYJRxuBWdC+kaTKof6HDt9olXgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1/LjgppX+JRbPUwkI/RZIsJ4lj29MTwXm7PBUS0GlM=;
 b=nkSvTKm1LLZokd4yIFhnLiq+BrZf42JgCbVCS536NUlPz2969br9G2gfYsyviM0gAgo7bYTSO40YRjQMsw1W+Nfhx9wa/6dWd5CEyaHHDtlVf+LjEUxxGgjQT6K1W+UwkfBExgR64K3oY0tpnSMyEP10/u8uAig63BfRRqdqZxKh8Y5GMSFnTZ6ANrc8Qd4YlcbQL4skD2w5D+7bsu7os0JZzyzK5q22o5WF/y0law8cw4yDETFABdMytgOmMhbguT8dPcdqTrD7lO4l8/L52Q7sIaS9QzBxAaSOQ6xgMLfL5Udy6Xa/5m0HA3RA4hBS/sfLUMNf7kdfOJeSFij0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1/LjgppX+JRbPUwkI/RZIsJ4lj29MTwXm7PBUS0GlM=;
 b=t/8ycHJj6oyBpGz23Rtj1iNwp2msGAfB+XuwYdaltxrakaJWVdsrDR+NqWoAaudJ4M8DJrNbm2AO1ubwjmUjv8ILtbE1DIYcGlM17kegPrPKsB5aTEgr++R2+gu5VjiHj+VsCE0PqfhZfu4n1UsTki9R/08TMAr+oy5aO2n381U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Tue, 16 Feb
 2021 15:24:00 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3846.038; Tue, 16 Feb 2021
 15:23:59 +0000
Subject: Re: [PATCH 1/1] drm/radeon: fix compilation error
To: Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com
References: <20210216152216.50637-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <91e1ff6b-0018-43b5-f997-76611d5ba478@amd.com>
Date: Tue, 16 Feb 2021 16:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210216152216.50637-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:47a7:bac2:5556:22a8]
X-ClientProxiedBy: AM0PR03CA0013.eurprd03.prod.outlook.com
 (2603:10a6:208:14::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:47a7:bac2:5556:22a8]
 (2a02:908:1252:fb60:47a7:bac2:5556:22a8) by
 AM0PR03CA0013.eurprd03.prod.outlook.com (2603:10a6:208:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Tue, 16 Feb 2021 15:23:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e544ea06-c558-43c9-9f49-08d8d28ee231
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41108ED37FD1CB8982CE968E83879@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRVioQaGp+c54HbOwIV760TgiDyvOy0sAgQAamBRjuN63p+8fad8EEB0LD6f9W5bocwzHA02CflJgcke57DalrBfCIqEswmJsXr4uhwNIYBS8muwfJK44+MKcIPylSIsc/58EMcf3NVwY1GzXHwK5rH3vO7poD1rAf1YHGI+NWx5oCkmKqd7dJZ/TNJUKNPhGZNStnDZrJ6eSJ7kWZl2+m26REIHALELTumVAdxKIULj9nXGnOkfSF7PJCF+WmV52bg5ms00+Em//w8VbY/VPQzYlkxkkK4jxrX/9swaSGCKaayTKzI/hWvTTCHMfzpAymSpGoDQKn5Ik4QpPFlEoPXL4lDXsBcefsd4cCX0JmHoAQzzRDeb7p/MEqj6eTVWN4BWrGdJGymO55YIe+v+YAisN/UljqXeMMEVnXdCyIHidvoPRTKfqTfk3RCHNupu1/qBI/zsugamYy8cK5gHc/1whGwNipgDObFh89sJNSruBYG9POLZXMxxCsY34Yv8bFCHBL1Vj3nznVFdA9WJdYvzs1+wp36jMR5qOvqh7buEPUbk2IMrvYFqK2Aoa0V+TepNOUunbcJgIJbAj+c+St7vePTA9ozryMcCb0UZXLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(36756003)(8936002)(478600001)(6486002)(8676002)(316002)(4326008)(31686004)(31696002)(16526019)(2616005)(6636002)(5660300002)(66476007)(52116002)(2906002)(6666004)(83380400001)(66946007)(186003)(86362001)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K3AraUpPQW9yTWJjRCs2OHZRWXgwUGdiYzIrcFNZbFZjZnRaUEd6ODU3dTFQ?=
 =?utf-8?B?WDgrRzlYZTNGZnhEQjJhS0JFc2xXVDZocnU1dzZlcTRqSzl6ZE9zZ1kwbXBy?=
 =?utf-8?B?dHY2NE85eFNHaHlKSjlVdllZV045NnNiOUt4RUxiUFVFMko5b0c5UGx3NkVp?=
 =?utf-8?B?aU1zSlJPMXVrMzFwU3I5QmQ3dU1mazFYYkl1ZWp1SWViYXVkNHMzK0w1ZW5X?=
 =?utf-8?B?WURnMnN1QnZjNU9hQTkvdlU4Mzk4eUtBczluckVYRk1NUFVJcWxVbWNRNTF5?=
 =?utf-8?B?RVd3VUJqZG0wRmlNR1RVRHYyL0lFcGQxL0NLeVg1N0k4eEx4OTlnenJTSEgy?=
 =?utf-8?B?NnJxenVJbUQ1WEZHamxDdi9vcG1VTTYrOWtlT2RGUXNXdDRGVXJ1aTVOa3JX?=
 =?utf-8?B?aU9WLzlZNlBYeFhOSU96M1RQRXZxR1ZvdjV0TWl0VVJ4NjhJV1IwclZKK1di?=
 =?utf-8?B?dUorcHRnemdYVUZhUHBiRE1oV01SRTlldThZM2t4QTJDTG96L2xsSnJ6MmdO?=
 =?utf-8?B?MkNqWHBzcld6NmhxanhJTjRZSnBVUjNzc2VDM2F5RWxXOFd5N0xlRkovZlkr?=
 =?utf-8?B?MTdvRzRONWQzQ0p2RUNCdFh5bVNxTnJsMUZub1IwM2pGdWxrN1p4Q3FYSlpj?=
 =?utf-8?B?UGhzZVpNTmJIcGRIeTRyaFQrWDhzQjFsVnZnT2t6Z05lV0FMcDJxWkRwclAw?=
 =?utf-8?B?N0VrL1VtQ3JIcHF1V0F2andJWWswNjhGVGkvNFh2b2xnbGhmS3FHL0JTb1hG?=
 =?utf-8?B?T2hRRFVyKzBob0t3aGY4bCs0aEZTa05OYU9NM2d4TXd6SEhjc1RsZ0RQeE83?=
 =?utf-8?B?K2FCbUhMWWJQVkNERGZKc2hpRG91TnkzN2hmUEhrU05taFoydzMzNVFSUlEy?=
 =?utf-8?B?clRDNkQ5UTdrRExmcjVMUHJsQUJoUkY2UnBCbCt4UHJYcEZZbk4yb3dFcGQ2?=
 =?utf-8?B?aDE0UnN4K1BkOGRkbXFGYVRJa21KQTBTb2ppRmJjcmt4eW9wbmUwZVFMRWV5?=
 =?utf-8?B?K2tKalViL2o1dWJ5R3ArTkZWN1VPSEc2TG0rNVduVTJSMitxK0ptYWxOc21w?=
 =?utf-8?B?UXJ3MjVUN0dlU0pPMzZ1U25tTU1Sbi9PUW1WZE82VEppWHdvVWNpLy90anRS?=
 =?utf-8?B?WFIydVNjeGlWTlovVlhmZGs2VXEwdmVHaTlyNUNwcFNtcmpTaUlkOThaOXVm?=
 =?utf-8?B?TG1KWFNKTkd3bTF3SGRadXJEck1oVnBjTmNJZ0RtUkFDaFVyU0E1cVVTUUxl?=
 =?utf-8?B?cDJnVVVoUHVnQSt5QkwrcFgvaTYwUTJNQnFXaTBxSFdPYjlYNzNuM0tPb3FI?=
 =?utf-8?B?d2ZDT3BPS05Ob2k0aHBYQjFuOC80N1pQVTVkMGJBTGJJN1ZYN2l1eWpHb3I0?=
 =?utf-8?B?MW8wOUlZa24vQ0V5ZkMwdWtqcDh1ZzNVbThrNHVnQ1FIODdDM20rSEp2RWt4?=
 =?utf-8?B?SXdxUkQzMGdkUDdNZUpTczZHMlNvaG9jWDhrNXBXd2RYQzNCbmJ5TGtSdUpR?=
 =?utf-8?B?TmxxR2grSVN5S3VrOE9PUU9JR0hjZ2EySWdKOXF0ZnBjT2sxMVZlRnlEZWNL?=
 =?utf-8?B?L0pvWXVvam5HY0E1U2NJU013allUNmpJWHVxNEVEMThEaXhtOFVsZnlNL1o1?=
 =?utf-8?B?V24wTlZtbDd5OEtqaTZ0SG1JSVAvYW9sUmExSWRJbDVzalJGRDNzNkFudFdW?=
 =?utf-8?B?ZHBpMWg1dkRyY1kweFNBN3kzWDRvd3doTGJ6cTBIOEV4MVF5YktkSytvSjhW?=
 =?utf-8?B?VnVSSE92eWs5bThtaW1XOXhCTXZYYlZ3clVVTXk4bzA4a2x5K3VDenhXNkJa?=
 =?utf-8?B?MUxtdXVOUmplcEJoOFF1S1RUU24zQXl5QmhVc1pCYW9wSERJVFc5eDZMOWdh?=
 =?utf-8?Q?aePlJvOuLFseK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e544ea06-c558-43c9-9f49-08d8d28ee231
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 15:23:59.7155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nhzIQndd4lrCiCg1+kj1jSOsQQMTonhJUy+KWVcVC+dcts9GrBWQmQcA+wCmj9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: Mark Broadworth <Mark.Broadworth@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxNi4wMi4yMSB1bSAxNjoyMiBzY2hyaWViIE5pcm1veSBEYXM6Cj4gRml4ZXMgYmVsb3cg
Y29tcGlsYXRpb24gZXJyb3I6Cj4gY29uZmxpY3RpbmcgdHlwZXMgZm9yIOKAmHIxMDBfZGVidWdm
c19tY19pbmZvX2luaXTigJkKPgo+IEZpeGVzOiA2Zjg2NzJkNjUyM2JmZTM4ZSAoImRybS9yYWRl
b246IGRvIG5vdCB1c2UgZHJtIG1pZGRsZSBsYXllciBmb3IKPiBkZWJ1Z2ZzIikKPiBTaWduZWQt
b2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4gUmVwb3J0ZWQtYnk6IE1h
cmsgQnJvYWR3b3J0aCA8TWFyay5Ccm9hZHdvcnRoQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiBIaSBBbGV4
LAo+Cj4gQ2FuIHlvdSBwbGVhc2Ugc3F1YXNoIHRoaXMgd2l0aCB0aGUgIkZpeGVzIiBjb21taXQu
Cj4gSSBhbSBub3Qgc3VyZSBob3cgSSBtaXNzZWQgaXQuCj4gSSBldmVuIHRlc3RlZCB0aGUgcGF0
Y2ggd2l0aCBteSByYWRlb24gY2FyZCBiZWZvcmUgcHVzaGluZy4KClN0cmFuZ2UgSSdtIHByZXR0
eSBzdXJlIEkndmUgc2VlbiB0aG9zZSBsaW5lcyBpbiB0aGUgb3JpZ2luYWwgcGF0Y2guCgpDaHJp
c3RpYW4uCgo+Cj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IzMDAuYyAgICAgICAgfCA2ICst
LS0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5oIHwgMiArLQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMzAwLmMgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3IzMDAuYwo+IGluZGV4IDAzYjBkNGE4MWY3YS4uOTI2NDNkZmRkOGE4IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjMwMC5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yMzAwLmMKPiBAQCAtMTMyNiwxMiArMTMyNiw4IEBAIHZvaWQgcjMwMF9zZXRf
cmVnX3NhZmUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gICB2b2lkIHIzMDBfbWNfcHJv
Z3JhbShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldikKPiAgIHsKPiAgIAlzdHJ1Y3QgcjEwMF9t
Y19zYXZlIHNhdmU7Cj4gLQlpbnQgcjsKPgo+IC0JciA9IHIxMDBfZGVidWdmc19tY19pbmZvX2lu
aXQocmRldik7Cj4gLQlpZiAocikgewo+IC0JCWRldl9lcnIocmRldi0+ZGV2LCAiRmFpbGVkIHRv
IGNyZWF0ZSByMTAwX21jIGRlYnVnZnMgZmlsZS5cbiIpOwo+IC0JfQo+ICsJcjEwMF9kZWJ1Z2Zz
X21jX2luZm9faW5pdChyZGV2KTsKPgo+ICAgCS8qIFN0b3BzIGFsbCBtYyBjbGllbnRzICovCj4g
ICAJcjEwMF9tY19zdG9wKHJkZXYsICZzYXZlKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
YXNpYy5oCj4gaW5kZXggMmM3N2YxNTFlZjYyLi4xY2YyYTVlMGQ5MWQgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5oCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5oCj4gQEAgLTEwOCw3ICsxMDgsNyBAQCBpbnQgcjEwMF9w
Y2lfZ2FydF9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiAgIHZvaWQgcjEwMF9w
Y2lfZ2FydF9maW5pKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiAgIGludCByMTAwX3Bj
aV9nYXJ0X2VuYWJsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gICB2b2lkIHIxMDBf
cGNpX2dhcnRfZGlzYWJsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gLWludCByMTAw
X2RlYnVnZnNfbWNfaW5mb19pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiArdm9p
ZCAgcjEwMF9kZWJ1Z2ZzX21jX2luZm9faW5pdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7
Cj4gICBpbnQgcjEwMF9ndWlfd2FpdF9mb3JfaWRsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRl
dik7Cj4gICBpbnQgcjEwMF9pYl90ZXN0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBzdHJ1
Y3QgcmFkZW9uX3JpbmcgKnJpbmcpOwo+ICAgdm9pZCByMTAwX2lycV9kaXNhYmxlKHN0cnVjdCBy
YWRlb25fZGV2aWNlICpyZGV2KTsKPiAtLQo+IDIuMzAuMAo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
