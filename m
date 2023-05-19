Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF41C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 18:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A477010E5DF;
	Fri, 19 May 2023 18:08:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEDF10E5DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 18:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+fYeKDIm5hBJ6XtTAsHAkylWaUw0vEqfwu0AVfAUG3LCvwb1uAxIl0P1jWBn2uzDadpi8Kzn4qc7pUN1ShBYmags9ZA0W2UW5nFKJ2q71aWtj1x1T7ghERBtAOvv9WS4anvMk8y5CH8HWb9P8V1iKtZkPdRt3VK0PU0UwOsWKZb3D53mDx1K39EyoyfN6reXMCEhYA4Gql8HWSXoROCofO0be7S0EQ/4c/n8+wh075jFeJLAoxIHWjyACfxOI99DPPESnx56DOSYZlSKnO/LXchsF0yd0EdQCqxyD9WCLqxjagNQ6Qo4kXzpL9hNFApPb2BQT8Ls7ST3vyNs1gSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMGXINmfxKuKYh7Sm4hJ/f5f51Mp1g/YsW+XV1mZnS0=;
 b=RhbUUMw1sKz7kIGGLOdJlOYzHBgWdp3yjE0+8kU0p7NBXEmC5JdMXKomaacJdT1u8UwjWdipp3neS1nubSM0H5gRNlHGFTWlxWxkgWYrPZhPK9mZwLHWdZkbeXowXG2Modo4mj7mmGudYtX/2IpZ6PcLmoPgcjKHKO9+etVh1oyr2ZKKUuaHfRUexYMmqQI6/BmdQLGQwPcn5R9OVDAd6D1yKwR+8/7JRrDCdIv+Q0bnrFACg74zfvz9SfqqYjWMhwyEu8UDsSXtlxk+7ArEGcJ4rC1uwT4zIUTEVzn5FimNOUiSFaasnRkdBaE0I9huXwCe3vIOYO0ewNy+ILwmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMGXINmfxKuKYh7Sm4hJ/f5f51Mp1g/YsW+XV1mZnS0=;
 b=gsmeTJ5wHKwf2zKh+VseoOySXQDBiTxEevuavSsnwVX7SOlkBSrafMcLM0x0ixLwhIpvRaGmYYKFjg4NmxGviHVE9xBnJl38whoR83LPz7Abb7WZKhebKd2BLnnH9yhGDQjIbyoSo85Zb188z7MEQeau9t0NSuo+ZSpUVWjYkKY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Fri, 19 May 2023 18:08:21 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:08:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry
Thread-Topic: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry
Thread-Index: AQHZialCE6RDshiN1UydDmhVHCg9ja9g8gkAgAAOLwCAAOVwGw==
Date: Fri, 19 May 2023 18:08:20 +0000
Message-ID: <BL1PR12MB5144E8E50EBC7B9C079ABDD9F77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230518165251.93229-1-mario.limonciello@amd.com>
 <BYAPR12MB26154082582165C41391BF9AE47C9@BYAPR12MB2615.namprd12.prod.outlook.com>
 <4c10cb13-de77-50c0-83c1-b31f6bb333be@amd.com>
