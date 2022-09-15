Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3B1ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 10:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2A710E16A;
	Thu, 15 Sep 2022 10:11:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E9910E16A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 10:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsHUA66h1RV9ZY9Mbrqcv+3VyOEyjn2leOmAFd1XTBNzIXARnGBDKS45eQ94pVFzGp1uiHFY/wBXOWpPCPp++ayGZbq7i3DGz1hjQiwFbviEQ13LRQx/rjUiE4LKeAtcDHxajb8w2pGBqIPovFv7sdt/65KJ+M5Hf2sD9Y20PQeD+a3dTylEtx9BLbTcZG6YGLSUEx/Xs2sIlFJDeU7L7B36En+BTf70I6pu4gAHMlQo1l/0JVVVnotQmXmObomEeqN7tODRjsyjFS0gP0AtyLu7XIB2skSWFqmr8YEVywbxlkSsMptSAVp8tg8Gy+nLHSTsBcbp47+McOT7GyevVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJM/hZiTW2yHk5djz0gc+bDd6i0CQVQpu5uIG+Vu4pw=;
 b=RX5UrLQIOUhkm8OvtMu6QjrP8vrbSTY4kNh8/6FlPhpjLqb/0Wl0q980fOV+viuieOnkiTexFdLw7QevsI/RYZKoDTogWpJW5NV1L8OcB4/lgxYn57rFVAL/1F2wyrw6Y5x7rRDbX/ogTtOWwmh0w/FZhRrO3qfX63kS79YDk/zz6rY8ep4rnuRu+XrSdT5fh+RJ3wAe7KVvViMv7865fzCN3NWyrIUW01Zhd01E+/cLh7Q1xjjkCWoL1fVGY5uFL5/0fQb3k9k2NAbG0Gzw+k1/XuZHpYvZk9bCcArN/prXgClwN3XLZWVPeXrEYln5WgoRf0Zx3cz8rqnl4TPmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJM/hZiTW2yHk5djz0gc+bDd6i0CQVQpu5uIG+Vu4pw=;
 b=d2ugj48J9BQfDh7DiqH7ZeUNIfMXbfP3lxcRRUCvOjEgGI0JmBo83ZDeAeQFNPQwxdc/FbYXbyvsSykLCYrj8gzeaNGb5YzfTyX8KPhkLKyadTcxEfyPsX2qw4FL9RG0DlmesjP9izMDN7g21LfHhYb4IOL5ziD+PT9mquQEcDM=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 10:11:19 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::7118:ff85:f7ee:b1ce]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::7118:ff85:f7ee:b1ce%4]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 10:11:19 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: move enable irq later to avoid race with
 ih resume
Thread-Topic: [PATCH 2/2] drm/amdgpu: move enable irq later to avoid race with
 ih resume
Thread-Index: AQHYyCJa31wYmCMhXU6bqIazn5JAw63f/9cAgAAKBsCAABgJAIAAJGBw
Date: Thu, 15 Sep 2022 10:11:19 +0000
Message-ID: <DM6PR12MB434054CD31E48ABF3D49464AFA499@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <20220914101025.366954-2-Victor.Zhao@amd.com>
 <6d96d72b-cde6-ad13-ec3a-ef26cd0f068f@amd.com>
 <DM6PR12MB4340C1B8A689A0AA8B5DB27DFA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <2d7f38a6-c276-39d4-827e-d2390c281c39@amd.com>
