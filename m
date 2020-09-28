Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B2DC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC73205ED
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X10ODcYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC73205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F84E89F07;
	Mon, 28 Sep 2020 20:12:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8147F89F07
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 20:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK9Rrkt/RTtET3claQsJVKK9btloQx/DOubPIrzCeQaL3vX2jemIga48yHbDr2INWWPHkdIyk0IrQIE55bKhNfuKCRUL00e1CKQkVHEMzQgOakvdVBATxigL2TY9sPZUwcmBz2BfxF//9g1ifPljsq2PFf3r4PXcltTbhxeBn6X1zvXrxoZpjbOiO0LIwSyNWkUJnOb38fumizlhuPHyITJcCxLogGg753hpaWHw3R8Fh4fBfbVZZQlVxoFZ9zHv6a1huwHqYvG23P8nMf8B4pn9BygHvQd9bVhsDT+4UXYRGkSx/XUNj1Kt6n1hKArhkehHaMQjmwHeivSHcNX10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuX3VVJ9xgJ32UHEnSKeNNPETBM81kxKtngY8rLqy4g=;
 b=ayG8uO8t9xyeX/zDAg/eBV9ezBEAQOVZ7LRksARxMl3IoTy37HD+Uc99UGe7/+njBNIe7ECXoglFZGsE7RLwEJHn3ULQjolCr9wBIoMFMYl3yVB7gCvNYqAE9LEbi8vymJvH8+hQXvq1GRsYH8FjaxrlRUKADZeWDGkJKHrU0lnkGKhPBP36IbrU3yyZ7H7p/mvEWfkGNfLGkPp2/vNW5gsYJnh1Jp3kgTrZcY501Pi7+2hJHmhebl3UuOXSWGZrkOt4wv1zoDN3/V9t9FDep6TZmSpmlRCW2sAAzaKvxhEDmx+P9UT7rEe/320yoGJtB3ao1ch5EqU5EhEM/e9poA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuX3VVJ9xgJ32UHEnSKeNNPETBM81kxKtngY8rLqy4g=;
 b=X10ODcYfmd49ZTE6f2dRZM5MXP6TUbtzksPtYP5VLyy0WBANcznLtc9q9uNjDlZVGXRoHpFpzp0mATAniOSovD/f7t94GTg46vLfvn3yWkp4saDPR8ap43etdnBgYjvhcT++0X7TvYq/dtp/ESz/6tCXCOnWWClcR6Byf27b+hE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2919.namprd12.prod.outlook.com (2603:10b6:a03:12c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 20:12:06 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101%6]) with mapi id 15.20.3326.030; Mon, 28 Sep 2020
 20:12:06 +0000
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
To: christian.koenig@amd.com, James Ettle <james@ettle.org.uk>,
 Harry Wentland <harry.wentland@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
 <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
 <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
 <CADnq5_O8Wzddr3LryTuQ5Jqc5yt51wqkxv6zbSbr0_RBSQCA4g@mail.gmail.com>
 <967f82b1-cf5b-473b-c9b3-d9f9df588cc7@amd.com>
 <ad59a8c59d52c40a89b7b4fd032df043e0747f27.camel@ettle.org.uk>
 <6583647a-7147-4f5b-0412-d3be77ca7fe2@gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <aa941ec6-994e-30c0-74fc-0d13734204bf@amd.com>