In-Reply-To: <4c10cb13-de77-50c0-83c1-b31f6bb333be@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T18:08:20.082Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6022:EE_
x-ms-office365-filtering-correlation-id: 4e62d142-1eeb-4da3-06e2-08db58940775
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MaPl2lVuveu1bpqXf1nLOzcBfJpYY+MlEpwol0oMzPakgBi5arelwqQhDWlCP0V9EsuqacaAUTREh38/b24LrpjIHeS22GaadEOaTtdjZGieZdkDBI9uXm0N/yeWxauvekt7D7NGrqAmzIRa1i2c3d90w3EnkW8y4cgFsTMJAPit1zyzPsu3UaXtZHsICCZYcJ5C/ZOUZGHH0S1R0mbNJ/MXujcfkpQU9+4qvG65HrO1Owbz6Wg1Z5gOif5XT29qUw4E3yKe27wCdzRnuA22tiJQJeY5oyMJjdVZSi12q8EpGD4qcHCcSgj7CP0lKotSnXQFDsVLy3DwD9cKGup8MKXDRa3yLmIqGfJ5LZDSOVKcwY52XSONeGSbrv5ulfTTxZI143CD9KPkzSasSUM07oGURQdqL3n7znxyLfp8u89v/1COTcp9qWyeAqOhTZGYRt1X0QKYVOspNjxo5oh2zPiFHTghqRndRX48QfxOZU0oTlK+gzpyO2OLmo198Q7s6FAHGfKAyseIOWJpc8398OE8/N1eZBPpAfYP81VGb4jVEr1zECRHwCJ8yULnfSqL5GgcYjaMdlw6p0REBaEYfjIZcxVkc1y8ew80WtVuMAcqqmXQCtJNmSfUX5V42yuF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(5660300002)(83380400001)(71200400001)(41300700001)(2906002)(38070700005)(86362001)(122000001)(15650500001)(38100700002)(8676002)(186003)(26005)(52536014)(55016003)(33656002)(6506007)(8936002)(9686003)(53546011)(66946007)(66556008)(66446008)(66476007)(64756008)(478600001)(19627405001)(7696005)(54906003)(316002)(4326008)(76116006)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cRTk5m885Y514mYxhknsrsDI0ugzdYCOlvRfHSry69rnZrHfOaqrH16VAFtv?=
 =?us-ascii?Q?TAkuwHYR5R45Mne9xojING98gWRXFgwklqVmzGi30Xs5Sip8miRXUD5KCPyb?=
 =?us-ascii?Q?mH1ndo9HQNih/zVh+uI/L39hiB4uu3Cl2qVeRtwSMw6PBCbQW9Zugt33wVlH?=
 =?us-ascii?Q?SSCEFHWoWoF21JyZb7j7uFzJUS9f3EXkZa9FHGnrgZJCx3x/u9Lsbqk6eqJ2?=
 =?us-ascii?Q?Fl8NrvY/jAyK1UtOkv3/7oHvsLqhuSvbHqtg8Cir5MkOS6e8XVISWmt+7i0G?=
 =?us-ascii?Q?3CkAFzDbSCzlx2oM+kwYxSl7Mk7ky9it+r3epCzny4CfADGFf/nYy+Lho4eP?=
 =?us-ascii?Q?C5NXy7D6Af+4Yuh29jcncq7Y3aDh2uulgqqpzoIic4wOq0dK4mujlNTBydHC?=
 =?us-ascii?Q?2JpeLkqtgxznEbkT5R4AinhluVdBgXYvG6MdI4QGtEBZD+lo1eq65Cx4UYDq?=
 =?us-ascii?Q?omCjG2DCjuRfUorGM0G2P2rikq61Crehm2K0HoIWMuyd7mqMe5uDI12gLpV8?=
 =?us-ascii?Q?Bn0yfpQUKqvFv0qYY9jjlX+fL/7RW4TSJgaRH1K/MBEHRgls8J9rxRRF2F8L?=
 =?us-ascii?Q?I6707ndOI6/luPpKCoOtaGkDtwIMmoVo1R9PWgnhHcIfSC+fnteMe26f9a35?=
 =?us-ascii?Q?XIspThA/ZXPgmzEWUPx0otPP7gR3LgGvMJrQSwO0lcIavbT1LYC9DqTu+F1A?=
 =?us-ascii?Q?fpg7eAw66apyCB5Yxb5BXpJfnjj2oVYRa+bSsIMLRAOsQ3jMBNvQW2EHsUXE?=
 =?us-ascii?Q?lcz6V2AoZxtCPOLnDkd2NfOX2gsqPpRwZQnPK4u6n89DiYlOKI+Yzxts7gGk?=
 =?us-ascii?Q?zwDfX9iebg8hhnPc75FIYmWTnoSUNxbVe94l/oAgWKlxqad9Iu/usg2CCG24?=
 =?us-ascii?Q?sbje8sTxHJsAgy8c/MFMrZLYjuCZ0yksTQYwC/V/JncdYCfhsFkC1FFUPDia?=
 =?us-ascii?Q?hj8a1MY7TVBL/QwEyy1CH6CzU3is09QqbrGeE4ykJVO6nOvBm9v4WLSkYOET?=
 =?us-ascii?Q?Hpv/tDcAfldIBtwQNOic/CJYaLGf/g0BiPWUoVmVEqGfvvw5CJeFRLzb6yRF?=
 =?us-ascii?Q?Zgnr8Z85VK3n3pHAvXgQ2IDGR71preQ6uq9LFj7uY4MDnqc1al8mjpUQvdvx?=
 =?us-ascii?Q?Fkom7KOUZSZd8nadxN/1rkg8Re+YymJ/eLW7qRhyrzdRiLA8tsyu+SbiWIh3?=
 =?us-ascii?Q?qU9ICZl4BUWDNCJLx7pblN9mbtytWgML871LrAZVM6ylP3QHmSoiTcswRTTR?=
 =?us-ascii?Q?/Na7P1Anvdjp+9s5/52ay8N077++2+DSeyfJSsc2I4S0kgQ9CCnXP434Gyye?=
 =?us-ascii?Q?CbT+F01Io0JsJa01ZBE5FsqQITka8+kjW8agbplGDxKYs9qt3SCnJ15LoE6M?=
 =?us-ascii?Q?teEEGxTRe3vgGtENE7+5puxOE6AO8iF27fKP0RtsVQE/qw10cYeN7863FBj1?=
 =?us-ascii?Q?rPPFy7K4DVhr2cr24URgE8i1wZ87sNgH4B9iyz+jJU1ima+8KkEHRwLPULy2?=
 =?us-ascii?Q?o8Z/v4WcmQzjfsa0eQQ+g3vbIjDoSQejLnm7iwR58N9nm7MExIlWFjeYQLLv?=
 =?us-ascii?Q?9c4q+e7sujZkOfjwIgI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E8E50EBC7B9C079ABDD9F77C9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e62d142-1eeb-4da3-06e2-08db58940775
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 18:08:20.5956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJC6uBXnJPyKKvlPxmxsn4aZO/DxU6ysKQK8v7ILC83i/hmDtyGGxpt1F5JgvI0nInB4eyCTI5M+641MEUBipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
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
Cc: "Tsao, Anson" <anson.tsao@amd.com>, "Martinez,
 Juan" <Juan.Martinez@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Gong,
 Richard" <Richard.Gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144E8E50EBC7B9C079ABDD9F77C9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