In-Reply-To: <2d7f38a6-c276-39d4-827e-d2390c281c39@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-15T10:11:16Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3714d862-64a2-45c7-8a74-d50b24a284c1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-15T10:11:16Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: af60ae8f-2bc0-4e51-a842-27c8b2eee515
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|SJ1PR12MB6244:EE_
x-ms-office365-filtering-correlation-id: 092e44f6-f7c8-4662-91dc-08da9702a22d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TH3Z91EkmZmEiL73x04vhin+OfDtPcMCnQ0p/tnypHg4SeXwukHUUuxTTRjXXhHVyUp/KuS3CsnZ4y2f1pFxhKykyBFjr+PKuH0oemynRb70H+bUwZVHl2h+Ucy3P6/8SUnggxUTVBoWxKYGOH0+5Tf4TFlvqmGCQqIDl9vdOI4NgRg7cNfrSD7YSn73DnZ2k0qAYMXA6nqc3dQgIfRtpumRowpAOSbX32/YbImdJMJ3QjFJ5xIQjBWqmxY94fIEFf2bke5TwTOaeE5ZSxWvq2ei5vL90uILC8GVc3Qou/hLmBaEmlbVaCbeWE2ntjjFbH6+Wd8qw0zyjAz1pOjoaULHwkjnZ7CK3ssvVznB97x/qXmt/sSp2meRaT/JOfScVc1/AOOUd3rOqQA1r0eWCL8J/3FmC/S1WeSDEbQVJExuqaddUQj0l9Sz362CT0Elacb0+zJBEouX12A63q83V2HoVQ7MChvUyWPLkHnmMPJe8Bk86FQvIOj68xiftH2wRumwY6aRq/ul7admeoN64cMz7loPO6+C4LL3zIxveeoQqqDKJAdx+ipn020kAFLpSJ80RU8Ob7HUts7HwEkCva2HTmNqt0zzMfR/d2JG7SP7efFyCi+LSBhkuITjEwrj7mxaq+WL8h7EOzjmxo55bWVKhw5NUKRSQDLVZbL5hgBipGuxYk69mxRD1mirl2HYDu6BRcefujJLXspJGfhJwI2Vn2JiWyNIRtCK/8q1XpLmLsBEwD29us6Psms7coZ5Ampv9dtomu3lkpWttR/OBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(55016003)(54906003)(38070700005)(66556008)(38100700002)(66476007)(478600001)(64756008)(33656002)(8676002)(66446008)(186003)(7696005)(5660300002)(316002)(83380400001)(26005)(76116006)(4326008)(71200400001)(9686003)(110136005)(8936002)(53546011)(6506007)(86362001)(41300700001)(2906002)(122000001)(52536014)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dytOck9EbDFxdEJwQkErS0tvUUxzc1h0czZYL3hkbU04MWZLNUl5ZE9yUjho?=
 =?utf-8?B?RlprZUFoNktVS2d0UVl0ZGJITUtJcXFETEIzbEdIMVNrQ1dwN3pZMjhJZWcy?=
 =?utf-8?B?UnM3eTcwWk16ckJVVzNpR1RVcWt5ZU5aamkrdzhVUm0xdEZPMjlvZ2VFZ2NF?=
 =?utf-8?B?Q1dzYkduemF4ejFkQzd1d0xMQ0ZoaGhhYXlCdHRQc28xRXp0STEycEVDM29J?=
 =?utf-8?B?UGpTUi9wbDBYK2xUcldvV1BoVHdieTMwNTBJWFVGNVNGbEVvbjFYK1ZKTVBo?=
 =?utf-8?B?TjJqaHlvVEJtckd4T1BmV1hydlU5T3Q4OVl6N0JRMkx6QXRsbDh3cjh3UUU5?=
 =?utf-8?B?cWxWRjVPb0Q4Q05hcWhzY0s4RHlQQ0JYY3p2UUdjdGxsZkw2WGl4NFNTS1h4?=
 =?utf-8?B?M3FBOFpuVGk2SUZ6RGVLVVg0NEM3S2lPelpsYnBpeGpIdnRoaTBxSmtLdmVD?=
 =?utf-8?B?NUJpMnZZdC9OM3Q3NzRWZmdGODc1WlVRdkNnZGZGc0ZSdVJMc0Jib1oyYzhN?=
 =?utf-8?B?UjczTi94VkpTMGt1K0JVWWFwNkxJZjJCeWZpSFpSU0RsQ2xMaGs3a29TTytl?=
 =?utf-8?B?NkNoVGVvRW0xL1ZzeVRaTzQ2V2h3dEl1YUViN3FXazU4UG1Ub1dMOVhva2RO?=
 =?utf-8?B?RnB0VXJZRlBoeTZVM2NEc0NrU3VIdVVCYnc5S2k2bUlOUmsxQ1hsTlcvSjNq?=
 =?utf-8?B?ZytYLytpQXk5OVg1RWhDdWxJUG1URGNOMjhhaWF0azV4TTVYMTFNYnAySUJD?=
 =?utf-8?B?UDZvalNycnZBYVhXVmhKNXNCcyt2UkpTc0pQTC9McTAwQ0pqcGIxYTRhcTNw?=
 =?utf-8?B?bjVDRFdqTEtHU1RJcUtWYkozbHd1RG5EMGM3K1cxbDRkR0NRVTlwSGZKbTVW?=
 =?utf-8?B?T1UvNERXSVUrWGhKY3V4OXhBRDg4V2ZYMU5SbnU0b3ZZcTFzL0ZHRU5nNnZR?=
 =?utf-8?B?V1h3dWZ3MnZDenMrODlMWHQycmJ5d3VoUFZza1RlcWFPUWVHQitVa01ObVBo?=
 =?utf-8?B?Wml3ZG9FaGQ2ZllHYlJGdklwaGJmWUR1U3RJbnVSYUN0YTlrN1ZjcXpqRkx4?=
 =?utf-8?B?TWc1dVZiWXlqV1l2eDR2Nkd6M25Sak1XV1gyN2ZZeHNXU2ppUkxNRkd4SE5L?=
 =?utf-8?B?Umc0bzBNdVAyZW91aDFCVUNHOTRGSFowWXdTaUVnRWtERlBVS25ESWFjSUp6?=
 =?utf-8?B?NSt6cW1VZjYxOTgvQmIwcnRTY1R4djAwSVd3cGgrQzlDSmN6WUliclg2eFlw?=
 =?utf-8?B?VEdxZ1daWFNZOWFQTncwSFJpTzBoZldlNTQ1MDlFUkE4ZXlNWW5qM3RwUHVl?=
 =?utf-8?B?Q1ZxeFlQcFNBbHlaR2FqT1NEb0p5QmovNS81SVcyUTRHSVhtU0VGdm5WY1I2?=
 =?utf-8?B?aXhxZDJLd1VlME1XYjluSFU1ZHZFc2VnWTkyaW94a255RGUwMWNGSVhTeHFB?=
 =?utf-8?B?NmF6V0tCdlBTM1I5Ymsrc1p2YkMveGx0RVZYUW9pY1RtZC9hU0QvNllRdk9C?=
 =?utf-8?B?ZWlGVFlDSGJsTWc3akMzMVlZR0RONmR3TEpJNG5wc2RTUE51RDJxV2NBR2JE?=
 =?utf-8?B?R0ptR2FPYkhoUzR3WGFZOTBxZTNzUXljVmw5NWdCL1RVQ1psS2JjWXZlVVd6?=
 =?utf-8?B?SnR4MjlNQ3pLbHM1SlVHTytST0VHMGI1dVdJUzdzQ2xkcnF4dkRlYy9GUmN2?=
 =?utf-8?B?SXR3T0pxd2paYnk1SThVS2tsc0gvZXI0YndvY0l4TlpXSlcvLzAvNmxWcVBp?=
 =?utf-8?B?cU0zTTFUZnlHaUlWNlNFQzdxSWJjK3hKdURBVG9rYk0zMWtDR2E1TnJORXY3?=
 =?utf-8?B?R1BweEtORnppdksyOStmV2lPajMxZXFYN0dCSHZ6R1hUYnR2VjgvZmFYR3VJ?=
 =?utf-8?B?bW9XUUlGNG9mYjA2V1UyV2M0Vlg3MmU0V2RtUGZvNUVMOGRBa3BSREdTMS9u?=
 =?utf-8?B?dEVPYWd1ZWRWYUxhcitVMVdZbVdGNmczWHRJY2EvUlJUNStVa3V5K1NLbml6?=
 =?utf-8?B?cm52TTVoMitZVVBiVk43THpwdis0ZnQ5U0FLZHRYMkpPL21NZHB6MnVrdXpI?=
 =?utf-8?B?ak9BTHUrNkZPSnl6dEwveFZheEpYWmNuaDJnOG5mTmhVMjI0VHNMWTBMSVpR?=
 =?utf-8?Q?KRYc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092e44f6-f7c8-4662-91dc-08da9702a22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 10:11:19.2502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdhHZS2USb5AEmEHJLiGcqUIZp+ob4Y6lvV6q9E+ekUsg5TDJKVQ26hUqGOnniKo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIExpam8sDQoNClllcywgdGhp
