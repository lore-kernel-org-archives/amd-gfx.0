Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD4CC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F286861073
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F286861073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2146E822;
	Thu, 26 Aug 2021 12:23:04 +0000 (UTC)
X-Greylist: delayed 171622 seconds by postgrey-1.36 at gabe;
 Thu, 26 Aug 2021 12:23:02 UTC
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (unknown
 [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06066E822
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4QFV8GHSy3owa1OxQV787q8dmMLiAB9XPJ76EkkkdEsiKgJc/KkCdV2FEt6xDxkXsnQXGDq3voSC7Wg+qgMROTzYlB9rZvie2LbcM/kEUdwKom7HY/MqL6kKn56LEbyZQGid7uvvq/GLlL2QuO+lYdIAJh40Mg1rTdPoQrvphilMBXRfFIuqfOTpAqXyrpZJ8upyptcminTiob7W/WxRwWdpOwZ93G1adT81PSEfT+Ls5KahyYyHeVdTF8Nme0IARsYTJ/UtRGH2pP1nbSVYUmiCDCAZ7BljG4yJqOeu03ESIaf0l2LbrVihqQ4yARSsN6zGZQ4AdwD8NqgcCN6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XISRQNWpoMoNaA36rv4iRbhr8VZIlL6zLP/Cs27lKCE=;
 b=IW7dpooevw5UPvZ0g6M0MMtfetsZJMoqZyS4q3+xVXJtSSVY/CILTZxm0+HsfrMtqXzw6uYg5HlRGNtp39ee95AHk/avp3Oo387SPDeVGASWOxfCM6vpXe/2WVRfMaZakaaehEIDLBxoTRgP+dFICVYNc7ohCQE9v/1B+qljv7L9VDX1OxBZzMkslbiV6WeImjI3FAiLrcSM0moWWObvaQ1uXILxv26AOJGjv4iYZoogSE8t8l4wNrLgr/nQ55MtfqCgc569m3mJkwkCQWwUexD/dKlz0fFodbrvmEefq5koxMlUbr1qSJlinq2vF1zzjnHDTmUscnSZIS83dGNrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XISRQNWpoMoNaA36rv4iRbhr8VZIlL6zLP/Cs27lKCE=;
 b=zo/cJxGzWIbeYFmKqCwOK5fKug+EV7E/Mi9EmtiGbrKV1NIA+/sKniz65ulovWXODUCTj8TyH0WSCMYqBNj3ph/7a1BFWdhVg+avhRiXbAQNIr/nsDdTqRLSv9jzXD620g2wmqCupBzalv9e7gnOYQ/ypfm2q2wwuBYn2bqEQHo=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Thu, 26 Aug 2021 12:22:59 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be%2]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 12:22:59 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
Thread-Topic: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
Thread-Index: AQHXmdZuCB+yjCUtWE2SNVzYjE2lt6uFs3wAgAAARLeAAAHCAIAAALxN
Date: Thu, 26 Aug 2021 12:22:59 +0000
Message-ID: <DM6PR12MB35470F0FA108B66B49434B10F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20210825172659.247530-1-tom.stdenis@amd.com>
 <4f68568f-6f38-a36d-397b-c9d1d03cf9e2@amd.com>
 <DM6PR12MB3547D401A95FC5CB86595348F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
 <eec9d9d5-aff6-5344-b15b-155a46a57e76@amd.com>
In-Reply-To: <eec9d9d5-aff6-5344-b15b-155a46a57e76@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-26T12:22:58.855Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 515ec698-be5f-4360-3b35-08d9688c3e1e
x-ms-traffictypediagnostic: DM5PR12MB1386:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1386180C832E42EB80FA48E2F7C79@DM5PR12MB1386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: etK9KfMk/L9K0i92TcX7nC/ra8H2NlkML03b3xH9aLc9UtYOQbhCvT49vLFNtXphD0Y95km0Eka+JuJhmyKqwGnzNYx7lvKFcYRqL+UYQ2voVqhJsQJiGF3MpWYC+ln36IY8+OPM3WquVAaHNUgEQRPBFY9bLYseZ6zBTBGf1gFcQ3eDl+PkO9evg7I6gGbZT8d5HuLho12nAbmFnZ1raFXlmy/lPa/UJCfj3dAdyMfu+MX486VLKnGMn3LO957QKXAzhyBkduzLlq+vy2u7BtzWCcxqYfQLV3llBoxpfTRrRle0yY9W32DL6pHJye9ok/0yZOSS0fG6zlTghALAe/cGCJIJI2UjxlAbdRYKifSwXT3F0XDnrrBzudIiW3V4AucfnjBfgNBXZSBZuGC3Fv+IL9cBj7emX+6NiDdy6BnbQZPHX0iVzvLkGbjl233l+CkHta4E3++f3Z+igePiWKhK9d/Rprz3ZK5nk0CvFqmAnpSYfm4FUjHx96XWYwrGx2QppqlkDUpILxZ5UqBffyYW7AsKC0yfnFFSrPkBUzhA0I9HRrHHR1RVNocPlSDRJYuCrpw8vLBu2NaFJsNtrzVLVriUtPwWOd6hnhn8prOuCLiL+W/+3IW/VWR52fGuD4ZmSE5Qxudxqf/ZV1GT/Q5AWe9RQeUem7eXSyJ2/TBZVAAB6Nct+DvS5Z/I5RA9T2hleTp8OX4yjemKqcjsYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(8676002)(30864003)(38070700005)(9686003)(8936002)(71200400001)(38100700002)(5660300002)(316002)(83380400001)(52536014)(110136005)(186003)(33656002)(122000001)(26005)(6506007)(66476007)(478600001)(64756008)(86362001)(66446008)(91956017)(2906002)(76116006)(66946007)(7696005)(53546011)(55016002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8+7WFYLgwm2dHIjJJULW+8Sd2RR2hM2q4RiFa3dwoNOZ1LfA0OX2nuPI4b?=
 =?iso-8859-1?Q?7DXEyIpr6k/M9U8IgrKCNwRtL9jw6Qtej/P8M01GLn42Plo/hrpxNR2evF?=
 =?iso-8859-1?Q?hx5yy71T5r1GL7Mlr2roC2I/AszqB7MU7IN6H4RB9iRWnwKvgUaBeKrhIY?=
 =?iso-8859-1?Q?zw3AJhSKWFgLP3LpzvBWkqTFYbKXrvHeCuBGDb4kNW67RtfhePFhIaWgtO?=
 =?iso-8859-1?Q?nNfeCn1GL+O+82vxV313/t2N7DBTJ58WUzj/aSJDhphd/s9I1pSEudwVs6?=
 =?iso-8859-1?Q?Jg8INN3sJga6RoXX1b6R7w6OnJ7RpvUA+/fxU6GJOK/0RsYIL/g6g7pZSf?=
 =?iso-8859-1?Q?wnbzc1hW9zbDYvvYiq0B37zPicojiBoJLaVTHV51abXi6YL19K1TavrfAr?=
 =?iso-8859-1?Q?V66mUPdkA7iwkdD4JUT8Mu1G3NnNAUWJpb8aLYRay4VJa66xdHVbyOqiH9?=
 =?iso-8859-1?Q?r02WI6NYjOKH5wK9hJ40U5g3j42lpngFOKCcKodtl4H8k6Qpe6t67lSFf/?=
 =?iso-8859-1?Q?q43CJkngJvly6J8cABr46EBkMMHS8OBi+zeIPvS16VApiXD6y2XYjGmAPy?=
 =?iso-8859-1?Q?T8rBFYK84qPfYasvK4QEuTGCtY2fqo6UaSPcFq5GytzWAJOzZOhh26RhAC?=
 =?iso-8859-1?Q?68dHR62ywyLa+pWHbV5U2Y2u5b4bczefK6y+YbEnfNowf6FeYEr84DcqAb?=
 =?iso-8859-1?Q?cQx+63aRNnUtwb8MxJa3vwk8nb8aUu8nKT/S2o0SRXBFkwfs/Ncm1W/abc?=
 =?iso-8859-1?Q?sKpxyn5Fo1uuC6mxsgiZ69RTpiPIVp4EUrSaN6AhqT6wO+3nHZ4BlwZMpu?=
 =?iso-8859-1?Q?kP+Xu5PSQn9r9KgZ4r5W5zLO161LmiKl6sSoPxX29mYVVff5BcBSXRpXxI?=
 =?iso-8859-1?Q?SceTzcSn5tTwZMYamd7mYEyNWJiSHe11GUQRfHBAnkkbK/zncnYY152Xuq?=
 =?iso-8859-1?Q?gABVjX5Bgp3VdXUvifXZzQtoZGprif4FsfoD15LFZoDOvTLjWnGzcm1IEI?=
 =?iso-8859-1?Q?dl236VkwL2nbOJvmE3YicVfoJYwnv2ryQOGpB7kFO4W4q93s0neCjCmcDd?=
 =?iso-8859-1?Q?UDO6vqmDNjEOY5W/oz0pURellJSBf/bu++anA0l+acb1bMYripsAap1wSF?=
 =?iso-8859-1?Q?W3iXgUCyp4gWqwaw47e5zWmMC4Z6DK7CudxZTeVcae9DSsOXA8JopGmZBH?=
 =?iso-8859-1?Q?f4hXeGWRazdlj1ogyKOR15lSpVfSerYogMrsuLMERDWijxv7jvUHivlOGk?=
 =?iso-8859-1?Q?36ZUTR+9fDtCn/gqUMacKF7LAjVvy0zTnAZWuSMDf8yhfZ6oEnAykrRS7u?=
 =?iso-8859-1?Q?AJ93kIIJII+bYXLlJe8MyeRjcZsJZLp42JATh4Heo+ue/aQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515ec698-be5f-4360-3b35-08d9688c3e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 12:22:59.4195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/T5eWWTCyVmsrBmhpd84BdLulmhhzstcCywuHuIbyST/PwXz59aIH9DDqJlXkFopA8JW4Ppo9afMdD4BkADpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1386
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

[AMD Official Use Only]

The issue is someone can issue an ioctl WHILE a read/write is happening.  I=
n that case a read could take a [say] SRBM lock but then never free it.

Two threads racing operations WITH the lock in place just means the userspa=
ce gets undefined outputs which from the kernel is fine.

Tom

________________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, August 26, 2021 08:19
To: StDenis, Tom; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registe=
rs (v5)

If there are two threads using the same fd, I don't see anything that
prevent this order

        set_state (T1) // State1
        set_state (T2) // State2
        read (T1)
        write (T2)

If there are separate fds, I guess the device level mutex takes care anyway=
.

Thanks,
Lijo

On 8/26/2021 5:45 PM, StDenis, Tom wrote:
> [AMD Official Use Only]
>
> While umr uses this as a constant two-step dance that doesn't mean anothe=
r user task couldn't misbehave.  Two threads firing read/write and IOCTL at=
 the same time could cause a lock imbalance.
>
> As I remarked to Christian offline that's unlikely to happen since umr is=
 the only likely user of this it's still ideal to avoid potential race cond=
itions as a matter of correctness.
>
> Tom
>
> ________________________________________
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, August 26, 2021 08:12
> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO regis=
ters (v5)
>
>
>
> On 8/25/2021 10:56 PM, Tom St Denis wrote:
>> This new debugfs interface uses an IOCTL interface in order to pass
>> along state information like SRBM and GRBM bank switching.  This
>> new interface also allows a full 32-bit MMIO address range which
>> the previous didn't.  With this new design we have room to grow
>> the flexibility of the file as need be.
>>
>> (v2): Move read/write to .read/.write, fix style, add comment
>>         for IOCTL data structure
>>
>> (v3): C style comments
>>
>> (v4): use u32 in struct and remove offset variable
>>
>> (v5): Drop flag clearing in op function, use 0xFFFFFFFF for broadcast
>>         instead of 0x3FF, use mutex for op/ioctl.
>>
>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 150 +++++++++++++++++++=
+
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |   1 -
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h     |  51 +++++++
>>    3 files changed, 201 insertions(+), 1 deletion(-)
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_debugfs.c
>> index 277128846dd1..87766fef0b1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -36,6 +36,7 @@
>>    #include "amdgpu_rap.h"
>>    #include "amdgpu_securedisplay.h"
>>    #include "amdgpu_fw_attestation.h"
>> +#include "amdgpu_umr.h"
>>
>>    int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>>    {
>> @@ -279,6 +280,143 @@ static ssize_t amdgpu_debugfs_regs_write(struct fi=
le *f, const char __user *buf,
>>        return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf=
, size, pos);
>>    }
>>
>> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *=
file)
>> +{
>> +     struct amdgpu_debugfs_regs2_data *rd;
>> +
>> +     rd =3D kzalloc(sizeof *rd, GFP_KERNEL);
>> +     if (!rd)
>> +             return -ENOMEM;
>> +     rd->adev =3D file_inode(file)->i_private;
>> +     file->private_data =3D rd;
>> +     mutex_init(&rd->lock);
>> +
>> +     return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct fil=
e *file)
>> +{
>> +     kfree(file->private_data);
>> +     return 0;
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf=
, u32 offset, size_t size, int write_en)
>> +{
>> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>> +     struct amdgpu_device *adev =3D rd->adev;
>> +     ssize_t result =3D 0;
>> +     int r;
>> +     uint32_t value;
>> +
>> +     if (size & 0x3 || offset & 0x3)
>> +             return -EINVAL;
>> +
>> +     r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> +     if (r < 0) {
>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +             return r;
>> +     }
>> +
>> +     r =3D amdgpu_virt_enable_access_debugfs(adev);
>> +     if (r < 0) {
>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +             return r;
>> +     }
>> +
>> +     mutex_lock(&rd->lock);
>> +
>> +     if (rd->id.use_grbm) {
>> +             if ((rd->id.grbm.sh !=3D 0xFFFFFFFF && rd->id.grbm.sh >=3D=
 adev->gfx.config.max_sh_per_se) ||
>> +                 (rd->id.grbm.se !=3D 0xFFFFFFFF && rd->id.grbm.se >=3D=
 adev->gfx.config.max_shader_engines)) {
>> +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev)=
;
>> +                     amdgpu_virt_disable_access_debugfs(adev);
>> +                     mutex_unlock(&rd->lock);
>> +                     return -EINVAL;
>> +             }
>> +             mutex_lock(&adev->grbm_idx_mutex);
>> +             amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
>> +                                                             rd->id.grb=
m.sh,
>> +                                                             rd->id.grb=
m.instance);
>> +     }
>> +
>> +     if (rd->id.use_srbm) {
>> +             mutex_lock(&adev->srbm_mutex);
>> +             amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.s=
rbm.pipe,
>> +                                                                     rd=
->id.srbm.queue, rd->id.srbm.vmid);
>> +     }
>> +
>> +     if (rd->id.pg_lock)
>> +             mutex_lock(&adev->pm.mutex);
>> +
>> +     while (size) {
>> +             if (!write_en) {
>> +                     value =3D RREG32(offset >> 2);
>> +                     r =3D put_user(value, (uint32_t *)buf);
>> +             } else {
>> +                     r =3D get_user(value, (uint32_t *)buf);
>> +                     if (!r)
>> +                             amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2,=
 value);
>> +             }
>> +             if (r) {
>> +                     result =3D r;
>> +                     goto end;
>> +             }
>> +             offset +=3D 4;
>> +             size -=3D 4;
>> +             result +=3D 4;
>> +             buf +=3D 4;
>> +     }
>> +end:
>> +     if (rd->id.use_grbm) {
>> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xff=
ffffff);
>> +             mutex_unlock(&adev->grbm_idx_mutex);
>> +     }
>> +
>> +     if (rd->id.use_srbm) {
>> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>> +             mutex_unlock(&adev->srbm_mutex);
>> +     }
>> +
>> +     if (rd->id.pg_lock)
>> +             mutex_unlock(&adev->pm.mutex);
>> +
>> +     mutex_unlock(&rd->lock);
>> +
>> +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +
>> +     amdgpu_virt_disable_access_debugfs(adev);
>> +     return result;
>> +}
>> +
>> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd=
, unsigned long data)
>> +{
>> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>> +     int r;
>> +
>> +     switch (cmd) {
>> +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>> +             mutex_lock(&rd->lock);
>> +             r =3D copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2=
_iocdata *)data, sizeof rd->id);
>> +             mutex_unlock(&rd->lock);
>
> As this is a two-step read/write, I don't think there is any protection
> offered by having this mutex.
>
> Thanks,
> Lijo
>
>> +             return r ? -EINVAL : 0;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +     return 0;
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *b=
uf, size_t size, loff_t *pos)
>> +{
>> +     return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __=
user *buf, size_t size, loff_t *pos)
>> +{
>> +     return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, =
1);
>> +}
>> +
>>
>>    /**
>>     * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>> @@ -1091,6 +1229,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct =
file *f, char __user *buf,
>>        return result;
>>    }
>>
>> +static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
>> +     .owner =3D THIS_MODULE,
>> +     .unlocked_ioctl =3D amdgpu_debugfs_regs2_ioctl,
>> +     .read =3D amdgpu_debugfs_regs2_read,
>> +     .write =3D amdgpu_debugfs_regs2_write,
>> +     .open =3D amdgpu_debugfs_regs2_open,
>> +     .release =3D amdgpu_debugfs_regs2_release,
>> +     .llseek =3D default_llseek
>> +};
>> +
>>    static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>>        .owner =3D THIS_MODULE,
>>        .read =3D amdgpu_debugfs_regs_read,
>> @@ -1148,6 +1296,7 @@ static const struct file_operations amdgpu_debugfs=
_gfxoff_fops =3D {
>>
>>    static const struct file_operations *debugfs_regs[] =3D {
>>        &amdgpu_debugfs_regs_fops,
>> +     &amdgpu_debugfs_regs2_fops,
>>        &amdgpu_debugfs_regs_didt_fops,
>>        &amdgpu_debugfs_regs_pcie_fops,
>>        &amdgpu_debugfs_regs_smc_fops,
>> @@ -1160,6 +1309,7 @@ static const struct file_operations *debugfs_regs[=
] =3D {
>>
>>    static const char *debugfs_regs_names[] =3D {
>>        "amdgpu_regs",
>> +     "amdgpu_regs2",
>>        "amdgpu_regs_didt",
>>        "amdgpu_regs_pcie",
>>        "amdgpu_regs_smc",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_debugfs.h
>> index 141a8474e24f..6d4965b2d01e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -22,7 +22,6 @@
>>     * OTHER DEALINGS IN THE SOFTWARE.
>>     *
>>     */
>> -
>>    /*
>>     * Debugfs
>>     */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_umr.h
>> new file mode 100644
>> index 000000000000..919d9d401750
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>> @@ -0,0 +1,51 @@
>> +/*
>> + * Copyright 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g a
>> + * copy of this software and associated documentation files (the "Softw=
are"),
>> + * to deal in the Software without restriction, including without limit=
ation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublice=
nse,
>> + * and/or sell copies of the Software, and to permit persons to whom th=
e
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be inclu=
ded in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPR=
ESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT S=
HALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGE=
S OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE=
,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE O=
R
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#include <linux/ioctl.h>
>> +
>> +/*
>> + * MMIO debugfs IOCTL structure
>> + */
>> +struct amdgpu_debugfs_regs2_iocdata {
>> +     __u32 use_srbm, use_grbm, pg_lock;
>> +     struct {
>> +             __u32 se, sh, instance;
>> +     } grbm;
>> +     struct {
>> +             __u32 me, pipe, queue, vmid;
>> +     } srbm;
>> +};
>> +
>> +/*
>> + * MMIO debugfs state data (per file* handle)
>> + */
>> +struct amdgpu_debugfs_regs2_data {
>> +     struct amdgpu_device *adev;
>> +     struct mutex lock;
>> +     struct amdgpu_debugfs_regs2_iocdata id;
>> +};
>> +
>> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,
>> +};
>> +
>> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_R=
EGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>>