GFX PG is a pre-requisite for gfxoff IIRC.  We shouldn't disable it on s2id=
le I think.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Friday, May 19, 2023 12:24 AM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Tsao, Anson <anson.tsao@amd.com>; Martinez, Juan <Juan.Martinez@amd.com=
>; Gong, Richard <Richard.Gong@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: Re: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry

Yeah; that seems like a reasonable way to accomplish the same result.
I'll experiment with this.

On 5/18/23 22:33, Quan, Evan wrote:
> [AMD Official Use Only - General]
>
> If I understand correctly, similar job is already performed in "amdgpu_de=
vice_set_pg_state(adev, AMD_PG_STATE_UNGATE);"
> Maybe you just need to undo the "skip PG for GFX on S0ix"?
>
>                  /* skip PG for GFX, SDMA on S0ix */
>                  if (adev->in_s0ix &&
>                      (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOC=
K_TYPE_GFX ||
>                       adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOC=
K_TYPE_SDMA))
>                          continue;
>
> Evan
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
>> Limonciello
>> Sent: Friday, May 19, 2023 12:53 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Tsao, Anson <anson.tsao@amd.com>; Huang, Tim
>> <Tim.Huang@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>;
>> Limonciello, Mario <Mario.Limonciello@amd.com>; Gong, Richard
>> <Richard.Gong@amd.com>
>> Subject: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry
>>
>> DCN 3.1.4 is reported to hang on s2idle entry if graphics activity
>> is happening during entry.  This is because GFXOFF was scheduled as
>> delayed but RLC gets disabled in s2idle entry sequence which will
>> hang GFX IP if not already in GFXOFF.
>>
>> To help this problem, flush any delayed work for GFXOFF early in
>> s2idle entry sequence to ensure that it's off when RLC is changed.
>>
>> commit 3964b0c2e843 ("drm/amdgpu: complete gfxoff allow signal during
>> suspend without delay") modified power gating flow so that if called
>> in s0ix that it ensured that GFXOFF wasn't put in work queue but
>> instead processed immediately.
>>
>> This is dead code due to commit 5d70a549d00d ("drm/amdgpu: skip
>> CG/PG for gfx during S0ix") because GFXOFF will now not be explicitly
>> called as part of the suspend entry code.  Remove that dead code.
>>
>> Cc: stable@vger.kernel.org # 6.1+
>> Suggested-by: Tim Huang <tim.huang@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v3->v4:
>>   * Drop patches 2-4
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 9 +--------
>>   2 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a9d9bbe8586b..059139f1f973 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4316,6 +4316,7 @@ int amdgpu_device_suspend(struct drm_device
>> *dev, bool fbcon)
>>                drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-
>>> fb_helper, true);
>>
>>        cancel_delayed_work_sync(&adev->delayed_init_work);
>> +     flush_delayed_work(&adev->gfx.gfx_off_delay_work);
>>
>>        amdgpu_ras_suspend(adev);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index f2d0b1d55d77..b1190eb0e9c7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -692,15 +692,8 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device
>> *adev, bool enable)
>>
>>                if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
>>                    !adev->gfx.gfx_off_state) {
>> -                     /* If going to s2idle, no need to wait */
>> -                     if (adev->in_s0ix) {
>> -                             if
>> (!amdgpu_dpm_set_powergating_by_smu(adev,
>> -                                             AMD_IP_BLOCK_TYPE_GFX,
>> true))
>> -                                     adev->gfx.gfx_off_state =3D true;
>> -                     } else {
>> -                             schedule_delayed_work(&adev-
>>> gfx.gfx_off_delay_work,
>> +                     schedule_delayed_work(&adev-
>>> gfx.gfx_off_delay_work,
>>                                              delay);
>> -                     }
>>                }
>>        } else {
>>                if (adev->gfx.gfx_off_req_count =3D=3D 0) {
>> --
>> 2.34.1
>


--_000_BL1PR12MB5144E8E50EBC7B9C079ABDD9F77C9BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
GFX PG is a pre-requisite for gfxoff IIRC.&nbsp; We shouldn't disable it on=
 s2idle I think.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Friday, May 19, 2023 12:24 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tsao, Anson &lt;anson.tsao@amd.com&gt;; Martinez, Juan &lt;Juan.=
Martinez@amd.com&gt;; Gong, Richard &lt;Richard.Gong@amd.com&gt;; Huang, Ti=
m &lt;Tim.Huang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend=
 entry</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Yeah; that seems like a reasonable way to accompli=
sh the same result.<br>
I'll experiment with this.<br>
<br>
On 5/18/23 22:33, Quan, Evan wrote:<br>
&gt; [AMD Official Use Only - General]<br>
&gt; <br>
&gt; If I understand correctly, similar job is already performed in &quot;a=
mdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);&quot;<br>
&gt; Maybe you just need to undo the &quot;skip PG for GFX on S0ix&quot;?<b=
r>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* skip PG for GFX, SDMA on S0ix */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_s0ix &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_blocks=
[i].version-&gt;type =3D=3D AMD_IP_BLOCK_TYPE_GFX ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_b=
locks[i].version-&gt;type =3D=3D AMD_IP_BLOCK_TYPE_SDMA))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; continue;<br>
&gt; <br>
&gt; Evan<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Beh=
alf Of Mario<br>
&gt;&gt; Limonciello<br>
&gt;&gt; Sent: Friday, May 19, 2023 12:53 AM<br>
&gt;&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt;&gt; Cc: Tsao, Anson &lt;anson.tsao@amd.com&gt;; Huang, Tim<br>
&gt;&gt; &lt;Tim.Huang@amd.com&gt;; Martinez, Juan &lt;Juan.Martinez@amd.co=
m&gt;;<br>
&gt;&gt; Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Gong, Richar=
d<br>
&gt;&gt; &lt;Richard.Gong@amd.com&gt;<br>
&gt;&gt; Subject: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend e=
ntry<br>
&gt;&gt;<br>
&gt;&gt; DCN 3.1.4 is reported to hang on s2idle entry if graphics activity=
<br>
&gt;&gt; is happening during entry.&nbsp; This is because GFXOFF was schedu=
led as<br>
&gt;&gt; delayed but RLC gets disabled in s2idle entry sequence which will<=
br>
&gt;&gt; hang GFX IP if not already in GFXOFF.<br>
&gt;&gt;<br>
&gt;&gt; To help this problem, flush any delayed work for GFXOFF early in<b=
r>
&gt;&gt; s2idle entry sequence to ensure that it's off when RLC is changed.=
<br>
&gt;&gt;<br>
&gt;&gt; commit 3964b0c2e843 (&quot;drm/amdgpu: complete gfxoff allow signa=
l during<br>
&gt;&gt; suspend without delay&quot;) modified power gating flow so that if=
 called<br>
