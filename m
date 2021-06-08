Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E9C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 13:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7B16128A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 13:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7B16128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA686EBAC;
	Tue,  8 Jun 2021 13:08:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517ED6EB09
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 13:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/NrP0G6uKiPpXCJt2LnVm4YpEcxAeEaty5zuM3V/qgolreyECs+t3SQjuE6LbELRZ2WZy9+9UE0+hQKoeURygV9L7mybWH3l16ieL2AGu/PGeuj5K6qyBWxhtxnGw4ykyOa+cB+88nmFL1ymSMY8hcQ82/m/wz/V5Ce8kbsuimBzSfIQNisWT+6HaNvv9/Gww+n110wajhUmcGETJTdjIJsrKcQ+H8B+BA6FOkWVFh73uED3SIrD9gA/c8Roi8YYfgz7+74URbFZb1hv/8fHDQk8jOFPHZBJuNa7p40G78qxqOVmB6SwZBJi0BY0F7AnHmCcDWnKIRhlFAJ8UbaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BQo8dOuTbqNH4LbsTgaITLc0ZWc1Nrg5hh/wVCZS/E=;
 b=TQzYheMzji8dHEZouDckNAKpaFhxSe/f8wmH8YXMvhda49OTV7EuDMU2MtX/RXofHZLBLfs8VNMUmUm8EGJ7MK4obC+XU/3UjuyaRhQKfvS33x18twEwBTvijDce+S/LWjITWvKVPmzu+gWEoK2ut3+R//TJKQuqhfMJ/Avj4V2dWBQaWlUo65RLlmEGsfFka2Uaxh3qv/r25vYMoWsSPAO6pyV8kJQ0ect/ISPalkvi8XLltp7pfUIIIUFk3e9GeMihhYa9G9zhijGviB2MHtU6kMsMivKxnc+swiItxzhELonPVj1iyt5m6Fm/ellJAmjpmpIjFGwZMk4W6Ulghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BQo8dOuTbqNH4LbsTgaITLc0ZWc1Nrg5hh/wVCZS/E=;
 b=QzufmjohSVd7MBwgKUlms78m1tF/LvKUnUtrz1FC/ovhTVIOSmI7e0MXEIATqB3NZDlldUshCQdumVChrFTyMxsJLXGG4C389GfR8uW1+vxArCJuf/NVlYM6FMefu/hNr2TLZHIpfrrZgRFU4bw2WHlh5wOtbAQNE+MUigeVGSc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3999.namprd12.prod.outlook.com (2603:10b6:208:158::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 13:08:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 13:08:30 +0000
Subject: Re: [PATCH v3 1/1] drm/amdkfd: use allowed domain for vmbo validation
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210608130628.71281-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c95c8161-4ab2-06be-4fec-92bfb3ee01dd@amd.com>
Date: Tue, 8 Jun 2021 15:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210608130628.71281-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:197a:8536:afbe:3762]
X-ClientProxiedBy: AM0PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:208:69::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:197a:8536:afbe:3762]
 (2a02:908:1252:fb60:197a:8536:afbe:3762) by
 AM0PR03CA0076.eurprd03.prod.outlook.com (2603:10a6:208:69::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 13:08:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72c9fb86-71fd-4766-6e1f-08d92a7e82d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3999B6B57AF39E59BE478DE383379@MN2PR12MB3999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHH8oIcPXmmFfw/ReI9SnyJIWYf5ZvO8soD8Y9aYP3Jyecqir7A3+41zEhf05+VpqbuASvcKMD3KLevfG0ZvXenqk4KWo5H07V1/UhdS0Euhz84yG8k1iarl0gC96bEPFXaGfROQmFQRUj9SwdKFHJOWolcveh2hYX8bsyeTTu0jIakmWnCGpZlqQbn3y3y4BTcViLZOCMjbAIe4TajTIdRZa3yeFN0HSHTNSzlr+ULO+pdXTJ0+FpjnP4toGlXtfyXu1vhLdB53Qiokmb+eL7YZz9eOqdV5Cenugow4i4ZtwbvXPcIObTj0Bs4I/kZYeJgUsR8dkEkMUlnE61OpfP57txh1hxBt9PCe65OEOS3M/pHNRloKL9BT6kZSbR9FJVn4+CvtmmmwW3dNks+xVzET/I1MF6t5NQLyMvbRq8yDWmcVcmj6fuyLaZ4al2KcgB2yaLA8EH3pWtjH98ANfiX4zsj2/r5WlHJDaBxQr2dzcPyUkrjgkAe2TXWUAbkl1b1tsnLRWK8wQxRQIp3eQnidGKizC7cb2jisCvluZJHDIyrjk2oJ5mu3cUYi6/GQqeHSdHNC983F6VRQ1GEhGytLGHJdAvVKrwqjpdG3DNt9voa4pQ4NMT0dSSQPoslfxvWBCUlHfeViGi4HPrSMI9MRLHQ1nm0IaOb9n/4nK6NTsU9L3KkUhY7dNz6Oyz8P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(8676002)(16526019)(4326008)(316002)(66574015)(5660300002)(186003)(478600001)(36756003)(38100700002)(31686004)(86362001)(31696002)(66946007)(66556008)(2616005)(6486002)(6666004)(66476007)(8936002)(83380400001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZPd3duU0xZUFFrQWErOUdRZHk1ai9TcVlxK051T1ZPTTIxcjJTLzE2Tkww?=
 =?utf-8?B?L2xVclk2cXo3eGVVQlRRdmVzZmV5dGJ4dXZFYk9QRkFaWjhzYmxFTlFNSlQw?=
 =?utf-8?B?NVNsdnJETE05ZzdRMnRMOXN2aktScVFzdUNGU0sxc3VBOTFNK01CdGFOdnVR?=
 =?utf-8?B?SlNWZG9aTGRZblNxaFpZdFhkV1l6c1VWS0dVcWZ3Umtud29oM1ZXQitVVGpq?=
 =?utf-8?B?bWwwb0VxNzVZTGp0MXMzOG42dUpTR0lFUlR6bWRFZUdEenhCZkJ4ZE5DY2dx?=
 =?utf-8?B?ZzRKMUZraUt0NmZWdDg2SS9sUkdNTnFkYmZCY0pKSm5FTnBFM2FiZ1NhQk9U?=
 =?utf-8?B?Mm00Z20wQ29hTWdLd3k2WFJsMTJqZVpDZVZSVit2dWltYUt1NWNYV3VFS05Q?=
 =?utf-8?B?cU13S1luV0grSmxDelA5SVRaRXNXSkE1WVowbzJBMk5Fd25rNVVLOElqUFpZ?=
 =?utf-8?B?QXFUbktFMUswaW80SU1iMFlWWjV2d2x5eFFMbjBWZW5WM1ZGTXpqVnUvTmRQ?=
 =?utf-8?B?SHZRZ0NLTkJSYnhSb3BGWkNCRVN1RzRuSVFRME9GS1dkeVNod1Q5Snpscmk5?=
 =?utf-8?B?ZExyTVV4RE1DWDJLdnBFeEVzSVIyS3ByWHVJV291UFAxenJoNUFjSjYwMUtL?=
 =?utf-8?B?SDg0UWNaMVpudGJWNVlaMTVSYVNod200RUpVYjIrL3dPQ3A4ZFUydFNtK3dq?=
 =?utf-8?B?S3RRRmlPMVhLKzN0YjZJdkVneDR0Ry9pc2x0OUUxUWJtTVpKeHAyNnhOdWI1?=
 =?utf-8?B?T3lhQWJEN09pYmtHbzRIbUJJZWRPOTUya1pnb0tKZ0h5Q0lKelZKellJT29j?=
 =?utf-8?B?TFR6QWltdlYzU05ObXJXNXBqcVNVNHVjYjd5YktmK1VXTzI4Qk5FeDBETmVa?=
 =?utf-8?B?K1NRWDlnTjNvdVpQNmJHbm9RLzhhSG14UCs0T1pwWXBqYXFhWVFjRU5JQ2Fr?=
 =?utf-8?B?U1ozY1ZyMGpRODM4OEg1aUNZeitIeVUyWHlFL2laaGRuVkx5aDZlc0ErZXBu?=
 =?utf-8?B?Ymc1R05xOUxsWXRmSmROTFR5azJOSVM3WlAxdm9JYVdyS1Y2c0c3WU8xaytE?=
 =?utf-8?B?QnRvdys2WCtYcVgrTUtKM3I3TnpSUVZKcVZFZU9hekl2T0I4WmQvVllkLy9R?=
 =?utf-8?B?RFhScnFCTkFIOE8rNkRrUURtdzJYa2ZsakNwR2FETGJvTG1ROGU5ajZKSTdK?=
 =?utf-8?B?YVNiWDJRYUw5MTJWQ2RMeXNTOW5wdG5VMXhUZ2JpMWJ0Y0FQMGFNS0ZRS01n?=
 =?utf-8?B?NmsxTSswOCtQbCtGRVdzYkZ6US9mS3loZGNhdktpR1hSaHpFbGxxaHdCV051?=
 =?utf-8?B?V0h2Zlpra1RvL0hTRUNzWTBiV095V0FSeStwWThYVm91cUdVY3NlbUNwLzlM?=
 =?utf-8?B?ZmZ0NnlWanhvT2d0VFNyb282aTZTNnBaVlR1dWQ3aTdEN0M3QnBGakJMZVZn?=
 =?utf-8?B?dXZDbXFoYjBCK3o5amlRbC9ZRUd6VGgzcG9qUEN3aG9FdHo0R3owQjVETHA3?=
 =?utf-8?B?Rm00Y0pUYWxtUVdYMGo2TEVvRlZUbjIvRGg5ZHIrTHVlRURKdWd0cmlUOVd5?=
 =?utf-8?B?dW1LRGxTelZBSndSNFpjNXhua2pKR3QvUVZzZ2RHNXgvTUYrU1V0TGNaWWpO?=
 =?utf-8?B?Z3NrR1lLK0lhUmw1ditsNUZ1RlcrRHI0KzM3dlpqaFVGUWZkRTErRkplQmls?=
 =?utf-8?B?VzFtMy9uTnhsK2w3SGVzaHdnclR1QURZTzluYXdTQ0JXMDBYTzIySDdLN2pz?=
 =?utf-8?B?L0FHekhkdDhYdHBEbU85N01MMGw2c2FmbURWcC9HbGFPZWRMYldxZkNBUVR4?=
 =?utf-8?B?VFMvd3VmQU5WeS9kTnlHaW1aZXQzcndHSlZ4SWdDbjBjVGVLaHVEY2xUaUc1?=
 =?utf-8?Q?FDq+r/HEfEZRA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c9fb86-71fd-4766-6e1f-08d92a7e82d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 13:08:30.6214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NA+GkJ7F3Hsr8u/wrwMOSrMbp/CvXeHIvER3Cwl63WLWNIRrf3DOH792ey9XKRL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3999
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDYuMjEgdW0gMTU6MDYgc2NocmllYiBOaXJtb3kgRGFzOgo+IEZpeGVzIGhhbmRsaW5n
IHdoZW4gcGFnZSB0YWJsZXMgYXJlIGluIHN5c3RlbSBtZW1vcnkuCj4KPiB2MzogcmVtb3ZlIHN0
cnVjdCBhbWRncHVfdm1fcGFyc2VyLgo+IHYyOiByZW1vdmUgdW53YW50ZWQgdmFyaWFibGUuCj4g
ICAgICBjaGFuZ2UgYW1kZ3B1X2FtZGtmZF92YWxpZGF0ZSBpbnN0ZWFkIG9mIGFtZGdwdV9hbWRr
ZmRfYm9fdmFsaWRhdGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFz
QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPiBidXQgRmVsaXggc2hvdWxkIApwcm9iYWJseSB0YWtlIGEgbG9vayBhcyB3ZWxs
LgoKPiAtLS0KPiAgIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
ICB8IDIxICsrKystLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDE3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IGluZGV4IGQ2Y2I3Y2Y3NjYyMy4uMDE2ODE1Yjdh
NzczIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYwo+IEBAIC00NywxMiArNDcsNiBAQCBzdGF0aWMgc3RydWN0IHsKPiAgIAlzcGlu
bG9ja190IG1lbV9saW1pdF9sb2NrOwo+ICAgfSBrZmRfbWVtX2xpbWl0Owo+Cj4gLS8qIFN0cnVj
dCB1c2VkIGZvciBhbWRncHVfYW1ka2ZkX2JvX3ZhbGlkYXRlICovCj4gLXN0cnVjdCBhbWRncHVf
dm1fcGFyc2VyIHsKPiAtCXVpbnQzMl90ICAgICAgICBkb21haW47Cj4gLQlib29sICAgICAgICAg
ICAgd2FpdDsKPiAtfTsKPiAtCj4gICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGRvbWFpbl9i
aXRfdG9fc3RyaW5nW10gPSB7Cj4gICAJCSJDUFUiLAo+ICAgCQkiR1RUIiwKPiBAQCAtMzQ4LDEx
ICszNDIsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9hbWRrZmRfYm9fdmFsaWRhdGUoc3RydWN0IGFt
ZGdwdV9ibyAqYm8sIHVpbnQzMl90IGRvbWFpbiwKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+Cj4g
LXN0YXRpYyBpbnQgYW1kZ3B1X2FtZGtmZF92YWxpZGF0ZSh2b2lkICpwYXJhbSwgc3RydWN0IGFt
ZGdwdV9ibyAqYm8pCj4gK3N0YXRpYyBpbnQgYW1kZ3B1X2FtZGtmZF92YWxpZGF0ZV92bV9ibyh2
b2lkICpfdW51c2VkLCBzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPiAgIHsKPiAtCXN0cnVjdCBhbWRn
cHVfdm1fcGFyc2VyICpwID0gcGFyYW07Cj4gLQo+IC0JcmV0dXJuIGFtZGdwdV9hbWRrZmRfYm9f
dmFsaWRhdGUoYm8sIHAtPmRvbWFpbiwgcC0+d2FpdCk7Cj4gKwlyZXR1cm4gYW1kZ3B1X2FtZGtm
ZF9ib192YWxpZGF0ZShibywgYm8tPmFsbG93ZWRfZG9tYWlucywgZmFsc2UpOwo+ICAgfQo+Cj4g
ICAvKiB2bV92YWxpZGF0ZV9wdF9wZF9ib3MgLSBWYWxpZGF0ZSBwYWdlIHRhYmxlIGFuZCBkaXJl
Y3RvcnkgQk9zCj4gQEAgLTM2NiwyMCArMzU4LDE1IEBAIHN0YXRpYyBpbnQgdm1fdmFsaWRhdGVf
cHRfcGRfYm9zKHN0cnVjdCBhbWRncHVfdm0gKnZtKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVf
Ym8gKnBkID0gdm0tPnJvb3QuYmFzZS5ibzsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diA9IGFtZGdwdV90dG1fYWRldihwZC0+dGJvLmJkZXYpOwo+IC0Jc3RydWN0IGFtZGdwdV92bV9w
YXJzZXIgcGFyYW07Cj4gICAJaW50IHJldDsKPgo+IC0JcGFyYW0uZG9tYWluID0gQU1ER1BVX0dF
TV9ET01BSU5fVlJBTTsKPiAtCXBhcmFtLndhaXQgPSBmYWxzZTsKPiAtCj4gLQlyZXQgPSBhbWRn
cHVfdm1fdmFsaWRhdGVfcHRfYm9zKGFkZXYsIHZtLCBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlLAo+
IC0JCQkJCSZwYXJhbSk7Cj4gKwlyZXQgPSBhbWRncHVfdm1fdmFsaWRhdGVfcHRfYm9zKGFkZXYs
IHZtLCBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlX3ZtX2JvLCBOVUxMKTsKPiAgIAlpZiAocmV0KSB7
Cj4gICAJCXByX2VycigiZmFpbGVkIHRvIHZhbGlkYXRlIFBUIEJPc1xuIik7Cj4gICAJCXJldHVy
biByZXQ7Cj4gICAJfQo+Cj4gLQlyZXQgPSBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlKCZwYXJhbSwg
cGQpOwo+ICsJcmV0ID0gYW1kZ3B1X2FtZGtmZF92YWxpZGF0ZV92bV9ibyhOVUxMLCBwZCk7Cj4g
ICAJaWYgKHJldCkgewo+ICAgCQlwcl9lcnIoImZhaWxlZCB0byB2YWxpZGF0ZSBQRFxuIik7Cj4g
ICAJCXJldHVybiByZXQ7Cj4gLS0KPiAyLjMxLjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