Date: Mon, 28 Sep 2020 16:12:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <6583647a-7147-4f5b-0412-d3be77ca7fe2@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 20:12:05 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e16a4c8c-cc4a-469a-cd8b-08d863eac589
X-MS-TrafficTypeDiagnostic: BYAPR12MB2919:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2919B42448398FDA32902F7AEC350@BYAPR12MB2919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkX7UchkGy8dT1nNIJp2NvP/4oavUyLXgBiBwATX7VSsCodU25l7TdjhlIrNYkoWvy5aDBhLJJgLwm4YX22hAaCG4sgtcOxhfkR24z/mzSMu3reth5k2OLIRR+ZNYwqYpahfpaTwxwVcrfBkIdUWrao9LvyJ5GnMwiBXvWg3FKXQUSbN/EqhuZyufXJ/gJ90ibws6rVH/b7h9bMUb8ESgUnbuoPm9GOzieUNiIioGdKPzTE4qxZVSB3Sr/vntTj+Pc7OHuc4WGgTowr2qy3/kagpLC21jnZitZx7DjAmrt2jp51Nl9HMQ1R4XDpmcCHNUh4OmGSb4ZcNZas3syshkEr/8bTbD7VEY0+6s4RZxVy3qwayHgIw4TI/hF6AY2cuqzKfbghmU6YU6Ckhc3E2YfeDDihgI1QgejSqnbwRNbxZy2fDQ+MbgH5cobRB0XR/bIoXOE+Fe+M7qdBbGSjvSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(2616005)(956004)(478600001)(31686004)(966005)(66946007)(186003)(6666004)(16526019)(86362001)(26005)(110136005)(316002)(54906003)(16576012)(4326008)(8676002)(31696002)(8936002)(2906002)(83380400001)(36756003)(6486002)(66574015)(53546011)(66556008)(66476007)(5660300002)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YTI7yTnHBSuAO+uaLk5ANWbaEB4Lf0+PbalBlin7NNGA4miV9KUDcRMurTGJgsxyLeUeI79SGsW6bJu2g+/rz2QmEUNvVbUz1+MEJA7yZfnU32el0NEmxgFbGNnOT7VmMPO61BQeWCrn2r4qeFQjNmjU3D/hUbkkxhUIjnNOtGV4IYM6dgaxcT1cambxyLAW6yio/UCNFsb9jGSHbeNgleO2IIhLZ6+D3SzE6J5ebj7EIjRL1t/5rBeerLYOl/QyqdxpXT6oUR1uebiPpr0BxCEQDnW5Tfiqw4twIZu6+OlatYtH6tPDBdxFVCyr3Xq8zJgxhFgDdn3QQx7J5fC5TZqUmiF+bN8sGFH0ONvwdbY86bQ0Zs8dsWl5C/3h4VH41jYJCL1UxpnjWTr5Viz1umU2w2ZtSx2g0Fcm47KffaAflP7LJzvwu8BI2MfvL53yam1lxjbWsPn7qFzBzkjjHp+6hSF/EcRlfu4v6ZxDc/YS9vsPSgJ1kIR7cb/3BWIwwPmMNPxYiKhXaCrxnYj4LcsF0x6GYKhTdbtlEiXAZRrdlTZbfqzVoCX4LsFEd1g+nAT2chd66v/uSUcJ4eaP84+MUx/xZtm9ARPh90e7Ugu+7lYO2ob5y8QgBP2BsYNHmlt4Ud/+OFHqZWMcVMKehA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16a4c8c-cc4a-469a-cd8b-08d863eac589
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:12:06.4342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAfyExDs3Al3vwxIUvJT0xkraL6URQ/NMmGTK7yol9CGmn81CzQnwOK/XQYH2qUnXFpjXhetDnRvMeGDeoU+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
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
Cc: Harry Wentland <hwentlan@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wOS0yOCAzOjMxIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjgu
MDkuMjAgdW0gMTk6MzUgc2NocmllYiBKYW1lcyBFdHRsZToKPj4gT24gTW9uLCAyMDIwLTA5LTI4
IGF0IDEwOjI2IC0wNDAwLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPj4+IE9uIDIwMjAtMDktMjUg
NToxOCBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+Pj4gT24gVHVlLCBTZXAgMjIsIDIwMjAg
YXQgNDo1MSBQTSBKYW1lcyBFdHRsZSA8amFtZXNAZXR0bGUub3JnLnVrPgo+Pj4+IHdyb3RlOgo+
Pj4+PiBPbiAyMi8wOS8yMDIwIDIxOjMzLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+Pj4+Pj4gKy8q
Kgo+Pj4+Pj4+ICsgKiBET0M6IHBpeGVsX2VuY29kaW5nIChzdHJpbmcpCj4+Pj4+Pj4gKyAqIFNw
ZWNpZnkgdGhlIGluaXRpYWwgcGl4ZWwgZW5jb2RpbmcgdXNlZCBieSBhIGNvbm5lY3Rvci4KPj4+
Pj4+PiArICovCj4+Pj4+Pj4gK3N0YXRpYyBjaGFyIGFtZGdwdV9waXhlbF9lbmNvZGluZ1tNQVhf
SU5QVVRdOwo+Pj4+Pj4+ICtNT0RVTEVfUEFSTV9ERVNDKHBpeGVsX2VuY29kaW5nLCAiT3ZlcnJp
ZGUgcGl4ZWwgZW5jb2RpbmciKTsKPj4+Pj4+PiArbW9kdWxlX3BhcmFtX3N0cmluZyhwaXhlbF9l
bmNvZGluZywgYW1kZ3B1X3BpeGVsX2VuY29kaW5nLAo+Pj4+Pj4+IHNpemVvZihhbWRncHVfcGl4
ZWxfZW5jb2RpbmcpLCAwNDQ0KTsKPj4+Pj4+IFlvdSBjYW4gZHJvcCB0aGlzIHBhcnQuwqAgV2Ug
ZG9uJ3QgbmVlZCBhIG1vZHVsZSBwYXJhbWV0ZXIgaWYgd2UKPj4+Pj4+IGhhdmUgYQo+Pj4+Pj4g
a21zIHByb3BlcnR5Lgo+Pj4+Pj4KPj4+Pj4+IEFsZXgKPj4+Pj4gT0ssIGJ1dCBpcyB0aGVyZSB0
aGVuIGFuIGFsdGVybmF0aXZlIG1lYW5zIG9mIHNldHRpbmcgdGhlIHBpeGVsCj4+Pj4+IGVuY29k
aW5nIHRvIGJlIHVzZWQgaW1tZWRpYXRlbHkgb24gYm9vdCBvciB3aGVuIGFtZGdwdSBsb2Fkcz8K
Pj4+Pj4gQWxzbyBhcmUgdGhlcmUgdXNlciB0b29scyBvdGhlciB0aGFuIHhyYW5kciB0byBjaGFu
Z2UgYSBLTVMKPj4+Pj4gcHJvcGVydHksIGZvciBXYXlsYW5kIGFuZCBjb25zb2xlIHVzZXJzPwo+
Pj4+IFlvdSBjYW4gZm9yY2Ugc29tZSB0aGluZ3Mgb24gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUs
IGJ1dCBJIGRvbid0Cj4+Pj4gcmVjYWxsIHdoZXRoZXIgdGhhdCBpbmNsdWRlcyBrbXMgcHJvcGVy
dGllcyBvciBub3QuwqAgQXMgZm9yIHdheXMgdG8KPj4+PiBjaGFuZ2UgcHJvcGVydGllcywgdGhl
IEtNUyBBUEkgcHJvdmlkZXMgYSB3YXkuwqAgdGhvc2UgYXJlIGV4cG9zZWQKPj4+PiB2aWEKPj4+
PiByYW5kciB3aGVuIHVzaW5nIFguwqAgV2hlbiB1c2luZyB3YXlsYW5kIGNvbXBvc2l0b3JzLCBp
dCBkZXBlbmRzIG9uCj4+Pj4gdGhlCj4+Pj4gY29tcG9zaXRvci4KPj4+Pgo+Pj4gSSdtIG5vdCBh
d2FyZSBvZiBhIHdheSB0byBzcGVjaWZ5IEtNUyBwcm9wZXJ0aWVzIHRocm91Z2ggdGhlIGtlcm5l
bAo+Pj4gY29tbWFuZCBsaW5lLiBJIGRvbid0IHRoaW5rIGl0J3MgcG9zc2libGUuCj4+Pgo+Pj4g
Rm9yIGF0b21pYyB1c2Vyc3BhY2UgdGhlIHVzZXJzcGFjZSB3YW50cyB0byBiZSB0aGUgYXV0aG9y
aXR5IG9uIHRoZQo+Pj4gS01TCj4+PiBjb25maWcuIEknbSBub3Qgc3VyZSB0aGVyZSdzIGEgd2F5
IHRvIHNldCB0aGVzZSBwcm9wZXJ0aWVzIHdpdGgKPj4+IFdheWxhbmQKPj4+IHVubGVzcyBhIFdh
eWxhbmQgY29tcG9zaXRvciBwbHVtYnMgdGhlbSB0aHJvdWdoLgo+Pj4KPj4+IENhbiB5b3Ugc3Vt
bWFyaXplIG9uIGEgaGlnaGVyIGxldmVsIHdoYXQgcHJvYmxlbSB5b3UncmUgdHJ5aW5nIHRvCj4+
PiBzb2x2ZT8KPj4+IEkgd29uZGVyIGlmIGl0J2QgYmUgYmV0dGVyIHNvbHZlZCB3aXRoIHByb3Bl
cnRpZXMgb24gYSBEUk0gbGV2ZWwgdGhhdAo+Pj4gYWxsIGRyaXZlcnMgY2FuIGZvbGxvdyBpZiBk
ZXNpcmVkLgo+Pj4KPj4+IEhhcnJ5Cj4+Pgo+Pj4+IEFsZXgKPj4+Pgo+PiBUaGUgcHJvYmxlbSB0
aGlzIGlzIHRyeWluZyB0byBzb2x2ZSBpcyB0aGF0IHRoZSBwaXhlbCBmb3JtYXQgZGVmYXVsdHMK
Pj4gdG8gWUNiQ3I0NDQgb24gSERNSSBpZiB0aGUgbW9uaXRvciBjbGFpbXMgdG8gc3VwcG9ydCBp
dCwgaW4gcHJlZmVyZW5jZQo+PiB0byBSR0IuIFRoaXMgYmVoYXZpb3VyIGlzIGhhcmQtY29kZWQg
KHNlZSB0aGUKPj4gY29tbWVudCBmaWxsX3N0cmVhbV9wcm9wZXJ0aWVzX2Zyb21fZHJtX2Rpc3Bs
YXlfbW9kZSkgYW5kIHRoZXJlIGlzIG5vCj4+IHdheSBmb3IgdGhlIHVzZXIgdG8gY2hhbmdlIHRo
ZSBwaXhlbCBmb3JtYXQgdG8gUkdCLCBvdGhlciB0aGFuIGhhY2tpbmcKPj4gdGhlIEVESUQgdG8g
ZGlzYWJsZSB0aGUgWUNiQ3IgZmxhZ3MuCj4+Cj4+IFVzaW5nIFlDYkNyIChyYXRoZXIgdGhhbiBS
R0IpIGhhcyBiZWVuIHJlcG9ydGVkIHRvIGNhdXNlIHN1Ym9wdGltYWwKPj4gcmVzdWx0cyBmb3Ig
c29tZSB1c2VyczogY29sb3VyIHF1YWxpdHkgaXNzdWVzIG9yIHBlcmNlcHRpYmxlIGNvbnZlcnNp
b24KPj4gbGF0ZW5jeSBhdCB0aGUgbW9uaXRvciBlbmQgLS0gc2VlOgo+Pgo+PiBodHRwczovL2dp
dGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80NzYgCj4+Cj4+Cj4+IGZvciB0
aGUgZnVsbCBkZXRhaWxzLgo+Pgo+PiBUaGlzIHBhdGNoIHRyaWVzIHRvIHNvbHZlIHRoaXMgaXNz
dWUgYnkgYWRkaW5nIGEgRFJNIHByb3BlcnR5IHNvIFhvcmcKPj4gdXNlcnMgY2FuIGNoYW5nZSB0
aGUgcGl4ZWwgZW5jb2Rpbmcgb24tdGhlLWZseSwgYW5kIGEgbW9kdWxlIHBhcmFtZXRlcgo+PiB0
byBzZXQgdGhlIGRlZmF1bHQgZW5jb2RpbmcgYXQgYW1kZ3B1J3MgaW5pdCBmb3IgYWxsIHVzZXJz
Lgo+Pgo+PiBbSSBzdXBwb3NlIGFuIGFsdGVybmF0aXZlIGhlcmUgaXMgdG8gbG9vayBpbnRvIHRo
ZSByYXRpb25hbGUgb2YKPj4gZGVmYXVsdGluZyB0byBZQ2JDcjQ0NCBvbiBIRE1JIHdoZW4gdGhl
IG1vbml0b3IgYWxzbyBzdXBwb3J0cyBSR0IuIEZvcgo+PiByZWZlcmVuY2UgYWx0aG91Z2ggb24g
bXkga2l0IEkgc2VlIG5vIGRldHJpbWVudGFsIGVmZmVjdHMgZnJvbSBZQ2JDciwKPj4gSSdtIHVz
aW5nIG9uYm9hcmQgZ3JhcGhpY3Mgd2l0aCBhIG1vdGhlcmJvYXJkIHRoYXQgaGFzIGp1c3QgRC1z
dWIgYW5kCj4+IEhETUkgLS0gc28gRGlzcGxheVBvcnQncyBub3QgYW4gb3B0aW9uLl0KPiAKPiBB
aCwgdGhhdCBwcm9ibGVtIGFnYWluLiBZZXMsIHRoYXQncyBhbiBpc3N1ZSBzaW5jZSB0aGUgZWFy
bHkgZmdscnggZGF5cyAKPiBvbiBsaW51eC4KPiAKPiBTaG91bGRuJ3QgdGhlIHBpeGVsIGVuY29k
aW5nIGJlIHBhcnQgb2YgdGhlIG1vZGUgdG8gcnVuID8KPiAKPiBSZWdhcmRzLAo+IENocmlzdGlh
bi4KCkRSTSBtb2RlcyBkb24ndCBzcGVjaWZ5IHRoZSBlbmNvZGluZy4gVGhlIHByb3BlcnR5IGFz
IHBhcnQgb2YgdGhpcyBwYXRjaCAKbGV0cyB1c2Vyc3BhY2Ugb3ZlcnJpZGUgaXQgYnV0IHRoZSB1
c2Vyc3BhY2UgR1VJIHN1cHBvcnQgaXNuJ3QgdGhlcmUgb24gCldheWxhbmQgSUlSQy4KCkknbSBm
aW5lIHdpdGggYWRkaW5nIHRoZSBwcm9wZXJ0aWVzIGJ1dCBJIGRvbid0IHRoaW5rIHRoZSBtb2R1
bGUgCnBhcmFtZXRlciBpcyB0aGUgcmlnaHQgc29sdXRpb24gaGVyZS4gSSB0aGluayBpdCdzIGJl
dHRlciBpZiB3ZSB0cnkgdG8gCmdldCB0aGlzIGludG8gYXRvbWljIHVzZXJzcGFjZSBhcyB3ZWxs
IG9yIHJldml2ZSBlZmZvcnRzIHRoYXQgaGF2ZSBiZWVuIAphbHJlYWR5IHN0YXJ0ZWQgYmVmb3Jl
LgoKVGhlIHByb2JsZW0gd2l0aCB0aGUgbW9kdWxlIHBhcmFtZXRlcnMgaXMgdGhhdCBpdCdkIGJl
IGFwcGx5aW5nIGEgCmRlZmF1bHQgdG8gZXZlcnkgRFJNIGNvbm5lY3Rvci4gTm8gd2F5IHRvIHNw
ZWNpZnkgZGlmZmVyZW50IGRlZmF1bHRzIHBlciAKRFJNIGNvbm5lY3Rvciwgbm9yIGRvIHdlIGtu
b3cgdGhlIGZ1bGwgY29ubmVjdG9yIHNldCBhdCBkcml2ZXIgCmluaXRpYWxpemF0aW9uLiBUaGUg
bGlzdCBpcyBkeW5hbWljIGFuZCBjYW4gY2hhbmdlIHdoZW4geW91IHBsdWcvdW5wbHVnIApNU1Qg
ZGlzcGxheXMuCgpSZWdhcmRzLApOaWNob2xhcyBLYXpsYXVza2FzCgo+IAo+Pgo+PiAtSmFtZXMK
Pj4KPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Pj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
IAo+Pgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
