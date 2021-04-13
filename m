Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F4C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 09:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B1260234
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 09:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B1260234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C47C06E221;
	Tue, 13 Apr 2021 09:13:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADD06E221
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 09:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrDfsAB9112eyYAQavbsQl59rR3HBI4DSry+A4CVapCQ7aSF32WozLJEGKF/tGrdfAzkp97GvCLhFbdxNRIwjo48zANHhWFY6CpHwyFb+BLl1rsrjpLNxGuQmAoSjndQlcoLIuaz0mFqD87Zi0xv55LQ/3dsDwaj4JEzvT7t8hpSQrJX3vTPGNP0NfEOhOiMmg26J3lkfeW/xi7IpitxqTfaOlzm0nDGA+kAn3aBrH4ew6VZLtUval/Bmk0k5DM4v/d/hkUCvHdtLGcF/7m38jrSLF5Y7gE4bfR9EE2wpL5urNZjf0AKtsQaOKJsFs2kBz9b3EkYHo4EuoDM/STQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF4Pa1lvzm0/Xek+fq/hEf2sSQX4mB9lIJuxtLp40Ls=;
 b=LSgW/MYO/jU+tT46PyQ0xkvurPxwq/9e5LTX1+hHDc+nNLlVk2SDB/X/23EdSmemigHBMuJiuEkW+hthgKAwMtcFUzV6fNlA4oDgpDGKhvSVcAWNL5MToOkPJEUd9m3OeItZtjNykBoY+9iZzPwruz18kfR9YqPFuIHpWVg8pQVaKsmwBO7SteIsa0FxLfDFsG7+X01PxsVzVVXmVKSusJ/w+LfYGuNSTnRr1tZ8dZUs9N1ZrRaPr+DQlQmMN4xEXWcvQVkGPLi/v/xWOOLOxgGFLBpfAWAFLDtIw82FGsbqSr6Kz6AD6rKSk+3sDyX7FYS3IRJH77oe/TEPLj+BpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF4Pa1lvzm0/Xek+fq/hEf2sSQX4mB9lIJuxtLp40Ls=;
 b=NUD7EFJNa+xqTSpgco5fzTcGTi6jTKL+DLl+SL1oP9qKScXZC/7a2V6J0cIBKlTAfaN+Oy7l1g1zNs84eQNTSV/BMD9O/KR2/cFNq/rMzIU5/W34hVdBfaEmbwFzxuFbfSiJZ8RNH9SVtR9n0qXoaMUW6Zt9um9YtGcXqtOFD9g=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22; Tue, 13 Apr 2021 09:13:45 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::155a:2920:d3ab:e18a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::155a:2920:d3ab:e18a%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 09:13:45 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: RE: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