&gt;&gt; in s0ix that it ensured that GFXOFF wasn't put in work queue but<b=
r>
&gt;&gt; instead processed immediately.<br>
&gt;&gt;<br>
&gt;&gt; This is dead code due to commit 5d70a549d00d (&quot;drm/amdgpu: sk=
ip<br>
&gt;&gt; CG/PG for gfx during S0ix&quot;) because GFXOFF will now not be ex=
plicitly<br>
&gt;&gt; called as part of the suspend entry code.&nbsp; Remove that dead c=
ode.<br>
&gt;&gt;<br>
&gt;&gt; Cc: stable@vger.kernel.org # 6.1+<br>
&gt;&gt; Suggested-by: Tim Huang &lt;tim.huang@amd.com&gt;<br>
&gt;&gt; Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;=
<br>
&gt;&gt; ---<br>
&gt;&gt; v3-&gt;v4:<br>
&gt;&gt;&nbsp;&nbsp; * Drop patches 2-4<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp;&nb=
sp; | 9 +--------<br>
&gt;&gt;&nbsp;&nbsp; 2 files changed, 2 insertions(+), 8 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; index a9d9bbe8586b..059139f1f973 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; @@ -4316,6 +4316,7 @@ int amdgpu_device_suspend(struct drm_device<=
br>
&gt;&gt; *dev, bool fbcon)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev=
)-<br>
&gt;&gt;&gt; fb_helper, true);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync=
(&amp;adev-&gt;delayed_init_work);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; flush_delayed_work(&amp;adev-&gt;gfx.gfx=
_off_delay_work);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_suspend(adev)=
;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt;&gt; index f2d0b1d55d77..b1190eb0e9c7 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt;&gt; @@ -692,15 +692,8 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device=
<br>
&gt;&gt; *adev, bool enable)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.gfx_off_req_count =3D=3D 0 &amp;&a=
mp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gfx.gfx_off_state=
) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If going to s2id=
le, no need to wait */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_s0i=
x) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if<br>
&gt;&gt; (!amdgpu_dpm_set_powergating_by_smu(adev,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_GFX,<br=
>
&gt;&gt; true))<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.gfx_off_state =3D true;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp;adev-<br>
&gt;&gt;&gt; gfx.gfx_off_delay_work,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_delayed_wo=
rk(&amp;adev-<br>
&gt;&gt;&gt; gfx.gfx_off_delay_work,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; delay);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.gfx_off_req_count =3D=3D 0) {<br>
&gt;&gt; --<br>
&gt;&gt; 2.34.1<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E8E50EBC7B9C079ABDD9F77C9BL1PR12MB5144namp_--
