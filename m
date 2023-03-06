Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E86C678D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 11:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A1410E2F5;
	Mon,  6 Mar 2023 11:58:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9371F10E2FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 11:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0jQfegb3f0Ok6MD7QLRcp2xQi+QwfMFouTgbzlMTgCALJoF0YINbTP+T+WwrJSXcRtG1MGdWumh2jEmkeXulGs4/o3SyXYfGJsuWXARTOi5p5hNNQYTpbDT2sIgfZM5eA4HdByUaR+CjpIY7szXj/9MwSyXbgJ6cKIHRtQL0s6aCSD4NCt1hrTngSj+4/mbBszRKoG+w6SrUCdlUs4ch65rWe2msO2GyEY+4JRmFUrjSMFlRarwrtiydrUroMHSbIlvXlT/lKo0zZmVqc+JTFfqOMVBksYMnZiKwqkOBkGjlarvqY4iPl8GhnKGLKGMcbPrZBjbETgn6f2cnpPEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9p2c/io8xhg29PEZyyB7yRfqbCpvNfK2I2aAIcBR/A=;
 b=PNiPDjjmuGut8WyZY/ngKMQsDhvwKzPAuF1qQCemQLnQkXulm5TEKUenzejFVZfO6lCbpKmQ3aLClqwXuMo3KSUSb8O7v+oprdZbQgHuIraLEHpHyaf4Zd/IhO96C+Is/EtcMxbdgMTSVOSi2zETK3rZ4ximVf1wGHhnUgvSDCStZB4Cz7DvtsdeqEz9kRQVpYXY2cvwR5Ifa/wPAap4uslE5ikt1OtQMyt89hQI3pP5kgyp3T0sarkAcyWbu56s0iZ3qdRLOZrXwyBJ5Ot82GuLeeSi+g8hPCOslt8/4Lb3rkhCMjbWc1FPd56cicDZrRv5c0GBlMIl49SDZUXemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9p2c/io8xhg29PEZyyB7yRfqbCpvNfK2I2aAIcBR/A=;
 b=xbrh5CN2ZsHTD3KWK2bW7z3aHggCLsKSCNbsD32OyXUGvnuQ2YpCaxyi/dBcagT1R4ejh85m+EG99+Fv14LHLVAL2oJgQrxegGW81tuSk+VwKImgaYeZWg3rdE2hywP2sVOVSyNJmfHegBA313HCaBIFv4hg8bVxKzWVX+ZYnYs=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Mon, 6 Mar
 2023 11:58:45 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::4083:34d5:f1ee:396a]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::4083:34d5:f1ee:396a%9]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 11:58:44 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Retire pcie_gen3_enable function
