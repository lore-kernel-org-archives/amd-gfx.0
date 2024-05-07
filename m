Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65885C10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 06:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FE911243E;
	Tue,  7 May 2024 06:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GfDjoWst";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27AE111243B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 06:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFkgOUx9jVGoByqaEvEaAxqqFz68d18t4HprAvamUTn95dx91+ScKVcir9MkDFlnEYNkURjhRaeaw6vLpCJOmay7yM5RGKW4HCCn0q0mjzjqOV4EGSWbZ7PEk5mH44yyVSbn2FwBnLjTbpsWMy91AFRCc0awE+zbAomBLJvJadG7SSzO0HTJXpOM3ErZz79ibzmXU9HPgvFGZnrzaRusN/Pd3Zupa6VEEf8U6vObpe+KBNr8kFZtgd0wikqfZmGRoEI4EgPTlr6LscxTK9QUk4uhb8ieFw+4qwzo71twlZZbkwWK1/2i+xubbOYH/DaN/sED/KoY0a/jMwsR9FsJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDj/LwrW0jWb23XRN7i0qWkGlfVyOs8p7zWnMjccKAE=;
 b=E38CdJvnMCa8kQTm93tjXXI9cbgcQJm1IxBuTutGzWtWZRUKuEdh6mIwuyuOygOAV0baDVBpmggeyYnDEWt+HQwmiAXWxzcIh1dovvzUg+1lY39a3WZL0SCK0HfSDqf1FOdlKdp9vhzBcAwmdwsxti/XOi8gwRi7sE7kljhdmWialc3knPpOUEo7QMJJjU3+R+x08nTS2cxjz7KQNIms10OKtjtLn0QqUuSXTiqdZnzJ7ofTh2+RT8/Jvd3mb4YaOuqigxukHsP3QaFi56xwyUK8wG4YcLFtv3HSGoSrKJSEJ41kha2MTa6NGQpps+Il/bU0YGn8NAw3/F6Rc1n1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDj/LwrW0jWb23XRN7i0qWkGlfVyOs8p7zWnMjccKAE=;
 b=GfDjoWstD6GcggvaK099NRPHo0ASv+IIRTkZDvleASM1503OTgkbZq0we/B6DUc0KaZERDc9Ad92jHHg2EX7qcIfAuhRmDi6iXF0Z7J5F3kSKKRpQ4DYiwuoBvhvv7TazetB+wE/s+U9bKQ2TlxIdQqWxValZUqHikLnIq7mc3Y=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 06:38:29 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 06:38:29 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: change log level
