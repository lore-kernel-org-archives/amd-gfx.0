Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172B5C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD33E2082E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ME+A+KhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD33E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996F56E878;
	Mon, 16 Dec 2019 20:10:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB19C6E878
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 20:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL9a7bitzvrT/b9UWzgH5fswrdxgW409ysTDcrqBV+2XZ8+qErwNRrtrMOyDEdU/F5PlaEvtEMVGYqhyv6U6w6qFgRb8AwiUxEkbqrIKNH3yQnpfm+7rNWkmujj5Mt/dXMlYmUtyPbZ69Xpg2klSNagMG/6/bHRUXezoxnH9k5JN/uhlQFN0clRYX0yd2XmocnLPOSe8BVJmr37nFDAy9ETvPT9wkuAReks7m7W2/n0oJhhSFAi5WvV3Zo01XmcfawyEd3lN6fEen9V3GaMdu6WJ/gtTdw6NFbYk31DRAYGbl3ww0z2D3cSy6bDFConr9ItrrU2SWw+bVNqDpjhSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3wrRZh7omx0MOGagTWi0KROxsIST6p2A5OpoD0HXBU=;
 b=BniJ6YfzXHVGNJwvp0n1upNII69IEnWC04soolPLps+bCyhvX43vYUuNAggC7WeZS+dU4ClZ8Aeq+3s3EgxEr5hkO6XKPCIA6nmefNf5nbGsdexJE5drIvlyLoIzZx7I50ebZh1SOTf+7V33TPytZkCETft3Dg5+yFBlO+OBSdBjxg+QKQHilhT2PYaOOcF3STP0EMwoN4gSLgduZuKIcRsFOhR8ufctD3VuuMpW6sDwGQ7czVFLdqnmspe6iem0CJ1DkmSV2ZepVBoR8qUru1ExVdXTpQd6XWcbOVa6xzdmmO6BNKggCi9gDunhyhkdi5+ZEYtMQvMHO/IiLHrbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3wrRZh7omx0MOGagTWi0KROxsIST6p2A5OpoD0HXBU=;
 b=ME+A+KhTm4X/2rWpO6a3TC/lATCThtVU4P/aVcIoaJUHSIDJFhUg93LNAg02/2mXz0sD/fS6cII86ePwbbx8iFd81Fs6nCC8O49Omx4aPXWZyGHxANlICZKnzb316JWD4CmtduvHcWYBIP5kr0gNPUAFNWe3wkv8CFUk/S5khM8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1323.namprd12.prod.outlook.com (10.168.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Mon, 16 Dec 2019 20:10:50 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.021; Mon, 16 Dec 2019
 20:10:50 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn: remove unnecessary included headers
From: Leo Liu <leo.liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
References: <20191216160543.13054-1-leo.liu@amd.com>
 <CADnq5_NyFmejzHKHztPmXU8achHWqxPVMzwv2=t-8McwroQcVA@mail.gmail.com>
 <e03c9ebc-4b0d-c6ce-e946-d5a7d2327219@amd.com>
Organization: AMD
Message-ID: <41dff84c-3e63-5092-313f-66fb7d383217@amd.com>
Date: Mon, 16 Dec 2019 15:10:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <e03c9ebc-4b0d-c6ce-e946-d5a7d2327219@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::29)
 To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce92c360-c802-46b5-c381-08d782640bca
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1323383BEC51F657E3E2143EE5510@DM5PR12MB1323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02530BD3AA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(2906002)(31686004)(53546011)(186003)(36756003)(6506007)(52116002)(36916002)(44832011)(6916009)(5660300002)(2616005)(26005)(4326008)(6512007)(478600001)(66476007)(66556008)(66946007)(81166006)(81156014)(86362001)(45080400002)(8676002)(8936002)(31696002)(966005)(6486002)(316002)(4001150100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jV5+VC8JtsmdCWXD8FTPsVblfdnrNnEKElgXGaz8ee1Or2m8yt3/Rx0+MlJXzQXFnYOv+WQu5K8BovmLbdGiDswUi2MIO2T1dDdzrvhy8UUJQ0vZSKGcrg/NlQyXfwI0l74fEIgMbgT6DPK4uF/6GOoddawL6WAGlgzvAU8lut4XOiZgmS2wZRrBeJkqERnd6HRsNb01tZDaNtIb+LjiTvQ9PUxGUavx3bd5HNGmV80uoWYAoi2ZgWV7UuTOOy+qI2YNYTriqtDo9BugfaSTvyr7Otr+CNjKJzrhdqlz0LZ/SEgKYhq9POqWr91HeRAqSAy3zNofHhOEsM3dXLMQZCytzZy4MfcGG+fOMVB1pg2BMIJfYjEmRBkdk3ruC4BaVSVvJ8gr5lt7kNDlFtPWUowTo3M7OMszTOXu66psEszYUWtYC8UcuGpmTeK/mwnwZrGS4KAp8OmjtIHRneGou9riQm5kCS3IdPFktyevDSw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce92c360-c802-46b5-c381-08d782640bca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 20:10:50.4571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRib6yxhXAIjIpyURmt1LNZYZQVZKdAaDhn/2jEAuVhhrDWizGeNyZk+FrX+ELed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQWxleCwKCkkgc2VhcmNoZWQgYW5kIGZvdW5kIHdoeSBpdCBnZXQgYnVpbHQgb2theToKCmFt
ZGdwdS5oIGluY2x1ZGVzIGFtZGdwdV9tb2RlLmgsIGFuZCB0aGF0IGluY2x1ZGUgbGludXgvaTJj
LmguCgpBbmQgbGludXgvaTJjLmggaW5jbHVkZXMgbGludXgvYWNwaS5oIGFuZCB0aGF0IGluY2x1
ZGVzIGxpbnV4L21vZHVsZXMuaC4KClRlc3RlZCBpdCBieSBjb21tZW50aW5nIG91dCBsaW51eC9t
b2R1bGVzLmggZnJvbSBsaW51eC9hY3BpLmgsIHRoZW4gdGhlIApidWlsZCBmb3IgYW1kZ3B1Lmtv
IHdvdWxkIGZhaWwgYXQgdGhlIE1PRFVMRV9GSVJNV0FSRSBmb3IgVkNOLgoKU28gaW4gb3JkZXIg
dG8ga2VlcCBpdCBjb25zaXN0ZW50LCBhbmQgSSB3aWxsIHNlbmQgdjIgdG8ga2VlcCAKPGxpbnV4
L21vZHVsZXMuaD4KClJlZ2FyZHMsCgpMZW8KCgpPbiAyMDE5LTEyLTE2IDExOjUwIGEubS4sIExl
byBMaXUgd3JvdGU6Cj4KPiBPbiAyMDE5LTEyLTE2IDExOjM2IGEubS4sIEFsZXggRGV1Y2hlciB3
cm90ZToKPj4gT24gTW9uLCBEZWMgMTYsIDIwMTkgYXQgMTE6MDYgQU0gTGVvIExpdSA8bGVvLmxp
dUBhbWQuY29tPiB3cm90ZToKPj4+IEVzcC4gVkNOMS4wIGhlYWRlcnMgc2hvdWxkIG5vdCBiZSBo
ZXJlCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgo+Pj4g
LS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCA3IC0t
LS0tLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgCj4+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+Pj4gaW5kZXggZTUyMjAyNTQz
MGM3Li4zNzFmNTVkZTQyZGMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uYwo+Pj4gQEAgLTI1LDE5ICsyNSwxMiBAQAo+Pj4gwqDCoCAqLwo+Pj4KPj4+IMKg
ICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPgo+Pj4gLSNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4KPj4gRG9uJ3Qgd2Ugc3RpbGwgbmVlZCBtb2R1bGUuaCBmb3IgTU9EVUxFX0ZJUk1XQVJFKCk/
Cj4KPiBJdCdzIGdvdCBidWlsdCBva2F5IGJ5IHJlbW92aW5nIGl0LiBJIHdpbGwga2VlcCBpdCBh
bnl3YXkuCj4KPiBSZWdhcmRzLAo+IExlbwo+Cj4KPgo+Pgo+PiBBbGV4Cj4+Cj4+PiDCoCAjaW5j
bHVkZSA8bGludXgvcGNpLmg+Cj4+Pgo+Pj4gLSNpbmNsdWRlIDxkcm0vZHJtLmg+Cj4+PiAtCj4+
PiDCoCAjaW5jbHVkZSAiYW1kZ3B1LmgiCj4+PiDCoCAjaW5jbHVkZSAiYW1kZ3B1X3BtLmgiCj4+
PiDCoCAjaW5jbHVkZSAiYW1kZ3B1X3Zjbi5oIgo+Pj4gwqAgI2luY2x1ZGUgInNvYzE1ZC5oIgo+
Pj4gLSNpbmNsdWRlICJzb2MxNV9jb21tb24uaCIKPj4+IC0KPj4+IC0jaW5jbHVkZSAidmNuL3Zj
bl8xXzBfb2Zmc2V0LmgiCj4+PiAtI2luY2x1ZGUgInZjbi92Y25fMV8wX3NoX21hc2suaCIKPj4+
Cj4+PiDCoCAvKiBGaXJtd2FyZSBOYW1lcyAqLwo+Pj4gwqAgI2RlZmluZSBGSVJNV0FSRV9SQVZF
TsKgwqDCoMKgwqDCoMKgwqAgImFtZGdwdS9yYXZlbl92Y24uYmluIgo+Pj4gLS0gCj4+PiAyLjE3
LjEKPj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NsZW8ubGl1JTQwYW1kLmNvbSU3QzA0MWU1
NzNhNjYxYjQ5ODIxNmVhMDhkNzgyNDgxZDhlJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0
ZTE4M2QlN0MwJTdDMCU3QzYzNzEyMTExOTExMjc0NDA3MiZhbXA7c2RhdGE9VHRqVkVnbCUyQkIy
c3ByU3ZIT0p2Q3Bac3hYRDVqdzlXU3JldXNhRG9lS21VJTNEJmFtcDtyZXNlcnZlZD0wIAo+Pj4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFt
cDtkYXRhPTAyJTdDMDElN0NsZW8ubGl1JTQwYW1kLmNvbSU3QzA0MWU1NzNhNjYxYjQ5ODIxNmVh
MDhkNzgyNDgxZDhlJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzEyMTExOTExMjc0NDA3MiZhbXA7c2RhdGE9VHRqVkVnbCUyQkIyc3ByU3ZIT0p2Q3Bac3hY
RDVqdzlXU3JldXNhRG9lS21VJTNEJmFtcDtyZXNlcnZlZD0wIAo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