Thread-Topic: [PATCH] drm/amdgpu: Retire pcie_gen3_enable function
Thread-Index: AQHZUCAqg+JcJRCIJkyi4kwjH0u8La7tpYCT
Date: Mon, 6 Mar 2023 11:58:44 +0000
Message-ID: <DM4PR12MB518194987252D36A9D7B2C9DEFB69@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20230306113718.25513-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230306113718.25513-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-06T11:57:50.7260779Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|PH7PR12MB6465:EE_
x-ms-office365-filtering-correlation-id: 5e98519a-1cb6-4046-b2e9-08db1e3a231a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /2NeM/4PM03gpTahkJlLBtuIt13do+J8m91rRKqEww4rZHqlSMiVr5/tSDHFwgPutnai49I8ChJEVrbzZqmuVO8+E9Psx1iWf/03MP66z+cIBXQattd5SE2be3MrOVDbJqRkP1JvZ66ZLD3g+Wb35rUnXkr8ryU09mnM/U5eJDso950/mzpVKExtQq9ziF6VO5iHLqF7mk/VWFI+MmS5iyMt0rMOsPgujTU9dAoRORjLkL6Rzw8+oMZO3UUyOgt81od1Kmz25owl3CJqPUdTnSJt05ij+PDa0vvJIl+Wi7KjE+B5q/3xzG8W3GslM3Gs/rYdmfbRU9JI0ZHrRuw/Mm+PVs00aYbwYpkQoiJk5ts80pFVpnrhvRdU8ZMi9BD7EdNEy7ySO6+t33W5C8iYAhkCeuVu2dQzx/7XChNcuZbavrn9yX8zadVZZqyW2jVD2rxvWndSXr7/ZCucBl/FHbkvkZ7ze5I8nrWyUo67zBSDCJ0HuSOGmCAmKYFQfiqv/+ju7AMjK8LqVZ1AcomLo57SxU7ZnWgGVLgAw7pAPfnzEXG/KAuHCI9wQGQNMsmq6xxLoKqCP7kn/LZvjajRcFl71pd65PtuMIRAuW7kbw7ICv2QIQI1uMhbft7p/gzm/HHHZnCJgemo1wCvePbJSnZHZvmQ8/rpS8I6dRyAlq3ENX4CI5fBZS7mcRrpIBcr+0e+i1SjXQcdAlRDG9jACg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199018)(5660300002)(33656002)(83380400001)(478600001)(7696005)(9686003)(71200400001)(6506007)(26005)(91956017)(64756008)(4326008)(66556008)(8676002)(66476007)(66446008)(76116006)(38070700005)(66946007)(55016003)(8936002)(52536014)(41300700001)(110136005)(86362001)(186003)(38100700002)(316002)(122000001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R1VEWlZuN1ZhTzYvdFNid1JrWEEwaWpZM01QSU1lZWduUkN6b2NhM3FRYlFV?=
 =?gb2312?B?azBVbFJRZUt5VU95QzNiVWV4NzJpdHV6UU1OUmdHZ00vTlpIbTUrelhRc1lh?=
 =?gb2312?B?T0VsZmZyTkF6QmhIamhlbXBaL2x5RXkxeWF6UlEyd1lCZXNHYjQ0NlFGNVBw?=
 =?gb2312?B?WG5sU2sxcjVGUzhTVjhOWmNaZkhBRzFwVnd6bENZdGFxRVExd0hPQXhNN29O?=
 =?gb2312?B?bDVPRDZWRkk4anZSQ0xJY2RhK3JTN1lYUWRNelMvNEpnWVhNSWc3R2w5Y1Vk?=
 =?gb2312?B?MEdZV1FEMUtuQTZKcENyQ1Zab2xTZ3ltYkRiV3o2N1VWbVJOeHlLN3FUS1FM?=
 =?gb2312?B?cGJSRkxYYWhtbExhOTQvOW05SEt3N2tkNEozdVZCZGVGSVBwQThnWFI3TzlK?=
 =?gb2312?B?akRtMDc2SU5LQm5XaHVyV3p6VDVHbWZZYzhieTNvTndSeFV0QVNDVXRpNjdI?=
 =?gb2312?B?aHN5eUdDVm91dk5tU0NsOWF4TncvR2kwdDI2U0RxRmdHZkY0NTFOTWxjWHFR?=
 =?gb2312?B?dENJRnh5WVRyL2I4dURtczBhUjNNZk5QNXJNUTJpT0JZdzVCT05PaVhURVBK?=
 =?gb2312?B?OEEybmo4NW9DL21mNWZFZW5QZ05KU0hGNUJHOXltWnZrSGxCSThyZEwzZTRQ?=
 =?gb2312?B?Z3lsdEN3VkFjK2U5UlJHWVZTelF2a0d6OGdZc2hYWnVEb1pCbUNScWE0Mk45?=
 =?gb2312?B?UlJ6RW9IT0JMWnAveGhxckx0OGdSU0xOUXUwem4xS3dVYUNKR0VUQnFmRWp3?=
 =?gb2312?B?eVJSS2ZGQk9ERFdTY3lrZEFEQmZsTEF4SHFaS29qaTRWUDRGWGlrNWdVZVF6?=
 =?gb2312?B?OFAwMTczdjFHREY3Z2JxV0ROeVNiWXA3dmF2SnphVWpTcXBtMjloRS8yQUta?=
 =?gb2312?B?M0h6d2tzNWZwNXVSY1ZEcGJ0T2tac1JiV1MyS2VWQVdibEU4R0NYNElkaVZj?=
 =?gb2312?B?ckJRNUN4YmZ6MXdHcGxtdFZlenNlSGg1SjgyWVlkYmRCc0JZNEpPU2puV1hq?=
 =?gb2312?B?T0ZOM0tEWmpvRlRyejFqMGVzVXM2dG9rZVZobUZTOU9velptVm1xL0d3MUhq?=
 =?gb2312?B?SXJVakV2Z2NyNGpYV21JcCtIK2NhQWhzUVlreDlmcUVPU2ZUME1QRmt3TnNT?=
 =?gb2312?B?ZFFzbGpwS2tOTlNObFBlMFIzZnBhNGgrT25rMkdCSkh2VlByZ2wwNVFNbUNl?=
 =?gb2312?B?MDF3YWZBQ0ZYV2lYUXZYbDZubTVIRGlESVpjbFA1aVczQ2lFU2F3MDdYMnFB?=
 =?gb2312?B?TUlSOGlPM0NFcGZuZm5yNGo5dDdJTCt2SGRuUXM2WmV2N2NLV2YyVnUrQjVh?=
 =?gb2312?B?MVl4YWNma3QzR3kzWTllYWx2Z2JCelFYWXNtSkdSTmRadTVXMjUzbmNiM1FW?=
 =?gb2312?B?dGJBUlFmaUFXVjNlaitUbmlSMVNwWTVSQjgyVzBUTXBFUi9oRVhHOFQzL0NL?=
 =?gb2312?B?TVhVTjRxMmRhTkhaWWxjTVYyaDJiWDcwM3lxUzlXMzUxRFFnM1FxOFBGdUpx?=
 =?gb2312?B?SDI5bkxDWjE3SVBNeWFPdTVzNFExZHRnTTJWMFVoMW0rZEFkSnZ6YSthN053?=
 =?gb2312?B?M0ZBQ21kY2dOdWNMeTZ2cFduTlVCY2ZEWUNzRWFXTnc0dll2TXlKSk9HVllB?=
 =?gb2312?B?aEtydXpiTk42d1BrVm5BK0N0aFgycTByekJTWUh3RytMNlUzbExDeGFyMjJw?=
 =?gb2312?B?M2lRQVR0MFU4TGhKRUQ5YnoxT0VWUkpLZUxlVFZYTTliZGkzNkZVMWlxNFl4?=
 =?gb2312?B?VXliY3Yvck9JcGZjY1pwMXZycXRwNk5KWCtORTlwYTZWQW92UFRIMzlEVytU?=
 =?gb2312?B?V3gwK2lhNEd0WGpUMjVuNVpGZm9ja0FkZ3ZGb1F4a3lBTDFhQnFaTXkyQndp?=
 =?gb2312?B?VWRxejhDdEo3QkFwL3RudDQzM3pQL2tvd0lQVW1BUU9ra2JpQVZyTjlWazhN?=
 =?gb2312?B?NWZJOTl2WGhmNllPazRRNDFyOUxySHpUY3JyVjljcGI1ek1sN096eHpBb2xk?=
 =?gb2312?B?eDArOVRZbGw1T21rVWcwSEdsVi80eDkzbU9FdEFQSnkvdVVhbS9lQUwvR3hT?=
 =?gb2312?B?cVdVc0FleGlQNXI3bCtiNkJLamZZMHM5eTJsalNTTkp2TmllTllGWTgvd3JS?=
 =?gb2312?Q?+zqQEgLaAyfBwm8nYHyK6g4KH?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB518194987252D36A9D7B2C9DEFB69DM4PR12MB5181namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e98519a-1cb6-4046-b2e9-08db1e3a231a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 11:58:44.8478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drzP+C0I4m3kPX57NZr2K1SWS7Kb3Z/qWTGOX6oe0MThMTPunPdTtRIikky1cpu5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB518194987252D36A9D7B2C9DEFB69DM4PR12MB5181namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoaXMgcGF0Y2ggaXMgUmV2aWV3
ZWQtYnk6IExpa3VuIEdhbyA8TGlrdW4uR2FvQGFtZC5jb20+Lg0KDQpSZWdhcmRzLA0KTGlrdW4N
Cg0KDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogYW1kLWdm
eCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gtPqx7SBIYXdraW5nIFpo
YW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQq3osvNyrG85DogMjAyM8TqM9TCNsjV0MfG2tK7
IM/Czuc3OjM4DQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IEdhbywgTGlrdW4gPExpa3VuLkdhb0BhbWQuY29tPg0K
s63LzTogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCtb3zOI6IFtQQVRD
SF0gZHJtL2FtZGdwdTogUmV0aXJlIHBjaWVfZ2VuM19lbmFibGUgZnVuY3Rpb24NCg0KTm90IG5l
ZWRlZCBzaW5jZSBmcm9tIHZpLiBkcm9wIHRoZSBmdW5jdGlvbiBzbw0Kd2UgZG9uJ3QgZHVwbGlj
YXRlIGNvZGUgd2hlbiBpbnRyb2R1Y2UgbmV3IGFzaWNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBIYXdr
aW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9udi5jICAgIHwgMTcgLS0tLS0tLS0tLS0tLS0tLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgMjAgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jIHwgMTcgLS0tLS0tLS0tLS0tLS0tLS0NCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jICAgIHwgMjAgLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CiA0IGZpbGVzIGNoYW5nZWQsIDc0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252
LmMNCmluZGV4IDQ5MmE4YjE0ODIyNy4uZDU2Y2JhMTBjZDVhIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbnYuYw0KQEAgLTUxOSwyMSArNTE5LDYgQEAgc3RhdGljIGludCBudl9zZXRfdmNlX2Nsb2Nr
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIGV2Y2xrLCB1MzIgZWNjbGspDQogICAg
ICAgICByZXR1cm4gMDsNCiB9DQoNCi1zdGF0aWMgdm9pZCBudl9wY2llX2dlbjNfZW5hYmxlKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KLXsNCi0gICAgICAgaWYgKHBjaV9pc19yb290X2J1
cyhhZGV2LT5wZGV2LT5idXMpKQ0KLSAgICAgICAgICAgICAgIHJldHVybjsNCi0NCi0gICAgICAg
aWYgKGFtZGdwdV9wY2llX2dlbjIgPT0gMCkNCi0gICAgICAgICAgICAgICByZXR1cm47DQotDQot
ICAgICAgIGlmICghKGFkZXYtPnBtLnBjaWVfZ2VuX21hc2sgJiAoQ0FJTF9QQ0lFX0xJTktfU1BF
RURfU1VQUE9SVF9HRU4yIHwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBDQUlMX1BDSUVfTElOS19TUEVFRF9TVVBQT1JUX0dFTjMpKSkNCi0gICAgICAgICAgICAgICBy
ZXR1cm47DQotDQotICAgICAgIC8qIHRvZG8gKi8NCi19DQotDQogc3RhdGljIHZvaWQgbnZfcHJv
Z3JhbV9hc3BtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIHsNCiAgICAgICAgIGlmICgh
YW1kZ3B1X2RldmljZV9zaG91bGRfdXNlX2FzcG0oYWRldikpDQpAQCAtMTA0MSw4ICsxMDI2LDYg
QEAgc3RhdGljIGludCBudl9jb21tb25faHdfaW5pdCh2b2lkICpoYW5kbGUpDQogICAgICAgICBp
ZiAoYWRldi0+bmJpby5mdW5jcy0+YXBwbHlfbDFfbGlua193aWR0aF9yZWNvbmZpZ193YSkNCiAg
ICAgICAgICAgICAgICAgYWRldi0+bmJpby5mdW5jcy0+YXBwbHlfbDFfbGlua193aWR0aF9yZWNv
bmZpZ193YShhZGV2KTsNCg0KLSAgICAgICAvKiBlbmFibGUgcGNpZSBnZW4yLzMgbGluayAqLw0K
LSAgICAgICBudl9wY2llX2dlbjNfZW5hYmxlKGFkZXYpOw0KICAgICAgICAgLyogZW5hYmxlIGFz
cG0gKi8NCiAgICAgICAgIG52X3Byb2dyYW1fYXNwbShhZGV2KTsNCiAgICAgICAgIC8qIHNldHVw
IG5iaW8gcmVnaXN0ZXJzICovDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCmluZGV4IDJj
MzdiNDlmNWMwMC4uMTA2NDk3MmRjNTU4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc29jMTUuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUu
Yw0KQEAgLTYwOSwyNCArNjA5LDYgQEAgc3RhdGljIGludCBzb2MxNV9zZXRfdmNlX2Nsb2Nrcyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIGV2Y2xrLCB1MzIgZWNjbGsNCiAgICAgICAg
IHJldHVybiAwOw0KIH0NCg0KLXN0YXRpYyB2b2lkIHNvYzE1X3BjaWVfZ2VuM19lbmFibGUoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQotew0KLSAgICAgICBpZiAocGNpX2lzX3Jvb3RfYnVz
KGFkZXYtPnBkZXYtPmJ1cykpDQotICAgICAgICAgICAgICAgcmV0dXJuOw0KLQ0KLSAgICAgICBp
ZiAoYW1kZ3B1X3BjaWVfZ2VuMiA9PSAwKQ0KLSAgICAgICAgICAgICAgIHJldHVybjsNCi0NCi0g
ICAgICAgaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkNCi0gICAgICAgICAgICAgICByZXR1
cm47DQotDQotICAgICAgIGlmICghKGFkZXYtPnBtLnBjaWVfZ2VuX21hc2sgJiAoQ0FJTF9QQ0lF
X0xJTktfU1BFRURfU1VQUE9SVF9HRU4yIHwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBDQUlMX1BDSUVfTElOS19TUEVFRF9TVVBQT1JUX0dFTjMpKSkNCi0gICAgICAg
ICAgICAgICByZXR1cm47DQotDQotICAgICAgIC8qIHRvZG8gKi8NCi19DQotDQogc3RhdGljIHZv
aWQgc29jMTVfcHJvZ3JhbV9hc3BtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIHsNCiAg
ICAgICAgIGlmICghYW1kZ3B1X2RldmljZV9zaG91bGRfdXNlX2FzcG0oYWRldikpDQpAQCAtMTE4
Myw4ICsxMTY1LDYgQEAgc3RhdGljIGludCBzb2MxNV9jb21tb25faHdfaW5pdCh2b2lkICpoYW5k
bGUpDQogew0KICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKiloYW5kbGU7DQoNCi0gICAgICAgLyogZW5hYmxlIHBjaWUgZ2VuMi8zIGxp
bmsgKi8NCi0gICAgICAgc29jMTVfcGNpZV9nZW4zX2VuYWJsZShhZGV2KTsNCiAgICAgICAgIC8q
IGVuYWJsZSBhc3BtICovDQogICAgICAgICBzb2MxNV9wcm9ncmFtX2FzcG0oYWRldik7DQogICAg
ICAgICAvKiBzZXR1cCBuYmlvIHJlZ2lzdGVycyAqLw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2My
MS5jDQppbmRleCAyMWUyNzE4NzdjNGMuLmU1NmYyYmM3MzkzMCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzIxLmMNCkBAIC0zNzAsMjEgKzM3MCw2IEBAIHN0YXRpYyBpbnQgc29jMjFfc2V0
X3ZjZV9jbG9ja3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiBldmNsaywgdTMyIGVj
Y2xrDQogICAgICAgICByZXR1cm4gMDsNCiB9DQoNCi1zdGF0aWMgdm9pZCBzb2MyMV9wY2llX2dl
bjNfZW5hYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KLXsNCi0gICAgICAgaWYgKHBj
aV9pc19yb290X2J1cyhhZGV2LT5wZGV2LT5idXMpKQ0KLSAgICAgICAgICAgICAgIHJldHVybjsN
Ci0NCi0gICAgICAgaWYgKGFtZGdwdV9wY2llX2dlbjIgPT0gMCkNCi0gICAgICAgICAgICAgICBy
ZXR1cm47DQotDQotICAgICAgIGlmICghKGFkZXYtPnBtLnBjaWVfZ2VuX21hc2sgJiAoQ0FJTF9Q
Q0lFX0xJTktfU1BFRURfU1VQUE9SVF9HRU4yIHwNCi0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBDQUlMX1BDSUVfTElOS19TUEVFRF9TVVBQT1JUX0dFTjMpKSkNCi0gICAg
ICAgICAgICAgICByZXR1cm47DQotDQotICAgICAgIC8qIHRvZG8gKi8NCi19DQotDQogc3RhdGlj
IHZvaWQgc29jMjFfcHJvZ3JhbV9hc3BtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIHsN
CiAgICAgICAgIGlmICghYW1kZ3B1X2RldmljZV9zaG91bGRfdXNlX2FzcG0oYWRldikpDQpAQCAt
NzE0LDggKzY5OSw2IEBAIHN0YXRpYyBpbnQgc29jMjFfY29tbW9uX2h3X2luaXQodm9pZCAqaGFu
ZGxlKQ0KIHsNCiAgICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBh
bWRncHVfZGV2aWNlICopaGFuZGxlOw0KDQotICAgICAgIC8qIGVuYWJsZSBwY2llIGdlbjIvMyBs
aW5rICovDQotICAgICAgIHNvYzIxX3BjaWVfZ2VuM19lbmFibGUoYWRldik7DQogICAgICAgICAv
KiBlbmFibGUgYXNwbSAqLw0KICAgICAgICAgc29jMjFfcHJvZ3JhbV9hc3BtKGFkZXYpOw0KICAg
ICAgICAgLyogc2V0dXAgbmJpbyByZWdpc3RlcnMgKi8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92aS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYw0K
aW5kZXggMTJlZjc4MmViNDc4Li4yNTEyYjcwZWE5OTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92aS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
aS5jDQpAQCAtMTEwNSwyNCArMTEwNSw2IEBAIHN0YXRpYyBpbnQgdmlfc2V0X3ZjZV9jbG9ja3Mo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiBldmNsaywgdTMyIGVjY2xrKQ0KICAgICAg
ICAgcmV0dXJuIDA7DQogfQ0KDQotc3RhdGljIHZvaWQgdmlfcGNpZV9nZW4zX2VuYWJsZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCi17DQotICAgICAgIGlmIChwY2lfaXNfcm9vdF9idXMo
YWRldi0+cGRldi0+YnVzKSkNCi0gICAgICAgICAgICAgICByZXR1cm47DQotDQotICAgICAgIGlm
IChhbWRncHVfcGNpZV9nZW4yID09IDApDQotICAgICAgICAgICAgICAgcmV0dXJuOw0KLQ0KLSAg
ICAgICBpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKQ0KLSAgICAgICAgICAgICAgIHJldHVy
bjsNCi0NCi0gICAgICAgaWYgKCEoYWRldi0+cG0ucGNpZV9nZW5fbWFzayAmIChDQUlMX1BDSUVf
TElOS19TUEVFRF9TVVBQT1JUX0dFTjIgfA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIENBSUxfUENJRV9MSU5LX1NQRUVEX1NVUFBPUlRfR0VOMykpKQ0KLSAgICAgICAg
ICAgICAgIHJldHVybjsNCi0NCi0gICAgICAgLyogdG9kbyAqLw0KLX0NCi0NCiBzdGF0aWMgdm9p
ZCB2aV9lbmFibGVfYXNwbShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiB7DQogICAgICAg
ICB1MzIgZGF0YSwgb3JpZzsNCkBAIC0xNzQzLDggKzE3MjUsNiBAQCBzdGF0aWMgaW50IHZpX2Nv
bW1vbl9od19pbml0KHZvaWQgKmhhbmRsZSkNCg0KICAgICAgICAgLyogbW92ZSB0aGUgZ29sZGVu
IHJlZ3MgcGVyIElQIGJsb2NrICovDQogICAgICAgICB2aV9pbml0X2dvbGRlbl9yZWdpc3RlcnMo
YWRldik7DQotICAgICAgIC8qIGVuYWJsZSBwY2llIGdlbjIvMyBsaW5rICovDQotICAgICAgIHZp
X3BjaWVfZ2VuM19lbmFibGUoYWRldik7DQogICAgICAgICAvKiBlbmFibGUgYXNwbSAqLw0KICAg
ICAgICAgdmlfcHJvZ3JhbV9hc3BtKGFkZXYpOw0KICAgICAgICAgLyogZW5hYmxlIHRoZSBkb29y
YmVsbCBhcGVydHVyZSAqLw0KLS0NCjIuMTcuMQ0KDQoNCg==

--_000_DM4PR12MB518194987252D36A9D7B2C9DEFB69DM4PR12MB5181namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"auto">This patch is Reviewed-by: Likun Gao &lt;Likun.Gao@amd.co=
m&gt;.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards,</div>
<div dir=3D"auto">Likun</div>
<div><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<br>
</div>
<div id=3D"mail-editor-reference-message-container" dir=3D"auto"><br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;"><strong>=B7=A2=BC=FE=
=C8=CB:</strong> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; =B4=
=FA=B1=ED Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<strong>=B7=A2=CB=CD=CA=B1=BC=E4:</strong> 2023=C4=EA3=D4=C26=C8=D5=D0=C7=
=C6=DA=D2=BB =CF=C2=CE=E77:38<br>
<strong>=CA=D5=BC=FE=C8=CB:</strong> amd-gfx@lists.freedesktop.org &lt;amd-=
gfx@lists.freedesktop.org&gt;; Gao, Likun &lt;Likun.Gao@amd.com&gt;<br>
<strong>=B3=AD=CB=CD:</strong> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;=
<br>
<strong>=D6=F7=CC=E2:</strong> [PATCH] drm/amdgpu: Retire pcie_gen3_enable =
function<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Not needed since from vi. drop the function so<br>
we don't duplicate code when introduce new asics.<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp; | 17 --------------=
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c | 20 --------------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c | 17 -----------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp; | 20 --------------=
------<br>
&nbsp;4 files changed, 74 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 492a8b148227..d56cba10cd5a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -519,21 +519,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *ade=
v, u32 evclk, u32 ecclk)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static void nv_pcie_gen3_enable(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_is_root_bus(adev-&gt;pdev-&gt=
;bus))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_pcie_gen2 =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pcie_gen_mask &amp;=
 (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
-}<br>
-<br>
&nbsp;static void nv_program_aspm(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_should_=
use_aspm(adev))<br>
@@ -1041,8 +1026,6 @@ static int nv_common_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs-&g=
t;apply_l1_link_width_reconfig_wa)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;apply_l1_link_width_reconfig_=
wa(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable pcie gen2/3 link */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nv_pcie_gen3_enable(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable aspm */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nv_program_aspm(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* setup nbio registers */=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 2c37b49f5c00..1064972dc558 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -609,24 +609,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device *=
adev, u32 evclk, u32 ecclk<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_is_root_bus(adev-&gt;pdev-&gt=
;bus))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_pcie_gen2 =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pcie_gen_mask &amp;=
 (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
-}<br>
-<br>
&nbsp;static void soc15_program_aspm(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_should_=
use_aspm(adev))<br>
@@ -1183,8 +1165,6 @@ static int soc15_common_hw_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable pcie gen2/3 link */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_pcie_gen3_enable(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable aspm */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_program_aspm(adev);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* setup nbio registers */=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index 21e271877c4c..e56f2bc73930 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -370,21 +370,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device *=
adev, u32 evclk, u32 ecclk<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static void soc21_pcie_gen3_enable(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_is_root_bus(adev-&gt;pdev-&gt=
;bus))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_pcie_gen2 =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pcie_gen_mask &amp;=
 (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
-}<br>
-<br>
&nbsp;static void soc21_program_aspm(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_should_=
use_aspm(adev))<br>
@@ -714,8 +699,6 @@ static int soc21_common_hw_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable pcie gen2/3 link */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_pcie_gen3_enable(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable aspm */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_program_aspm(adev);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* setup nbio registers */=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c<br>
index 12ef782eb478..2512b70ea992 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
@@ -1105,24 +1105,6 @@ static int vi_set_vce_clocks(struct amdgpu_device *a=
dev, u32 evclk, u32 ecclk)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static void vi_pcie_gen3_enable(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_is_root_bus(adev-&gt;pdev-&gt=
;bus))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_pcie_gen2 =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pcie_gen_mask &amp;=
 (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
-}<br>
-<br>
&nbsp;static void vi_enable_aspm(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data, orig;<br>
@@ -1743,8 +1725,6 @@ static int vi_common_hw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* move the golden regs pe=
r IP block */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi_init_golden_registers(a=
dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable pcie gen2/3 link */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi_pcie_gen3_enable(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable aspm */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi_program_aspm(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the doorbell ape=
rture */<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font><br>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB518194987252D36A9D7B2C9DEFB69DM4PR12MB5181namp_--