Thread-Topic: [PATCH] drm/amdgpu: change log level
Thread-Index: AQHaoEeZFohmXmHslUGLW7CqbmdnmbGLUa5Q
Date: Tue, 7 May 2024 06:38:28 +0000
Message-ID: <PH7PR12MB59977072BA5A25EF4279A67782E42@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240507062648.790125-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240507062648.790125-1-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB5710:EE_
x-ms-office365-filtering-correlation-id: 88a9f4de-5e66-414d-5986-08dc6e604e4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?gb2312?B?dmxPM0ZoMVNoR2wzNTY4YXVQTGxIdGl4dE9FZzUwb1h0RHdHeU9KUlE4azJC?=
 =?gb2312?B?bjB5b090cjBpVk9aTXB4Z2xSRGU3NzlSaFk2eEN0M3dFOGhiV0lZSXBSa1U1?=
 =?gb2312?B?QVZpa3k2ME5qbThMZjEyN2w4bFlSc2RuUmI3TWNiM0V0YmhFVDRPVFpRMjBH?=
 =?gb2312?B?eHg1b2RWemZRa1BXSDRNWFgxNmVaOEI3LzYxSzRWdmlGbjdPOENRbDN1VE1N?=
 =?gb2312?B?M3g1VVlvZm9WZ3dyd1RjTmN4Mnl1dEJRWlVVeGFpbW9oMkFwMnRhY1poRzBl?=
 =?gb2312?B?SU13Y1IzZUw5TEtJRkpiNkNQOVRaWisxSWhUZExKb3JrMkJzdnppaWcxQndu?=
 =?gb2312?B?Wld2dmg5SFpXTVkwanQzUkhBL0pPR2pici8wN0VTSHZXcmFxU1Z6bW5jM1BW?=
 =?gb2312?B?OUVKVVhiRWl0SnRLZVpaQ2FEUStLMEFQZ2ZRRklSZmxpTlFtR2ZHUnY4Y0Vi?=
 =?gb2312?B?YWhwRkhWNk9qeEg1em1Fck9HMjRqTUVkZUFNZmlrN2l4NVlwMlhkdk9hSzF0?=
 =?gb2312?B?UnZ3YnNpb1BzbjNxaUhQc1BqYm5TT3RQWkJMMGtvdnJrMUJjODEvVVZSZXE1?=
 =?gb2312?B?YXIyR2F6SU9GajAvWGRrZnVuOE5VUDZxWDVBUDN6Z0Q2MEZZVXNJaHQ3elIy?=
 =?gb2312?B?QVE5ZVNoQnBEL2htK0JQOTJoMFgvdEhOTGRYUWlXZlNPVXJncEFLUDF2KzdS?=
 =?gb2312?B?ZEtld2lxUGVWWFkvZTBMQnQxK0xyS2M4MjZHNGlMSXoxdmV2bDkyUG9SZ2cw?=
 =?gb2312?B?RzRsYVlmZWFKQ0gxamdwRHlPMFN4WmREMkJseXJGZlQvNDJ3TVRBNnRlSVo5?=
 =?gb2312?B?YjRJWE1mK1NwNElPUFlCUHBCOGNEZU5OVzFMc2lUN0l1SVJXMS9qOVRzVjF3?=
 =?gb2312?B?TG1JSldqNm45VHh6UzQ3SHN1ZGJiam56WWNTLzdwK2grV01XdHV4UGFlb1lW?=
 =?gb2312?B?SnNFdGZPVk9kVWt1TTRjKzFONHlkUUdlUDBkS1lWY0RoSlV1Q3NCdzBpNENP?=
 =?gb2312?B?QXlNT0FPWTZTVUZ6S3dFZWRHVFcwWU1SK2ZKVytBQTFFNW5ZZEhlMitGS21Q?=
 =?gb2312?B?dXFIWjNKQ1ZwTVVTYVJabDhsSHRTVU9jTTl0RCt0Mk9wSVFnejlqVU4zWWR6?=
 =?gb2312?B?OXo5WGE2ZUcrTnE1c1ZNTEUxSVh1dGJUUFpGWWpwK2lRZnpGMFRNNU1BMVV4?=
 =?gb2312?B?YlBlc2RjbWpHQnkrejk4bDR5eDlDaVZvWnc5eU1MdjJDU0thMGlmTXB1Vkw3?=
 =?gb2312?B?dHRDZWhNSXMwU0Z6R3lZUTZPMVRFS3dOcHpZaGpRM2E1ZFBqdlp3bG9EU0VZ?=
 =?gb2312?B?YVlMWDg1UmxNMWNrL3FPOFkvY0FjWTBvdklEdkRoV2VhNDM1SDVvWTVqSmsw?=
 =?gb2312?B?cDdGY3paTExnUk5Rem5KQVpBeE1pRnA1NFZveGV6YkFPNnl5UWJTWWVFblRF?=
 =?gb2312?B?T0ZneXhVaWdIVncxLzFnSSsxamc2cEIxaE9mcDR4ak9yeXA2QkxlZnR1SFc3?=
 =?gb2312?B?R1Budm9oWVUwMlluWVRMdndKdURYRHBYbVEzaHJya1J4MlB0VW5DcW9VZXFs?=
 =?gb2312?B?RVNKYTZ0TzdrOVZjaENTWFNpcjNKSFBDVFpsRkFxU01EMmJTV0pxUkZrRHBq?=
 =?gb2312?B?aklTakVlUTNmVDNkWDBjbEpYOTA5YTh5RTB2VnBSbmNUYzlPWlVVVlN2MGN1?=
 =?gb2312?B?TldvT2d1ZTk4WW5ibUJOa3ZqRmdwUGUvcGhpdWlteUJhWlhtcThvNmpwbXB5?=
 =?gb2312?B?SnJqL2lhSFlOYXpBQzl2VWlLL281aUVjQU1PTkNlcGxlVXRjN0JJYks1SmM0?=
 =?gb2312?B?dm5HUWlTRzVpa292T2h0dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZVlmZWRTZjl0T3VPZFBWVzBsMTY3THpqM1o1UEdPR0JpZFh3bXRMRWRGcmla?=
 =?gb2312?B?eXY2OU1PVzBnMWp3Q0xPeTI3QkZiSUh1ZWxid0pCZmxwWm9aTjJreDh4Ky9D?=
 =?gb2312?B?SFFLK0psekxJbWdINktyOElDdjg0blNpNjFSaFhEcEowNCtPTHdyVWwvTWxC?=
 =?gb2312?B?RzJJSG1DU3RGR0tORCttR0k1dStNR29LRVpNU0pzMW1ZK0dDRUxlT2htb2hy?=
 =?gb2312?B?NDlwWDFVYjhhWWljdVh6SnZkeWFHa3ZNVHAydkV5R25TZXJLOXZlL2FwWi9J?=
 =?gb2312?B?REMrRFBrTTMrTzFzMThmdStneVFiMng3SGEzYU5LYStOcmNFRG10VFNvbllj?=
 =?gb2312?B?MGtWKzRvMmtUamoxUDZiRzJic0VBZnZZQjRTR0VKKzdzazNVNHNkNlZzaXRK?=
 =?gb2312?B?QWNWMlBsNEZlSGR3UGQ4VnFVR2NtR2QvT0IxVGRtOE1XL0FMVzJsTGhPbjBm?=
 =?gb2312?B?SU5KM1QyZDhFSDhDUGVhUzdDMHMzQmRySHVWVG53eUZCdm1XV2Z2Um5QK080?=
 =?gb2312?B?MEJnTG9LSkE4aXQxaGZyS3FnSXpKcjl1eVk2em5kVE5ZejFDNWQvY2hFNzVW?=
 =?gb2312?B?RldvSURGYVRaOHZOR1NUMUxFaWRheWF2TEw4ZzE3T09RSk1yQlFaYnBUOFJz?=
 =?gb2312?B?aElrT2dCK2gwYlFvc1V1THdJYTY2SmdRZG9mVkpDSzhwNW5FZWFGSTRQYnFY?=
 =?gb2312?B?bjF6aFA4NDQ0QzFZQmdYdUk2REdvZXNJdEtZQjVweSs2bC9wT3JTdk5jQzNi?=
 =?gb2312?B?endOdy85VHhKeW5yby9qMzVUem1yN0xabzFVeXBUcEdVWGFZR29sWll2WU5u?=
 =?gb2312?B?a1B3YkFIN0pHaXdFMkp1VEV3K3cwbEN3S3M3eE9yQk92ejZ0RG1NcFFWcVE0?=
 =?gb2312?B?eEY0cVdVREtzOG1iTkI1THlINFVpS3pvcWJ2d3dFZnUrazdFUndUYnFiMDNR?=
 =?gb2312?B?MmFpbmVId1BEdTllK2RDTHpFSEd1aG9PVFQrWVdmYzVscEoySkRBV1VMbGE3?=
 =?gb2312?B?U1lIeUpsSlBQc21ZTlQ0bmxUWXNtci9pbW5EZG5YT3cvdHgrOFRQc0NQZ2sy?=
 =?gb2312?B?RTdZcTM2VDlSdmYrb3dLaDR4NjV5aFVHT3BJRTNuZy9Yc2doR1JMVll1a09t?=
 =?gb2312?B?Z1ErYWNPdFRLa0VyT0J3dDBGNFM4RjgwaXJBaVk1Y2dvbS9UZTkvcm95cnFa?=
 =?gb2312?B?WCs5a1RMUlAvbW5iR1JrNitPVjNVNFlTejZPY3RON295TGtIOFRBZlZYdEpw?=
 =?gb2312?B?ZXR3VXVFeTVSSGZRUkZ2WkdZT1hkZ3FrNklQZEdXNUN6UFJyMUNUeEI4dUxk?=
 =?gb2312?B?MUIyQ0ZSUFUzejA5TXdZTHUrQms4bkg0WmhzQW1ISUt1bTN5Y3I2UzNPSXlJ?=
 =?gb2312?B?c3F5QU84SzZ3SCtLMlN3MHR4YTRYc2t3cmFFeUtaemN5N09UTlN4dGFIUXBQ?=
 =?gb2312?B?RzJQUDBEbU5hd1FnSmhGbVVMVU0vbVpEdnV5QmJXVjNRNkRrU2tBaGM5MTJC?=
 =?gb2312?B?eGpPTmczWnpTWEQ0YlpBNEFCNWMwV29TcTU2U2Vac09Kc2xqRUhPVHYvUkd5?=
 =?gb2312?B?Z1VUOEEwQWd5Z0VZNmJlck55VGM1eVVIa2lJQlROaWJMTGFJOE54N2ZpNVh0?=
 =?gb2312?B?YXRkMkUrOUN6eHNRRVhmSVUrRVVRaGlJclpvMEduRUhFVndaMERlMkJkbUI2?=
 =?gb2312?B?djZhOVBWSlZCMFBEcGt5b1NFWEpvK2M5a1U4bHdWN0dZLytYTkxORkpid0Zn?=
 =?gb2312?B?Mkt2Z2lxS2k3S296bW5XTEFMdURaS0FpOU1IUUVqMUhLSTVldk5xT0JveEVm?=
 =?gb2312?B?bmlhVDNvZm5hdnMvWDJYOGszTGNkRFZOdkc4RVY5c3F3RXhlRUNyazdoYnJU?=
 =?gb2312?B?RkxaZ1phVjh5d3ZQV0dxSFNncE4wcmgxWWQxQzlEcDZISUVrT01oWERsQWRp?=
 =?gb2312?B?VlNPYTF6YmNDeE5mYmRYaTQyV2VNbEhodUJXNjhoQXZDa3JCaDREM1F0ZnRV?=
 =?gb2312?B?ZFF4TGJXMDBzUFlNV2ZQT0NqTS81aE44YXJCNXZHU28wazhwNDEveUc1dW92?=
 =?gb2312?B?MGg0Z0dTalRleDgxZnNGOEVqT1c2cUlRWTRGM2tobVQzWllxeEtMLzVubXQ4?=
 =?gb2312?Q?Ait4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a9f4de-5e66-414d-5986-08dc6e604e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 06:38:28.8897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dd0MEeQt1CSsPvHG2DM3wtbom6mr9pWdUJMlSDD6ew4CCU8I6tQhRbdtpZwZ59YI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVzdCBS
ZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENoYWks
IFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT4gDQpTZW50OiAyMDI0xOo11MI3yNUgMTQ6MjcN
ClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IExp
LCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5Z
YW5nLldhbmdAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPjsg
Q2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0v
YW1kZ3B1OiBjaGFuZ2UgbG9nIGxldmVsDQoNCkNoYW5nZSBsb2cgbGV2ZWwuDQoNClNpZ25lZC1v
ZmYtYnk6IFlpUGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNCArKy0tICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS91bWNfdjEyXzAuYyAgfCA0ICsrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYw0KaW5kZXggZmJjMGQ5ODU0ODczLi43YWNmNDM1ODJjYTcgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KQEAgLTI5MDcsNyArMjkwNyw3IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X3Jhc19wYWdlX3JldGlyZW1lbnRfdGhyZWFkKHZvaWQgKnBhcmFtKQ0K
IA0KIAkJcmFzX2Jsb2NrID0gcG9pc29uX21zZy5ibG9jazsNCiANCi0JCWRldl9pbmZvKGFkZXYt
PmRldiwgIlN0YXJ0IHByb2Nlc3NpbmcgcmFzIGJsb2NrICVzKCVkKVxuIiwNCisJCWRldl9kYmco
YWRldi0+ZGV2LCAiU3RhcnQgcHJvY2Vzc2luZyByYXMgYmxvY2sgJXMoJWQpXG4iLA0KIAkJCQly
YXNfYmxvY2tfc3RyKHJhc19ibG9jayksIHJhc19ibG9jayk7DQogDQogCQlpZiAocmFzX2Jsb2Nr
ID09IEFNREdQVV9SQVNfQkxPQ0tfX1VNQykgeyBAQCAtMjkyOSw3ICsyOTI5LDcgQEAgc3RhdGlj
IGludCBhbWRncHVfcmFzX3BhZ2VfcmV0aXJlbWVudF90aHJlYWQodm9pZCAqcGFyYW0pDQogCQkJ
cG9pc29uX2NyZWF0aW9uX2lzX2hhbmRsZWQgPSBmYWxzZTsNCiAJCX0NCiAjZWxzZQ0KLSAgICAg
ICAgZGV2X2luZm8oYWRldi0+ZGV2LCAiU3RhcnQgcHJvY2Vzc2luZyBwYWdlIHJldGlyZW1lbnQu
IHJlcXVlc3Q6JWRcbiIsDQorCQlkZXZfZGJnKGFkZXYtPmRldiwgIlN0YXJ0IHByb2Nlc3Npbmcg
cGFnZSByZXRpcmVtZW50LiByZXF1ZXN0OiVkXG4iLA0KICAgICAgICAgICAgICAgICAgICAgYXRv
bWljX3JlYWQoJmNvbi0+cGFnZV9yZXRpcmVtZW50X3JlcV9jbnQpKTsNCiANCiAgICAgICAgIGFt
ZGdwdV91bWNfYmFkX3BhZ2VfcG9sbGluZ190aW1lb3V0KGFkZXYsDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3YxMl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS91bWNfdjEyXzAuYw0KaW5kZXggYmZlNjFkODZlZTZjLi45NGZhNmMzN2I3ZWIgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjEyXzAuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3YxMl8wLmMNCkBAIC03MSw3ICs3MSw3IEBA
IHN0YXRpYyB2b2lkIHVtY192MTJfMF9yZXNldF9lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikNCiANCiBib29sIHVtY192MTJfMF9pc19kZWZlcnJlZF9lcnJvcihzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0X3QgbWNfdW1jX3N0YXR1cykgIHsNCi0JZGV2X2lu
Zm8oYWRldi0+ZGV2LA0KKwlkZXZfZGJnKGFkZXYtPmRldiwNCiAJCSJNQ0FfVU1DX1NUQVRVUygw
eCVsbHgpOiBWYWw6JWxsdSwgUG9pc29uOiVsbHUsIERlZmVycmVkOiVsbHUsIFBDQzolbGx1LCBV
QzolbGx1LCBUQ0M6JWxsdVxuIiwNCiAJCW1jX3VtY19zdGF0dXMsDQogCQlSRUdfR0VUX0ZJRUxE
KG1jX3VtY19zdGF0dXMsIE1DQV9VTUNfVU1DMF9NQ1VNQ19TVEFUVVNUMCwgVmFsKSwgQEAgLTU3
NSw3ICs1NzUsNyBAQCBzdGF0aWMgaW50IHVtY192MTJfMF91cGRhdGVfZWNjX3N0YXR1cyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAJZXJyX2FkZHIgPSBSRUdfR0VUX0ZJRUxEKGFkZHIs
DQogCQkJCU1DQV9VTUNfVU1DMF9NQ1VNQ19BRERSVDAsIEVycm9yQWRkcik7DQogDQotCWRldl9p
bmZvKGFkZXYtPmRldiwNCisJZGV2X2RiZyhhZGV2LT5kZXYsDQogCQkiVU1DOklQSUQ6MHglbGx4
LCBzb2NrZXQ6JWxsdSwgYWlkOiVsbHUsIGluc3Q6JWxsdSwgY2g6JWxsdSwgZXJyX2FkZHI6MHgl
bGx4XG4iLA0KIAkJaXBpZCwNCiAJCU1DQV9JUElEXzJfU09DS0VUX0lEKGlwaWQpLA0KLS0NCjIu
MzQuMQ0KDQo=