Thread-Topic: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
Thread-Index: AQHXG8elcJAV9p/5oU2z0/KQ/z+nPqqJYAuAgAAGL5CAAAwNgIAAAveggAALwICAHNHsgIABFkYAgAC1DACAANvYgIAAm04AgADTlACAAAL6gIAAfzQAgAAvpICAABwVgIAAq5iAgAACNgCAAJHJgIAAD+GAgAAbowCAAYXlgIADIs+AgAAE0gCAAASlgIAAARUAgAAD0gCAAAFeAIAADbsAgAABrICAAAvIgIAAuwMAgAAgYxA=
Date: Tue, 13 Apr 2021 09:13:45 +0000
Message-ID: <DM5PR12MB25334B94CB060BD4C3EA4223ED4F9@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
In-Reply-To: <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-13T09:13:37Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=87ad44b9-5412-4e60-af64-084bb32153f8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0faabc9-2b86-4cd6-4c03-08d8fe5c70ee
x-ms-traffictypediagnostic: DM6PR12MB4044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB404419D279703C05F708D06CED4F9@DM6PR12MB4044.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IpJJzIJLuVnZ/zBcLwlZgQuPXz3/Gi6K4RTwSm2ZurR6hesyTcl3IIvo1dq9k/NGjr7VBOdYDzOH7Gyg1H8RWtejYEdRMOOxZRKddl5Ymp84HpLpIMeQBkV5J+IXwdCunjiM5nsUPtG8JNBfBZJGqDQnaxwCg3eqPaDoVJfZtwv04LbTW+KYg6vYgRTim6f9q6v9LMQeB3KVXEjYCJfZDqWFYluzfcm3PZn+KAl9UByoBL1m151b4z6K4RP60hMKVfgCkpEJ6wVKermubDTWby1/ZNMhamGbsjqeLf5xSdISFwq8KpVUDv+pZWhlh3CGPQic91+ReaXTv9MO4lFl28avvsLFgAoBYv2WDdaKjpzjDsRy65FI6huKIVuexhzCLNpF9aXFGDIWOz3cFEStFGWKl6UU0AOIqvRyhEGrqmycHzFnl7uxHV8tXvxsW0ud74+8NrS68lVEzEiybcIqqG1VGQIhO5JUbTWo+FDQtQrUA4UjEaJ6Ac3x8NxZzRToqFgSb0VXYbbbQBUqHJx5iQr5hjpId/BPGhlhJD+aixY+bY1JQY2kwwJ3qxsDPnNkilJTYy5gDHF4bDJL1g8ZdjCu+S0boY4Z1iQT3FQtFpGGPCvuxPW0dcJFf6NN74SmgZrbnkmn8Hu6SfzRsm7X5BvibjyiMlmMlJyt2ZimPewGbVFiSDmhGSuaUHYN3JO3mVy1Kdq71+XQZWDJs0cI25KY/vBwYkPuPFgfOJXQleRLhorWnXnh1p2nRIgw8tY1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(66574015)(55016002)(76116006)(186003)(38100700002)(86362001)(66446008)(9686003)(64756008)(110136005)(6506007)(5660300002)(66476007)(966005)(8936002)(2906002)(26005)(316002)(45080400002)(921005)(33656002)(83380400001)(66556008)(71200400001)(52536014)(66946007)(8676002)(7696005)(478600001)(53546011)(122000001)(60764002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VTJEbmR0ZTZkMTNwZjkwTEh0VmxORXhEZEZ5NDM2N3pXUHY4U241SWhlZ3F2?=
 =?utf-8?B?V3MyOVhKYmhUK3NydkN4Nm5NS2ZHRWxYMUVMNWhoVlNjV084SE1ucGRjdlZs?=
 =?utf-8?B?MkN2cWVBTjJGQlZrWVJpdW9WMlcyNGR6RXRBdk9BY2pPOU8wU2dmYjUrVkhC?=
 =?utf-8?B?L2hIREcxdnM1TWpoSTVuS0IyVkQyVThGSC9XdUdrZmw2aTIraEZUT0pqRHdR?=
 =?utf-8?B?UytQWFhxTUVVUk5CZi9Vd1VDbnBPOC9FTzFaRDVXckFXVEJhQTlNd3pFeTJT?=
 =?utf-8?B?Y3ZNbG81OWNkZEl4WktNamMzTldDSy9CTHV2TW5NZTAxcThhS2dPK1l1ZnE2?=
 =?utf-8?B?VHhFRFFlay92MmJQenk4OGx2NTFmYkVKalhmb2REUVVYcSsxYWU4VFF6ajFH?=
 =?utf-8?B?UFZFNzh0UmkvazFaekEva0ljb0dPSDRGdmJaWlhzN0o4dWZCUXhBaW82ck9i?=
 =?utf-8?B?VmJZT3JDKzduL1ZEOUliK1Jjek1xak1jMG45aUxPTExYc0p1NFpJSG14YUxY?=
 =?utf-8?B?ZnFvdFRmSWZSbGhZcHdzL1hDdk9jZHlqVzdwN0ZlWE4wRmFFTC9XM25VSjlh?=
 =?utf-8?B?VkNta3h4NVNoV2dnZ09ZWFFIR2sxYnhnenl0WFQzektkNVg0bUg2SFAyc0s3?=
 =?utf-8?B?NmdXNzRDa2E0cHUyeElLTTVramF2RTNGN2FhQVFIL3ZpMEFXVFF5TXYwMW9k?=
 =?utf-8?B?ODg3NlppbTlnNWFKais4YkNkclRRdTl3aStyYno3N040MmJJRytzaGZ5YVdI?=
 =?utf-8?B?ZjBUcGJZL1RFa0pjNUVEaEhTSUJLMWtmbURyeXgzb0tSbDEvNVdCUDRTVTZW?=
 =?utf-8?B?T0M1eWRaU0lsU1hJdDlkSUp3OEJYZjNXNm9wSXdtQzhGZGJoanN2T3JHcno2?=
 =?utf-8?B?alF2cmh3K2UraDBYR042SFRvdFlONDJoSStBdXo0dWhwNnpLQW44aVZUaTB4?=
 =?utf-8?B?QTZvNjRIR3lhUjltTTY3V3ZUUHdJZlZqWFQwYWF1Rlh4SG1kU042dktSSTcx?=
 =?utf-8?B?R01Qc0R2cnpXUUVUbXliWE1zdlY5ZzFMVnQrUlh5T01DSWRSUnFvUExnWDVt?=
 =?utf-8?B?NzQ4TVBKRlJ3REhjNkdnT1ZLcDNLN0VDMmhEMjdlK2tJUWt3RkRQandNTEF2?=
 =?utf-8?B?NkxyNGVSTlFxcGJXNm5HYkVrNVIzZi9LYlBzL2V6am1PTmNBMVcyaERxT2JM?=
 =?utf-8?B?ekNyd29sUGhaUHA4RExEUmZ1dW9KZEJVTG5iak93WG5MN3RMUUh6ZFF5dis2?=
 =?utf-8?B?Ykw2emsxS3ZLWG9YSzdFZ0haRlc1WlJwOUxxVVJCMUlvOFNvVTh3eERERHRS?=
 =?utf-8?B?M3RBUVRtQnlHY1pYelIzc1BkUThNcWdhZE1YK2V0dlprd0ppUkpSUTVPbTRn?=
 =?utf-8?B?TmJZeTdvZlZoSDR4eXNtb1p0MnRrMkhoUU91YksxaHJBNVhVV2psUWVQdWpG?=
 =?utf-8?B?M05YYk5oRkh0R3BhOUJZbUYyNStQclpRVlpRZkxGcU9RYUdUYnVoYWpoTmZ5?=
 =?utf-8?B?SGlUNnVXYkZiMWNoemNsU1k4UDhtdElnTjNUQ2lMT0hDemNvSStXYlBZeDhy?=
 =?utf-8?B?WGZaN1dYUjhhK0d4dVBaNFNGejF6YnpKZVJ6Y3l5K2MxNWo0ZnBRb0pMMm9I?=
 =?utf-8?B?ZmthV3YvcUZlVjBBaW9iWVpOa0pQUDk4N2tZeVhZOVdtT00xUlkvRjdjb3Nr?=
 =?utf-8?B?VTZoRXZDZjZjWmJ3RmU1YlRhTlJJWUx0L2FGYmtPNEV2TWdtTVV3ZFdwQlVx?=
 =?utf-8?Q?EIR/O8M6T7IrGPvPn6L23My2szeEG8j6JNwHt9B?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0faabc9-2b86-4cd6-4c03-08d8fe5c70ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 09:13:45.7606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+VvX5NIM/yoQxw/IK6r6PsXnzHELe8sm07dyiJXTFWl91rCjkAzzVEDgTTz++BD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSwgQ2hyaXN0aWFuIGFuZCBBbmRyZXksDQogICAgICBXZSBtYXliZSB0cnkgdG8gaW1wbGVtZW50
ICJ3YWl0IiBjYWxsYmFjayBmdW5jdGlvbiBvZiBkbWFfZmVuY2Vfb3BzLCB3aGVuIEdQVSByZXNl
dCBvciB1bnBsdWcgaGFwcGVuLCBtYWtlIHRoaXMgY2FsbGJhY2sgcmV0dXJuIC0gRU5PREVWLCB0
byBub3RpZnkgdGhlIGNhbGxlciBkZXZpY2UgbG9zdC4gDQoNCgkgKiBNdXN0IHJldHVybiAtRVJF
U1RBUlRTWVMgaWYgdGhlIHdhaXQgaXMgaW50ciA9IHRydWUgYW5kIHRoZSB3YWl0IHdhcw0KCSAq
IGludGVycnVwdGVkLCBhbmQgcmVtYWluaW5nIGppZmZpZXMgaWYgZmVuY2UgaGFzIHNpZ25hbGVk
LCBvciAwIGlmIHdhaXQNCgkgKiB0aW1lZCBvdXQuIENhbiBhbHNvIHJldHVybiBvdGhlciBlcnJv
ciB2YWx1ZXMgb24gY3VzdG9tIGltcGxlbWVudGF0aW9ucywNCgkgKiB3aGljaCBzaG91bGQgYmUg
dHJlYXRlZCBhcyBpZiB0aGUgZmVuY2UgaXMgc2lnbmFsZWQuIEZvciBleGFtcGxlIGEgaGFyZHdh
cmUNCgkgKiBsb2NrdXAgY291bGQgYmUgcmVwb3J0ZWQgbGlrZSB0aGF0Lg0KCSAqDQoJICogVGhp
cyBjYWxsYmFjayBpcyBvcHRpb25hbC4NCgkgKi8NCglzaWduZWQgbG9uZyAoKndhaXQpKHN0cnVj
dCBkbWFfZmVuY2UgKmZlbmNlLA0KCQkJICAgIGJvb2wgaW50ciwgc2lnbmVkIGxvbmcgdGltZW91
dCk7DQoNCkJlc3QgUmVnYXJkcw0KRGVubmlzIExpDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5j
b20+IA0KU2VudDogVHVlc2RheSwgQXByaWwgMTMsIDIwMjEgMzoxMCBQTQ0KVG86IEdyb2R6b3Zz
a3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBMaSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5n
QGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGFuaWVs
IFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPg0KU3ViamVjdDogUmU6IFtQQVRDSCAwLzRdIFJlZmlu
ZSBHUFUgcmVjb3Zlcnkgc2VxdWVuY2UgdG8gZW5oYW5jZSBpdHMgc3RhYmlsaXR5DQoNCkFtIDEy
LjA0LjIxIHVtIDIyOjAxIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6DQo+DQo+IE9uIDIwMjEt
MDQtMTIgMzoxOCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPj4gQW0gMTIuMDQuMjEg
dW0gMjE6MTIgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToNCj4+PiBbU05JUF0NCj4+Pj4+DQo+
Pj4+PiBTbyB3aGF0J3MgdGhlIHJpZ2h0IGFwcHJvYWNoID8gSG93IHdlIGd1YXJhbnRlZSB0aGF0
IHdoZW4gcnVubmluZyANCj4+Pj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlv
biB3ZSB3aWxsIHNpZ25hbCBhbGwgdGhlIEhXIA0KPj4+Pj4gZmVuY2VzIGFuZCBub3QgcmFjaW5n
IGFnYWluc3Qgc29tZSBtb3JlIGZlbmNlcyBpbnNlcnRpb24gaW50byB0aGF0IA0KPj4+Pj4gYXJy
YXkgPw0KPj4+Pj4NCj4+Pj4NCj4+Pj4gV2VsbCBJIHdvdWxkIHN0aWxsIHNheSB0aGUgYmVzdCBh
cHByb2FjaCB3b3VsZCBiZSB0byBpbnNlcnQgdGhpcyANCj4+Pj4gYmV0d2VlbiB0aGUgZnJvbnQg
ZW5kIGFuZCB0aGUgYmFja2VuZCBhbmQgbm90IHJlbHkgb24gc2lnbmFsaW5nIA0KPj4+PiBmZW5j
ZXMgd2hpbGUgaG9sZGluZyB0aGUgZGV2aWNlIHNyY3UuDQo+Pj4NCj4+Pg0KPj4+IE15IHF1ZXN0
aW9uIGlzLCBldmVuIG5vdywgd2hlbiB3ZSBydW4gDQo+Pj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9m
aW5pX2h3LT5hbWRncHVfZmVuY2Vfd2FpdF9lbXB0eSBvciANCj4+PiBhbWRncHVfZmVuY2VfZHJp
dmVyX2ZpbmlfaHctPmFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbiwNCj4+PiB3
aGF0IHRoZXJlIHByZXZlbnRzIGEgcmFjZSB3aXRoIGFub3RoZXIgZmVuY2UgYmVpbmcgYXQgdGhl
IHNhbWUgdGltZSANCj4+PiBlbWl0dGVkIGFuZCBpbnNlcnRlZCBpbnRvIHRoZSBmZW5jZSBhcnJh
eSA/IExvb2tzIGxpa2Ugbm90aGluZy4NCj4+Pg0KPj4NCj4+IEVhY2ggcmluZyBjYW4gb25seSBi
ZSB1c2VkIGJ5IG9uZSB0aHJlYWQgYXQgdGhlIHNhbWUgdGltZSwgdGhpcyANCj4+IGluY2x1ZGVz
IGVtaXR0aW5nIGZlbmNlcyBhcyB3ZWxsIGFzIG90aGVyIHN0dWZmLg0KPj4NCj4+IER1cmluZyBH
UFUgcmVzZXQgd2UgbWFrZSBzdXJlIG5vYm9keSB3cml0ZXMgdG8gdGhlIHJpbmdzIGJ5IHN0b3Bw
aW5nIA0KPj4gdGhlIHNjaGVkdWxlciBhbmQgdGFraW5nIHRoZSBHUFUgcmVzZXQgbG9jayAoc28g
dGhhdCBub2JvZHkgZWxzZSBjYW4gDQo+PiBzdGFydCB0aGUgc2NoZWR1bGVyIGFnYWluKS4NCj4N
Cj4NCj4gV2hhdCBhYm91dCBkaXJlY3Qgc3VibWlzc2lvbnMgbm90IHRocm91Z2ggc2NoZWR1bGVy
IC0gDQo+IGFtZGdwdV9qb2Jfc3VibWl0X2RpcmVjdCwgSSBkb24ndCBzZWUgaG93IHRoaXMgaXMg
cHJvdGVjdGVkLg0KDQpUaG9zZSBvbmx5IGhhcHBlbiBkdXJpbmcgc3RhcnR1cCBhbmQgR1BVIHJl
c2V0Lg0KDQo+Pg0KPj4+Pg0KPj4+PiBCVFc6IENvdWxkIGl0IGJlIHRoYXQgdGhlIGRldmljZSBT
UkNVIHByb3RlY3RzIG1vcmUgdGhhbiBvbmUgZGV2aWNlIA0KPj4+PiBhbmQgd2UgZGVhZGxvY2sg
YmVjYXVzZSBvZiB0aGlzPw0KPj4+DQo+Pj4NCj4+PiBJIGhhdmVuJ3QgYWN0dWFsbHkgZXhwZXJp
ZW5jZWQgYW55IGRlYWRsb2NrIHVudGlsIG5vdyBidXQsIHllcywgDQo+Pj4gZHJtX3VucGx1Z19z
cmN1IGlzIGRlZmluZWQgYXMgc3RhdGljIGluIGRybV9kcnYuYyBhbmQgc28gaW4gdGhlIA0KPj4+
IHByZXNlbmNlwqAgb2YgbXVsdGlwbGUgZGV2aWNlcyBmcm9tIHNhbWUgb3IgZGlmZmVyZW50IGRy
aXZlcnMgd2UgaW4gDQo+Pj4gZmFjdCBhcmUgZGVwZW5kZW50IG9uIGFsbCB0aGVpciBjcml0aWNh
bCBzZWN0aW9ucyBpIGd1ZXNzLg0KPj4+DQo+Pg0KPj4gU2hpdCwgeWVhaCB0aGUgZGV2aWwgaXMg
YSBzcXVpcnJlbC4gU28gZm9yIEErSSBsYXB0b3BzIHdlIGFjdHVhbGx5IA0KPj4gbmVlZCB0byBz
eW5jIHRoYXQgdXAgd2l0aCBEYW5pZWwgYW5kIHRoZSByZXN0IG9mIHRoZSBpOTE1IGd1eXMuDQo+
Pg0KPj4gSUlSQyB3ZSBjb3VsZCBhY3R1YWxseSBoYXZlIGFuIGFtZGdwdSBkZXZpY2UgaW4gYSBk
b2NraW5nIHN0YXRpb24gDQo+PiB3aGljaCBuZWVkcyBob3RwbHVnIGFuZCB0aGUgZHJpdmVyIG1p
Z2h0IGRlcGVuZCBvbiB3YWl0aW5nIGZvciB0aGUNCj4+IGk5MTUgZHJpdmVyIGFzIHdlbGwuDQo+
DQo+DQo+IENhbid0IHdlIHByb3Bvc2UgYSBwYXRjaCB0byBtYWtlIGRybV91bnBsdWdfc3JjdSBw
ZXIgZHJtX2RldmljZSA/IEkgDQo+IGRvbid0IHNlZSB3aHkgaXQgaGFzIHRvIGJlIGdsb2JhbCBh
bmQgbm90IHBlciBkZXZpY2UgdGhpbmcuDQoNCkknbSByZWFsbHkgd29uZGVyaW5nIHRoZSBzYW1l
IHRoaW5nIGZvciBxdWl0ZSBhIHdoaWxlIG5vdy4NCg0KQWRkaW5nIERhbmllbCBhcyB3ZWxsLCBt
YXliZSBoZSBrbm93cyB3aHkgdGhlIGRybV91bnBsdWdfc3JjdSBpcyBnbG9iYWwuDQoNClJlZ2Fy
ZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gQW5kcmV5DQo+DQo+DQo+Pg0KPj4gQ2hyaXN0aWFuLg0K
Pj4NCj4+PiBBbmRyZXkNCj4+Pg0KPj4+DQo+Pj4+DQo+Pj4+IENocmlzdGlhbi4NCj4+Pj4NCj4+
Pj4+IEFuZHJleQ0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+Pj4gQW5kcmV5DQo+Pj4+Pj4+
DQo+Pj4+Pj4+DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gQ2hyaXN0aWFuLg0KPj4+Pj4+Pj4NCj4+Pj4+
Pj4+PiDCoMKgwqAgLyogUGFzdCB0aGlzIHBvaW50IG5vIG1vcmUgZmVuY2UgYXJlIHN1Ym1pdHRl
ZCB0byBIVyByaW5nIA0KPj4+Pj4+Pj4+IGFuZCBoZW5jZSB3ZSBjYW4gc2FmZWx5IGNhbGwgZm9y
Y2Ugc2lnbmFsIG9uIGFsbCB0aGF0IGFyZSANCj4+Pj4+Pj4+PiBjdXJyZW50bHkgdGhlcmUuDQo+
Pj4+Pj4+Pj4gwqDCoMKgwqAgKiBBbnkgc3Vic2VxdWVudGx5IGNyZWF0ZWTCoCBIVyBmZW5jZXMg
d2lsbCBiZSByZXR1cm5lZCANCj4+Pj4+Pj4+PiBzaWduYWxlZCB3aXRoIGFuIGVycm9yIGNvZGUg
cmlnaHQgYXdheQ0KPj4+Pj4+Pj4+IMKgwqDCoMKgICovDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiDC
oMKgwqAgZm9yX2VhY2hfcmluZyhhZGV2KQ0KPj4+Pj4+Pj4+IMKgwqDCoCDCoMKgwqAgYW1kZ3B1
X2ZlbmNlX3Byb2Nlc3MocmluZykNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IMKgwqDCoCBkcm1fZGV2
X3VucGx1ZyhkZXYpOw0KPj4+Pj4+Pj4+IMKgwqDCoCBTdG9wIHNjaGVkdWxlcnMNCj4+Pj4+Pj4+
PiDCoMKgwqAgY2FuY2VsX3N5bmMoYWxsIHRpbWVycyBhbmQgcXVldWVkIHdvcmtzKTsNCj4+Pj4+
Pj4+PiDCoMKgwqAgaHdfZmluaQ0KPj4+Pj4+Pj4+IMKgwqDCoCB1bm1hcF9tbWlvDQo+Pj4+Pj4+
Pj4NCj4+Pj4+Pj4+PiB9DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEFuZHJleQ0K
Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+
DQo+Pj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+Pj4gQWx0ZXJuYXRpdmVseSBncmFiYmluZyB0
aGUgcmVzZXQgd3JpdGUgc2lkZSBhbmQgc3RvcHBpbmcgDQo+Pj4+Pj4+Pj4+Pj4+PiBhbmQgdGhl
biByZXN0YXJ0aW5nIHRoZSBzY2hlZHVsZXIgY291bGQgd29yayBhcyB3ZWxsLg0KPj4+Pj4+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4NCj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4gSSBkaWRuJ3QgZ2V0IHRoZSBhYm92ZSBhbmQgSSBkb24ndCBz
ZWUgd2h5IEkgbmVlZCB0byByZXVzZSANCj4+Pj4+Pj4+Pj4+Pj4gdGhlIEdQVSByZXNldCByd19s
b2NrLiBJIHJlbHkgb24gdGhlIFNSQ1UgdW5wbHVnIGZsYWcgZm9yIA0KPj4+Pj4+Pj4+Pj4+PiB1
bnBsdWcuIEFsc28sIG5vdCBjbGVhciB0byBtZSB3aHkgYXJlIHdlIGZvY3VzaW5nIG9uIHRoZSAN
Cj4+Pj4+Pj4+Pj4+Pj4gc2NoZWR1bGVyIHRocmVhZHMsIGFueSBjb2RlIHBhdGNoIHRvIGdlbmVy
YXRlIEhXIGZlbmNlcyANCj4+Pj4+Pj4+Pj4+Pj4gc2hvdWxkIGJlIGNvdmVyZWQsIHNvIGFueSBj
b2RlIGxlYWRpbmcgdG8gDQo+Pj4+Pj4+Pj4+Pj4+IGFtZGdwdV9mZW5jZV9lbWl0IG5lZWRzIHRv
IGJlIHRha2VuIGludG8gYWNjb3VudCBzdWNoIGFzLCANCj4+Pj4+Pj4+Pj4+Pj4gZGlyZWN0IElC
IHN1Ym1pc3Npb25zLCBWTSBmbHVzaGVzIGUudC5jDQo+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+
PiBZb3UgbmVlZCB0byB3b3JrIHRvZ2V0aGVyIHdpdGggdGhlIHJlc2V0IGxvY2sgYW55d2F5LCBj
YXVzZSANCj4+Pj4+Pj4+Pj4+PiBhIGhvdHBsdWcgY291bGQgcnVuIGF0IHRoZSBzYW1lIHRpbWUg
YXMgYSByZXNldC4NCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4gRm9yIGdv
aW5nIG15IHdheSBpbmRlZWQgbm93IEkgc2VlIG5vdyB0aGF0IEkgaGF2ZSB0byB0YWtlIA0KPj4+
Pj4+Pj4+Pj4gcmVzZXQgd3JpdGUgc2lkZSBsb2NrIGR1cmluZyBIVyBmZW5jZXMgc2lnbmFsbGlu
ZyBpbiBvcmRlciANCj4+Pj4+Pj4+Pj4+IHRvIHByb3RlY3QgYWdhaW5zdCBzY2hlZHVsZXIvSFcg
ZmVuY2VzIGRldGFjaG1lbnQgYW5kIA0KPj4+Pj4+Pj4+Pj4gcmVhdHRhY2htZW50IGR1cmluZyBz
Y2hlZHVsZXJzIHN0b3AvcmVzdGFydC4gQnV0IGlmIHdlIGdvIA0KPj4+Pj4+Pj4+Pj4gd2l0aCB5
b3VyIGFwcHJvYWNowqAgdGhlbiBjYWxsaW5nIGRybV9kZXZfdW5wbHVnIGFuZCBzY29waW5nIA0K
Pj4+Pj4+Pj4+Pj4gYW1kZ3B1X2pvYl90aW1lb3V0IHdpdGggZHJtX2Rldl9lbnRlci9leGl0IHNo
b3VsZCBiZSBlbm91Z2ggDQo+Pj4+Pj4+Pj4+PiB0byBwcmV2ZW50IGFueSBjb25jdXJyZW50IEdQ
VSByZXNldHMgZHVyaW5nIHVucGx1Zy4gSW4gZmFjdCANCj4+Pj4+Pj4+Pj4+IEkgYWxyZWFkeSBk
byBpdCBhbnl3YXkgLQ0KPj4+Pj4+Pj4+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzOiUyDQo+Pj4+Pj4+Pj4+PiBGJTJGY2dpdC5mcmVl
ZGVza3RvcC5vcmclMkZ+YWdyb2R6b3YlMkZsaW51eCUyRmNvbW1pdCUyRiUzRmgNCj4+Pj4+Pj4+
Pj4+ICUzRGRybS1taXNjLW5leHQlMjZpZCUzRGVmMGVhNGRkMjllZjQ0ZDI2NDljNWVkYTE2Yzhm
NDg2OWFjYw0KPj4+Pj4+Pj4+Pj4gMzZiMSZhbXA7ZGF0YT0wNCU3QzAxJTdDRGVubmlzLkxpJTQw
YW1kLmNvbSU3Q2M3ZmM2Y2I1MDVjMzRhDQo+Pj4+Pj4+Pj4+PiBlZGZlNmQwOGQ4ZmU0YjM5NDcl
N0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MNCj4+Pj4+Pj4+Pj4+IDAl
N0M2Mzc1Mzg5NDYzMjMxOTQxNTElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3
TA0KPj4+Pj4+Pj4+Pj4gakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENK
WFZDSTZNbjAlM0QlN0MxMDAwDQo+Pj4+Pj4+Pj4+PiAmYW1wO3NkYXRhPSUyRmUlMkJxSk5sY3VV
akxIc0x2ZkhDS3FlckslMkZmOGx6dWpxT0Jobk1CSVJQOEUNCj4+Pj4+Pj4+Pj4+ICUzRCZhbXA7
cmVzZXJ2ZWQ9MA0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBZZXMsIGdvb2QgcG9pbnQgYXMgd2Vs
bC4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+Pj4+IEFuZHJleQ0KPj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+DQo+Pj4+
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4NCj4+Pj4+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+PiBBbmRyZXkNCj4+Pj4+Pj4+Pj4+Pj4N
Cj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+
Pj4+Pj4+PiBDaHJpc3RpYW4uDQo+Pj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5DQo+Pj4+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4+Pj4+
DQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQ0KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+
Pj4+DQo+Pj4+Pj4NCj4+Pj4NCj4+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