cyBpcyB3aGF0IEkgb2JzZXJ2ZWQgaW4gc2llbm5hIGNpY2hsaWQuIA0KDQoNClRoYW5rcywNClZp
Y3Rvcg0KDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpv
IDxMaWpvLkxhemFyQGFtZC5jb20+IA0KU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxNSwgMjAy
MiA0OjAwIFBNDQpUbzogWmhhbywgVmljdG9yIDxWaWN0b3IuWmhhb0BhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQu
Y29tPjsgR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPg0KU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IG1vdmUgZW5hYmxlIGlycSBsYXRlciB0
byBhdm9pZCByYWNlIHdpdGggaWggcmVzdW1lDQoNCg0KDQpPbiA5LzE1LzIwMjIgMTI6MDggUE0s
IFpoYW8sIFZpY3RvciB3cm90ZToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxd
DQo+IA0KPiBIaSBMaWpvLA0KPiANCj4gSUggcmVzdW1lIHdhcyBhZGRlZCB0byByZXNvbHZlIGFu
IGlzc3VlIGZvdW5kIGR1cmluZyBtb2RlMiBicmluZyB1cCBvbiBzaWVubmEgY2ljaGxpZDoNCj4g
LSBjbG9zZSBkb3duIG1vZGUyIHJlc2V0IGFuZCBkbyBhIG1vZGUxIHJlc2V0IGZpcnN0DQo+IC0g
b3BlbiBtb2RlMiByZXNldCBhbmQgZG8gYSBtb2RlMiByZXNldC4gTW9kZTIgcmVzZXQgd2FzIGZv
dW5kIGZhaWwgaW4gdGhpcyBjYXNlLg0KPiANCj4gUmVzdW1lIElIIGhlbHBzIGluIHRoaXMgY2Fz
ZQ0KPiANCg0KU29ycnksIHdoYXQgZG8geW91IG1lYW4gYnkgJ2Nsb3NlIGRvd24nIG1vZGUyIC8n
b3BlbiBtb2RlMiByZXNldCc/IERvIHlvdSBtZWFuIGlmIG1vZGUtMSByZXNldCBpcyBkb25lIGZp
cnN0LCBhIHN1YnNlcXVlbnQgbW9kZS0yIHJlc2V0IGRvZXNuJ3Qgd29yayB3aXRob3V0IElIIHJl
c3VtZT8NCg0KVGhhbmtzLA0KTGlqbw0KDQo+IA0KPiBUaGFua3MsDQo+IFZpY3Rvcg0KPiANCj4g
DQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8
TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE1LCAyMDIy
IDE6NTggUE0NCj4gVG86IFpoYW8sIFZpY3RvciA8VmljdG9yLlpoYW9AYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0Bh
bWQuY29tPjsgR3JvZHpvdnNreSwgQW5kcmV5IA0KPiA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IG1vdmUgZW5hYmxlIGly
cSBsYXRlciB0byBhdm9pZCANCj4gcmFjZSB3aXRoIGloIHJlc3VtZQ0KPiANCj4gDQo+IA0KPiBP
biA5LzE0LzIwMjIgMzo0MCBQTSwgVmljdG9yIFpoYW8gd3JvdGU6DQo+PiBbYmFja2dyb3VuZF0N
Cj4+IE9uIGN1cnJlbnQgc2llbm5hIGNpY2hsaWQgbW9kZTIgcmVzZXQsIG9uIHRoZSBzbG93IGpv
YiBoYW5nIGNhc2VzLCANCj4+IHNpbmNlIHBhZ2UgdGFibGUgY29udGV4dCB3YXMgcmV2ZXJ0ZWQg
dG8gY29tcGxldGVseSBzdG9wIGdwdSwgaXQgd2lsbCANCj4+IGdlbmVyYXRlIHBhZ2UgZmF1bHQg
aW50ZXJydXB0Lg0KPj4NCj4+IFNpbmNlIHRoZSBpcnEgYXJlIG9wZW4gZHVyaW5nIHJlY292ZXJ5
IHN0YWdlLCBkdXJpbmcgaWggcmVzdW1lIHN0ZXAsIA0KPj4gaWYgdGhpcyBpbnRlcnJ1cHQgd2Fz
IGluIHByb2Nlc3NpbmcsIHdoaWNoIGluY3JlYXNlZCBpaCByaW5nIHJwdHIsIA0KPj4gYW5kIGlo
IHJlc3VtZSBtZWFud2hpbGUgd2lsbCBzZXQgcnB0ciBhbmQgd3B0ciB0byAwLiBUaGlzIG1heSBj
YXVzZQ0KPiANCj4gQUZBSUssIG9ubHkgR0ZYL1NETUEgYXJlIGFmZmVjdGVkIGJ5IG1vZGUtMi4g
SUggaXMgbm90IHN1c3BlbmRlZCBiZWZvcmUgbW9kZS0yLiBXaHkgZG8geW91IHJlc3VtZSBJSCBh
ZnRlciBtb2RlLTIgd2hlbiBpdCBpcyBub3Qgc3VzcGVuZGVkPyBJcyBpdCBhIHNwZWNpYWwgY2Fz
ZSBmb3IgdmlydHVhbGl6YXRpb24/DQo+IA0KPiBUaGFua3MsDQo+IExpam8NCj4gDQo+PiBycHRy
IGdyZWF0ZXIgdGhhbiB3cHRyLiBTdWNoIGNhc2Ugd2FzIG5vdCBoYW5kbGVkIGluIGloIHByb2Nl
c3MsIGFuZCANCj4+IGl0IHdpbGwgY2F1c2UgcnB0ciBjb250aW51ZSBpbmNyZWFzaW5nIHV0aWwg
cmVhY2hlcyB0aGUgbWF4Lg0KPj4gU3VjaCBjYXNlIHdpbGwgbWFrZSBmZW5jZSBmYWxsYmFjayBz
aXR1YXRpb24gaGFwcGVuLg0KPj4NCj4+IFtob3ddDQo+PiBNb3ZlIHRoZSBlbmFibGUgb2YgaXJx
IGFmdGVyIGloIHJlc3VtZWQgYW5kIGJlZm9yZSBpYiB0ZXN0Lg0KPj4gQWRqdXN0aW5nIHRoZSBw
b3NpdGlvbiBvZiBlbmFibGUgaXJxIG9uIG90aGVyIHJlc2V0IHBhdGhzIGFjY29yZGluZ2x5Lg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZpY3RvciBaaGFvIDxWaWN0b3IuWmhhb0BhbWQuY29tPg0K
Pj4gLS0tDQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
IHwgOCArKysrLS0tLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2llbm5hX2Np
Y2hsaWQuYyB8IDEgKw0KPj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCj4+IGluZGV4IGMwY2ZhZTUyZjEyYi4uMGI2NTgyMjVlOWVmIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IEBAIC00
NjI1LDggKzQ2MjUsNiBAQCBpbnQgYW1kZ3B1X2RldmljZV9wcmVfYXNpY19yZXNldChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4+ICAgIAkJYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9j
b21wbGV0aW9uKHJpbmcpOw0KPj4gICAgCX0NCj4+ICAgIA0KPj4gLQlhbWRncHVfZmVuY2VfZHJp
dmVyX2lzcl90b2dnbGUoYWRldiwgZmFsc2UpOw0KPj4gLQ0KPj4gICAgCWlmIChqb2IgJiYgam9i
LT52bSkNCj4+ICAgIAkJZHJtX3NjaGVkX2luY3JlYXNlX2thcm1hKCZqb2ItPmJhc2UpOw0KPj4g
ICAgDQo+PiBAQCAtNDc1OCw2ICs0NzU2LDEwIEBAIGludCBhbWRncHVfZG9fYXNpY19yZXNldChz
dHJ1Y3QgbGlzdF9oZWFkICpkZXZpY2VfbGlzdF9oYW5kbGUsDQo+PiAgICAJCXRlc3RfYml0KEFN
REdQVV9ORUVEX0ZVTExfUkVTRVQsICZyZXNldF9jb250ZXh0LT5mbGFncyk7DQo+PiAgICAJc2tp
cF9od19yZXNldCA9IHRlc3RfYml0KEFNREdQVV9TS0lQX0hXX1JFU0VULCANCj4+ICZyZXNldF9j
b250ZXh0LT5mbGFncyk7DQo+PiAgICANCj4+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeSAodG1wX2Fk
ZXYsIGRldmljZV9saXN0X2hhbmRsZSwgcmVzZXRfbGlzdCkgew0KPj4gKwkJYW1kZ3B1X2ZlbmNl
X2RyaXZlcl9pc3JfdG9nZ2xlKHRtcF9hZGV2LCBmYWxzZSk7DQo+PiArCX0NCj4+ICsNCj4+ICAg
IAkvKg0KPj4gICAgCSAqIEFTSUMgcmVzZXQgaGFzIHRvIGJlIGRvbmUgb24gYWxsIFhHTUkgaGl2
ZSBub2RlcyBBU0FQDQo+PiAgICAJICogdG8gYWxsb3cgcHJvcGVyIGxpbmtzIG5lZ290aWF0aW9u
IGluIEZXICh3aXRoaW4gMSBzZWMpIEBADQo+PiAtNTAzMSw4ICs1MDMzLDYgQEAgc3RhdGljIHZv
aWQgYW1kZ3B1X2RldmljZV9yZWNoZWNrX2d1aWx0eV9qb2JzKA0KPj4gICAgCQkJLyogQ2xlYXIg
dGhpcyBmYWlsZWQgam9iIGZyb20gZmVuY2UgYXJyYXkgKi8NCj4+ICAgIAkJCWFtZGdwdV9mZW5j
ZV9kcml2ZXJfY2xlYXJfam9iX2ZlbmNlcyhyaW5nKTsNCj4+ICAgIA0KPj4gLQkJCWFtZGdwdV9m
ZW5jZV9kcml2ZXJfaXNyX3RvZ2dsZShhZGV2LCBmYWxzZSk7DQo+PiAtDQo+PiAgICAJCQkvKiBT
aW5jZSB0aGUgam9iIHdvbid0IHNpZ25hbCBhbmQgd2UgZ28gZm9yDQo+PiAgICAJCQkgKiBhbm90
aGVyIHJlc3VibWl0IGRyb3AgdGhpcyBwYXJlbnQgcG9pbnRlcg0KPj4gICAgCQkJICovDQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2llbm5hX2NpY2hsaWQuYw0K
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaWVubmFfY2ljaGxpZC5jDQo+PiBpbmRl
eCA3YWE1NzBjMWNlNGEuLjk1MzAzNjQ4MmQxZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NpZW5uYV9jaWNobGlkLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NpZW5uYV9jaWNobGlkLmMNCj4+IEBAIC0yNDAsNiArMjQwLDcgQEAgc2ll
bm5hX2NpY2hsaWRfbW9kZTJfcmVzdG9yZV9od2NvbnRleHQoc3RydWN0IGFtZGdwdV9yZXNldF9j
b250cm9sICpyZXNldF9jdGwsDQo+PiAgICAJKiBBZGQgdGhpcyBBU0lDIGFzIHRyYWNrZWQgYXMg
cmVzZXQgd2FzIGFscmVhZHkNCj4+ICAgIAkqIGNvbXBsZXRlIHN1Y2Nlc3NmdWxseS4NCj4+ICAg
IAkqLw0KPj4gKwlhbWRncHVfZmVuY2VfZHJpdmVyX2lzcl90b2dnbGUodG1wX2FkZXYsIGZhbHNl
KTsNCj4+ICAgIAlhbWRncHVfcmVnaXN0ZXJfZ3B1X2luc3RhbmNlKHRtcF9hZGV2KTsNCj4+ICAg
IA0KPj4gICAgCS8qIFJlc3VtZSBSQVMgKi8NCj4+DQo=
