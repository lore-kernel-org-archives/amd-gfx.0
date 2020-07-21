Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9B0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47822073A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z+fIrDI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47822073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F2F6E156;
	Tue, 21 Jul 2020 17:02:58 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680047.outbound.protection.outlook.com [40.107.68.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1168A6E156
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 17:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOn6BDl1dK2VE0CFctumA9ETgXh5O4T+/q2gYwD7GvVJv9zM0lD+2gNjRzuywLuC8mY8wXdUzH7yEE7YQVtBPfCuVKXKCLkSfOAZPZmDTFlxecaepk7W+7CYb9Omh6c/MaOQfQjeQPVg8mCz0/3DIEzBS/1OdVBMA8j5JlNelAiIslLD9DWgPkq3QsThlzNv/khnXjXjTcZJ2Vb3Pfni955BAnnm7Du/3PrEuJmEsYO8aHlcBElQZgoyRan85HJHxQEXv3Vdbx2D4y5hmfy3PlYM4LoNVFNmBujojEfBaHY/dPGtuxPCv+ncyOX9l2ho7xoubd/qJzVXiTVf9Vbgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyzScqP71cv3OnoD5/E566tfR766xQiNJ9IQOjLyT+w=;
 b=CoS4j3aQP6sshEvaXUGNm9x2n7v8bf08Cqwb9oGXTMpb7CzFyttXYU5LjOGhfFkNyTDNJGmrXCnz/ERXa04A64/6+jfPFndZml8l18+5rf4I6DjvIp+dmRDcrbNedYkijcena9ihH9OTVHu8Zugpj/d7QqYW57KNuuPTZKg8ZjGIaN563qw5Mo6S0t67wXyLcaanh7DBLua8qvFjEVJP5WgiiMJUVA6JJpYn51Y6YxiClQxBAxJ9zDGfsuha9i5GeQb7ge/ud19JxytLUeiBLberq6BjOsBpT1TC90lMSJKbExjRBsNhiHq6fMcEZplWKaz5ATdHzfXX46D7LMFDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyzScqP71cv3OnoD5/E566tfR766xQiNJ9IQOjLyT+w=;
 b=Z+fIrDI2nqRopRocS/gZv1mxXfQJdkd7wrWYeFe4o3tBzFP/OUNN0umxqH3RrXK1RUchH3vNYjnWjx639UrOWV9kxN4sb0wOs6eML7vGwC8SRsKVf/1Yr2NM651YRlIXjL0ikmr4oWxgo26HnfAQMiyQi29yK+6gDlS4NSO7UkU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Tue, 21 Jul
 2020 17:02:55 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%5]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 17:02:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 6/6] drm/amdgpu/sienna_cichlid: add SMU i2c support
Thread-Topic: [PATCH 6/6] drm/amdgpu/sienna_cichlid: add SMU i2c support
Thread-Index: AQHWX39iktrR0RavhEuZPVdOq2nkIKkSQicAgAAAHi4=
Date: Tue, 21 Jul 2020 17:02:55 +0000
Message-ID: <MN2PR12MB448833676E53ED61A56771C6F7780@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200721165240.296265-1-alexander.deucher@amd.com>
 <20200721165240.296265-6-alexander.deucher@amd.com>,
 <fa57d3dd-f945-1407-b813-170be1cbfa0a@amd.com>
In-Reply-To: <fa57d3dd-f945-1407-b813-170be1cbfa0a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-21T17:02:54.054Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.190.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12417623-aac1-438e-9c1a-08d82d97e98a
x-ms-traffictypediagnostic: MN2PR12MB4272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB427218A797FC1B0F4A2B091CF7780@MN2PR12MB4272.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q8ghgrMOLIkREIySqJ3Zs+F2sCaaaZU3He1DysGCNYCZ/I3x2p3+akY79Iznnvs7CUTOCLJOxb/7+FTyurAZhlK0J9calzYB1fz4Y2JH6Mp4D7ZgqNcteaDR/IDeZM2nQlI55X8hbb8gf5GicbVf3O3Pv3hO66LVdiFsZqA569aBU0cUcaJEpqXxBgPjIXM2fMQydcIowdvBNL4qj1gJusTDhZilvNkVwrrghVdtGDFDVVIcbL3aaHKCZkBSmjEFqBPDSyamoE9vRA3prFqMyMGqPj9In36HcLVtywgcKtq5Ak28fzubNhAehqbGJ9e2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(5660300002)(76116006)(186003)(66476007)(66556008)(66446008)(64756008)(66946007)(86362001)(8936002)(478600001)(19627405001)(52536014)(33656002)(8676002)(71200400001)(83380400001)(55016002)(6506007)(110136005)(316002)(9686003)(26005)(7696005)(53546011)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lcXoHiaV6GNC7nNsTnDH+MyEcgB8LCZkNkwL81NYiv0dtMQlU8Gb+pbNHGfx5NXU1TzPPWjatwXsrPSzLDomOknk0hjPLCYzf9gt6zaZjdiEYb9ZITaD8Chuoi4EUc6LsNqFhgU5p854BoytLOKSwG7XG1uozv9qUcGdCwkTDdwXjr6b2GeUpdVdvOH1gkKWxrSQxGIUAvaeUyEl+2kMKLCF1duOIWZALt1dUd8vyfa8nC/sqtaf9uLU1lMHwin6Bk9ADBnFfHgngjWwZMvLnoP4DafS5BukAq9j4WUiPKlUdp7xLxllCVmXZ4Tp0Ll/4OcYi7UNbV/eX9syjC6kkwzM0LoM9ZSf/1mdkW+Zqj3zrmEjefuc1WIoriClo2DhkOFy4vAISF6wH2H7XdDkLsfiewfnwPLswM2inttPRknqlQW7yEUnJWyaopbgUPU+AcMx5mISK7wogEePT0rdk/ZsODyFcAnkq3EQDZOtISQPZaq16WKXdad9yyUFRz5G
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12417623-aac1-438e-9c1a-08d82d97e98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 17:02:55.2679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nC1s5HV9AkSiqYVYk/ADCWBuciMmjmkBBfxzkw+CUl2Ui5LZa17cFzz97YxzN4cxkbgBdcxGvM8dtwc+opNSEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Content-Type: multipart/mixed; boundary="===============0613299609=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0613299609==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448833676E53ED61A56771C6F7780MN2PR12MB4488namp_"

--_000_MN2PR12MB448833676E53ED61A56771C6F7780MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I tried that at first, but the smu i2c interface structures are different p=
er asic.

Alex

________________________________
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Sent: Tuesday, July 21, 2020 1:01 PM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu/sienna_cichlid: add SMU i2c support

Looks like same code as arcturus - should we make it common helper code and
reuse in both ?

Andrey

On 7/21/20 12:52 PM, Alex Deucher wrote:
> Enable SMU i2c bus access for sienna_cichlid asics.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 239 ++++++++++++++++++
>   1 file changed, 239 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers=
/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 5faef41b63a3..e1857fbb0a6f 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -23,6 +23,7 @@
>
>   #include <linux/firmware.h>
>   #include <linux/pci.h>
> +#include <linux/i2c.h>
>   #include "amdgpu.h"
>   #include "amdgpu_smu.h"
>   #include "smu_internal.h"
> @@ -52,6 +53,8 @@
>   #undef pr_info
>   #undef pr_debug
>
> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.sm=
u_i2c))
> +
>   #define FEATURE_MASK(feature) (1ULL << feature)
>   #define SMC_DPM_FEATURE ( \
>        FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
> @@ -455,6 +458,8 @@ static int sienna_cichlid_tables_init(struct smu_cont=
ext *smu, struct smu_table
>                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>        SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t)=
,
>                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +     SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_=
t),
> +                    PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>        SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTable_=
t),
>                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>        SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU11_TOOL_SIZE,
> @@ -2487,6 +2492,238 @@ static void sienna_cichlid_dump_pptable(struct sm=
u_context *smu)
>        dev_info(smu->adev->dev, "MmHubPadding[7] =3D 0x%x\n", pptable->Mm=
HubPadding[7]);
>   }
>
> +static void sienna_cichlid_fill_i2c_req(SwI2cRequest_t  *req, bool write=
,
> +                               uint8_t address, uint32_t numbytes,
> +                               uint8_t *data)
> +{
> +     int i;
> +
> +     BUG_ON(numbytes > MAX_SW_I2C_COMMANDS);
> +
> +     req->I2CcontrollerPort =3D 0;
> +     req->I2CSpeed =3D 2;
> +     req->SlaveAddress =3D address;
> +     req->NumCmds =3D numbytes;
> +
> +     for (i =3D 0; i < numbytes; i++) {
> +             SwI2cCmd_t *cmd =3D  &req->SwI2cCmds[i];
> +
> +             /* First 2 bytes are always write for lower 2b EEPROM addre=
ss */
> +             if (i < 2)
> +                     cmd->CmdConfig =3D CMDCONFIG_READWRITE_MASK;
> +             else
> +                     cmd->CmdConfig =3D write ? CMDCONFIG_READWRITE_MASK=
 : 0;
> +
> +
> +             /* Add RESTART for read  after address filled */
> +             cmd->CmdConfig |=3D (i =3D=3D 2 && !write) ? CMDCONFIG_REST=
ART_MASK : 0;
> +
> +             /* Add STOP in the end */172.31.4.187
> +             cmd->CmdConfig |=3D (i =3D=3D (numbytes - 1)) ? CMDCONFIG_S=
TOP_MASK : 0;
> +
> +             /* Fill with data regardless if read or write to simplify c=
ode */
> +             cmd->ReadWriteData =3D data[i];
> +     }
> +}
> +
> +static int sienna_cichlid_i2c_read_data(struct i2c_adapter *control,
> +                                            uint8_t address,
> +                                            uint8_t *data,
> +                                            uint32_t numbytes)
> +{
> +     uint32_t  i, ret =3D 0;
> +     SwI2cRequest_t req;
> +     struct amdgpu_device *adev =3D to_amdgpu_device(control);
> +     struct smu_table_context *smu_table =3D &adev->smu.smu_table;
> +     struct smu_table *table =3D &smu_table->driver_table;
> +
> +     memset(&req, 0, sizeof(req));
> +     sienna_cichlid_fill_i2c_req(&req, false, address, numbytes, data);
> +
> +     mutex_lock(&adev->smu.mutex);
> +     /* Now read data starting with that address */
> +     ret =3D smu_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &re=
q,
> +                                     true);
> +     mutex_unlock(&adev->smu.mutex);
> +
> +     if (!ret) {
> +             SwI2cRequest_t *res =3D (SwI2cRequest_t *)table->cpu_addr;
> +
> +             /* Assume SMU  fills res.SwI2cCmds[i].Data with read bytes =
*/
> +             for (i =3D 0; i < numbytes; i++)
> +                     data[i] =3D res->SwI2cCmds[i].ReadWriteData;
> +
> +             dev_dbg(adev->dev, "sienna_cichlid_i2c_read_data, address =
=3D %x, bytes =3D %d, data :",
> +                               (uint16_t)address, numbytes);
> +
> +             print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
> +                            8, 1, data, numbytes, false);
> +     } else
> +             dev_err(adev->dev, "sienna_cichlid_i2c_read_data - error oc=
curred :%x", ret);
> +
> +     return ret;
> +}
> +
> +static int sienna_cichlid_i2c_write_data(struct i2c_adapter *control,
> +                                             uint8_t address,
> +                                             uint8_t *data,
> +                                             uint32_t numbytes)
> +{
> +     uint32_t ret;
> +     SwI2cRequest_t req;
> +     struct amdgpu_device *adev =3D to_amdgpu_device(control);
> +
> +     memset(&req, 0, sizeof(req));
> +     sienna_cichlid_fill_i2c_req(&req, true, address, numbytes, data);
> +
> +     mutex_lock(&adev->smu.mutex);
> +     ret =3D smu_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &re=
q, true);
> +     mutex_unlock(&adev->smu.mutex);
> +
> +     if (!ret) {
> +             dev_dbg(adev->dev, "sienna_cichlid_i2c_write(), address =3D=
 %x, bytes =3D %d , data: ",
> +                                      (uint16_t)address, numbytes);
> +
> +             print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
> +                            8, 1, data, numbytes, false);
> +             /*
> +              * According to EEPROM spec there is a MAX of 10 ms require=
d for
> +              * EEPROM to flush internal RX buffer after STOP was issued=
 at the
> +              * end of write transaction. During this time the EEPROM wi=
ll not be
> +              * responsive to any more commands - so wait a bit more.
> +              */
> +             msleep(10);
> +
> +     } else
> +             dev_err(adev->dev, "sienna_cichlid_i2c_write- error occurre=
d :%x", ret);
> +
> +     return ret;
> +}
> +
> +static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
> +                           struct i2c_msg *msgs, int num)
> +{
> +     uint32_t  i, j, ret, data_size, data_chunk_size, next_eeprom_addr =
=3D 0;
> +     uint8_t *data_ptr, data_chunk[MAX_SW_I2C_COMMANDS] =3D { 0 };
> +
> +     for (i =3D 0; i < num; i++) {
> +             /*
> +              * SMU interface allows at most MAX_SW_I2C_COMMANDS bytes o=
f data at
> +              * once and hence the data needs to be spliced into chunks =
and sent each
> +              * chunk separately
> +              */
> +             data_size =3D msgs[i].len - 2;
> +             data_chunk_size =3D MAX_SW_I2C_COMMANDS - 2;
> +             next_eeprom_addr =3D (msgs[i].buf[0] << 8 & 0xff00) | (msgs=
[i].buf[1] & 0xff);
> +             data_ptr =3D msgs[i].buf + 2;
> +
> +             for (j =3D 0; j < data_size / data_chunk_size; j++) {
> +                     /* Insert the EEPROM dest addess, bits 0-15 */
> +                     data_chunk[0] =3D ((next_eeprom_addr >> 8) & 0xff);
> +                     data_chunk[1] =3D (next_eeprom_addr & 0xff);
> +
> +                     if (msgs[i].flags & I2C_M_RD) {
> +                             ret =3D sienna_cichlid_i2c_read_data(i2c_ad=
ap,
> +                                                          (uint8_t)msgs[=
i].addr,
> +                                                          data_chunk, MA=
X_SW_I2C_COMMANDS);
> +
> +                             memcpy(data_ptr, data_chunk + 2, data_chunk=
_size);
> +                     } else {
> +
> +                             memcpy(data_chunk + 2, data_ptr, data_chunk=
_size);
> +
> +                             ret =3D sienna_cichlid_i2c_write_data(i2c_a=
dap,
> +                                                           (uint8_t)msgs=
[i].addr,
> +                                                           data_chunk, M=
AX_SW_I2C_COMMANDS);
> +                     }
> +
> +                     if (ret) {
> +                             num =3D -EIO;
> +                             goto fail;
> +                     }
> +
> +                     next_eeprom_addr +=3D data_chunk_size;
> +                     data_ptr +=3D data_chunk_size;
> +             }
> +
> +             if (data_size % data_chunk_size) {
> +                     data_chunk[0] =3D ((next_eeprom_addr >> 8) & 0xff);
> +                     data_chunk[1] =3D (next_eeprom_addr & 0xff);
> +
> +                     if (msgs[i].flags & I2C_M_RD) {
> +                             ret =3D sienna_cichlid_i2c_read_data(i2c_ad=
ap,
> +                                                          (uint8_t)msgs[=
i].addr,
> +                                                          data_chunk, (d=
ata_size % data_chunk_size) + 2);
> +
> +                             memcpy(data_ptr, data_chunk + 2, data_size =
% data_chunk_size);
> +                     } else {
> +                             memcpy(data_chunk + 2, data_ptr, data_size =
% data_chunk_size);
> +
> +                             ret =3D sienna_cichlid_i2c_write_data(i2c_a=
dap,
> +                                                           (uint8_t)msgs=
[i].addr,
> +                                                           data_chunk, (=
data_size % data_chunk_size) + 2);
> +                     }
> +
> +                     if (ret) {
> +                             num =3D -EIO;
> +                             goto fail;
> +                     }
> +             }
> +     }
> +
> +fail:
> +     return num;
> +}
> +
> +static u32 sienna_cichlid_i2c_func(struct i2c_adapter *adap)
> +{
> +     return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +
> +static const struct i2c_algorithm sienna_cichlid_i2c_algo =3D {
> +     .master_xfer =3D sienna_cichlid_i2c_xfer,
> +     .functionality =3D sienna_cichlid_i2c_func,
> +};
> +
> +static bool sienna_cichlid_i2c_adapter_is_added(struct i2c_adapter *cont=
rol)
> +{
> +     struct amdgpu_device *adev =3D to_amdgpu_device(control);
> +
> +     return control->dev.parent =3D=3D &adev->pdev->dev;
> +}
> +
> +static int sienna_cichlid_i2c_control_init(struct smu_context *smu, stru=
ct i2c_adapter *control)
> +{
> +     struct amdgpu_device *adev =3D to_amdgpu_device(control);
> +     int res;
> +
> +     /* smu_i2c_eeprom_init may be called twice in sriov */
> +     if (sienna_cichlid_i2c_adapter_is_added(control))
> +             return 0;
> +
> +     control->owner =3D THIS_MODULE;
> +     control->class =3D I2C_CLASS_SPD;
> +     control->dev.parent =3D &adev->pdev->dev;
> +     control->algo =3D &sienna_cichlid_i2c_algo;
> +     snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
> +
> +     res =3D i2c_add_adapter(control);
> +     if (res)
> +             DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
> +
> +     return res;
> +}
> +
> +static void sienna_cichlid_i2c_control_fini(struct smu_context *smu, str=
uct i2c_adapter *control)
> +{
> +     if (!sienna_cichlid_i2c_adapter_is_added(control))
> +             return;
> +
> +     i2c_del_adapter(control);
> +}
> +
> +
>   static const struct pptable_funcs sienna_cichlid_ppt_funcs =3D {
>        .tables_init =3D sienna_cichlid_tables_init,
>        .alloc_dpm_context =3D sienna_cichlid_allocate_dpm_context,
> @@ -2500,6 +2737,8 @@ static const struct pptable_funcs sienna_cichlid_pp=
t_funcs =3D {
>        .set_default_dpm_table =3D sienna_cichlid_set_default_dpm_table,
>        .dpm_set_vcn_enable =3D sienna_cichlid_dpm_set_vcn_enable,
>        .dpm_set_jpeg_enable =3D sienna_cichlid_dpm_set_jpeg_enable,
> +     .i2c_eeprom_init =3D sienna_cichlid_i2c_control_init,
> +     .i2c_eeprom_fini =3D sienna_cichlid_i2c_control_fini,
>        .print_clk_levels =3D sienna_cichlid_print_clk_levels,
>        .force_clk_levels =3D sienna_cichlid_force_clk_levels,
>        .populate_umd_state_clk =3D sienna_cichlid_populate_umd_state_clk,

--_000_MN2PR12MB448833676E53ED61A56771C6F7780MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I tried that at first, but the smu i2c interface structures are different p=
er asic.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Grodzovsky, Andrey &l=
t;Andrey.Grodzovsky@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 21, 2020 1:01 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 6/6] drm/amdgpu/sienna_cichlid: add SMU i2c supp=
ort</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Looks like same code as arcturus - should we make =
it common helper code and
<br>
reuse in both ?<br>
<br>
Andrey<br>
<br>
On 7/21/20 12:52 PM, Alex Deucher wrote:<br>
&gt; Enable SMU i2c bus access for sienna_cichlid asics.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../drm/amd/powerplay/sienna_cichlid_ppt.c&nbsp;&nbsp;&nbs=
p; | 239 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 239 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
&gt; index 5faef41b63a3..e1857fbb0a6f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<b=
r>
&gt; @@ -23,6 &#43;23,7 @@<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #include &lt;linux/firmware.h&gt;<br>
&gt;&nbsp;&nbsp; #include &lt;linux/pci.h&gt;<br>
&gt; &#43;#include &lt;linux/i2c.h&gt;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_smu.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;smu_internal.h&quot;<br>
&gt; @@ -52,6 &#43;53,8 @@<br>
&gt;&nbsp;&nbsp; #undef pr_info<br>
&gt;&nbsp;&nbsp; #undef pr_debug<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device=
, pm.smu_i2c))<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; #define FEATURE_MASK(feature) (1ULL &lt;&lt; feature)<br>
&gt;&nbsp;&nbsp; #define SMC_DPM_FEATURE ( \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_MASK(FEATURE_DPM_PRE=
FETCHER_BIT) | \<br>
&gt; @@ -455,6 &#43;458,8 @@ static int sienna_cichlid_tables_init(struct s=
mu_context *smu, struct smu_table<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, AM=
DGPU_GEM_DOMAIN_VRAM);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU_T=
ABLE_SMU_METRICS, sizeof(SmuMetrics_t),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, AM=
DGPU_GEM_DOMAIN_VRAM);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COM=
MANDS, sizeof(SwI2cRequest_t),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, AMDGPU_GEM_DOM=
AIN_VRAM);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU_T=
ABLE_OVERDRIVE, sizeof(OverDriveTable_t),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, AM=
DGPU_GEM_DOMAIN_VRAM);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU_T=
ABLE_PMSTATUSLOG, SMU11_TOOL_SIZE,<br>
&gt; @@ -2487,6 &#43;2492,238 @@ static void sienna_cichlid_dump_pptable(st=
ruct smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(smu-&gt;adev-&gt;de=
v, &quot;MmHubPadding[7] =3D 0x%x\n&quot;, pptable-&gt;MmHubPadding[7]);<br=
>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static void sienna_cichlid_fill_i2c_req(SwI2cRequest_t&nbsp; *req=
, bool write,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t address, uint32_t numbytes=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *data)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(numbytes &gt; MAX_SW_I2C_COMMANDS=
);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;I2CcontrollerPort =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;I2CSpeed =3D 2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;SlaveAddress =3D address;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;NumCmds =3D numbytes;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; numbytes; i&#43;&#4=
3;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SwI2cCmd_t *cmd =3D&nbsp; &amp;req-&gt;SwI2cCmds[i];<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* First 2 bytes are always write for lower 2b EEPROM address */<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (i &lt; 2)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;CmdConfig =
=3D CMDCONFIG_READWRITE_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;CmdConfig =
=3D write ? CMDCONFIG_READWRITE_MASK : 0;<br>
&gt; &#43;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Add RESTART for read&nbsp; after address filled */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; cmd-&gt;CmdConfig |=3D (i =3D=3D 2 &amp;&amp; !write) ? CMDCONFIG_R=
ESTART_MASK : 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Add STOP in the end */172.31.4.187<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; cmd-&gt;CmdConfig |=3D (i =3D=3D (numbytes - 1)) ? CMDCONFIG_STOP_M=
ASK : 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Fill with data regardless if read or write to simplify code */<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; cmd-&gt;ReadWriteData =3D data[i];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int sienna_cichlid_i2c_read_data(struct i2c_adapter *contr=
ol,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t address,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *data,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t numbytes)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; i, ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; SwI2cRequest_t req;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D to_amdgpu=
_device(control);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_table =3D =
&amp;adev-&gt;smu.smu_table;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =3D &amp;smu_tab=
le-&gt;driver_table;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;req, 0, sizeof(req));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sienna_cichlid_fill_i2c_req(&amp;req, fa=
lse, address, numbytes, data);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;smu.mutex);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Now read data starting with that addr=
ess */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_update_table(&amp;adev-&gt;s=
mu, SMU_TABLE_I2C_COMMANDS, 0, &amp;req,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;smu.mutex);<b=
r>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SwI2cRequest_t *res =3D (SwI2cRequest_t *)table-&gt;cpu_addr;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Assume SMU&nbsp; fills res.SwI2cCmds[i].Data with read bytes */<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; for (i =3D 0; i &lt; numbytes; i&#43;&#43;)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data[i] =3D res-&gt=
;SwI2cCmds[i].ReadWriteData;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dev_dbg(adev-&gt;dev, &quot;sienna_cichlid_i2c_read_data, address =
=3D %x, bytes =3D %d, data :&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint16_t)address, numbytes);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; print_hex_dump(KERN_DEBUG, &quot;data: &quot;, DUMP_PREFIX_NONE,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 8, 1, data, numbytes, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dev_err(adev-&gt;dev, &quot;sienna_cichlid_i2c_read_data - error oc=
curred :%x&quot;, ret);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int sienna_cichlid_i2c_write_data(struct i2c_adapter *cont=
rol,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t address,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *data,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t numbytes)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; SwI2cRequest_t req;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D to_amdgpu=
_device(control);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;req, 0, sizeof(req));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sienna_cichlid_fill_i2c_req(&amp;req, tr=
ue, address, numbytes, data);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;smu.mutex);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_update_table(&amp;adev-&gt;s=
mu, SMU_TABLE_I2C_COMMANDS, 0, &amp;req, true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;smu.mutex);<b=
r>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dev_dbg(adev-&gt;dev, &quot;sienna_cichlid_i2c_write(), address =3D=
 %x, bytes =3D %d , data: &quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (uint16_t)address, numbytes);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; print_hex_dump(KERN_DEBUG, &quot;data: &quot;, DUMP_PREFIX_NONE,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 8, 1, data, numbytes, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /*<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * According to EEPROM spec there is a MAX of 10 ms required f=
or<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * EEPROM to flush internal RX buffer after STOP was issued at=
 the<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * end of write transaction. During this time the EEPROM will =
not be<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * responsive to any more commands - so wait a bit more.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; msleep(10);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dev_err(adev-&gt;dev, &quot;sienna_cichlid_i2c_write- error occurre=
d :%x&quot;, ret);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct i2c_msg *msgs, int num)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; i, j, ret, data_size, dat=
a_chunk_size, next_eeprom_addr =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *data_ptr, data_chunk[MAX_SW_I2C=
_COMMANDS] =3D { 0 };<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num; i&#43;&#43;) {=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /*<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * SMU interface allows at most MAX_SW_I2C_COMMANDS bytes of d=
ata at<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * once and hence the data needs to be spliced into chunks and=
 sent each<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * chunk separately<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data_size =3D msgs[i].len - 2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data_chunk_size =3D MAX_SW_I2C_COMMANDS - 2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; next_eeprom_addr =3D (msgs[i].buf[0] &lt;&lt; 8 &amp; 0xff00) | (ms=
gs[i].buf[1] &amp; 0xff);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data_ptr =3D msgs[i].buf &#43; 2;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; for (j =3D 0; j &lt; data_size / data_chunk_size; j&#43;&#43;) {<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Insert the EEPRO=
M dest addess, bits 0-15 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_chunk[0] =3D (=
(next_eeprom_addr &gt;&gt; 8) &amp; 0xff);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_chunk[1] =3D (=
next_eeprom_addr &amp; 0xff);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msgs[i].flags &=
amp; I2C_M_RD) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D sienna_cichlid_i2c_read_data(i2c_adap,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t)msgs[i].addr,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_chunk, MAX_SW_I2C=
_COMMANDS);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data_ptr, data_chunk &#43; 2, data_chun=
k_size);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data_chunk &#43; 2, data_ptr, data_chun=
k_size);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D sienna_cichlid_i2c_write_data(i2c_adap=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t)msgs[i]=
.addr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_chunk, MAX_=
SW_I2C_COMMANDS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; num =3D -EIO;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_eeprom_addr &#=
43;=3D data_chunk_size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_ptr &#43;=3D d=
ata_chunk_size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (data_size % data_chunk_size) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_chunk[0] =3D (=
(next_eeprom_addr &gt;&gt; 8) &amp; 0xff);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_chunk[1] =3D (=
next_eeprom_addr &amp; 0xff);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msgs[i].flags &=
amp; I2C_M_RD) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D sienna_cichlid_i2c_read_data(i2c_adap,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t)msgs[i].addr,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_chunk, (data_size=
 % data_chunk_size) &#43; 2);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data_ptr, data_chunk &#43; 2, data_size=
 % data_chunk_size);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data_chunk &#43; 2, data_ptr, data_size=
 % data_chunk_size);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D sienna_cichlid_i2c_write_data(i2c_adap=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t)msgs[i]=
.addr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_chunk, (dat=
a_size % data_chunk_size) &#43; 2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; num =3D -EIO;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;fail:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return num;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static u32 sienna_cichlid_i2c_func(struct i2c_adapter *adap)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMU=
L;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;<br>
&gt; &#43;static const struct i2c_algorithm sienna_cichlid_i2c_algo =3D {<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .master_xfer =3D sienna_cichlid_i2c_xfer=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .functionality =3D sienna_cichlid_i2c_fu=
nc,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static bool sienna_cichlid_i2c_adapter_is_added(struct i2c_adapte=
r *control)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D to_amdgpu=
_device(control);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return control-&gt;dev.parent =3D=3D &am=
p;adev-&gt;pdev-&gt;dev;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int sienna_cichlid_i2c_control_init(struct smu_context *sm=
u, struct i2c_adapter *control)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D to_amdgpu=
_device(control);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int res;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* smu_i2c_eeprom_init may be called twi=
ce in sriov */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (sienna_cichlid_i2c_adapter_is_added(=
control))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;owner =3D THIS_MODULE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;class =3D I2C_CLASS_SPD;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;dev.parent =3D &amp;adev-&gt=
;pdev-&gt;dev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;algo =3D &amp;sienna_cichlid=
_i2c_algo;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(control-&gt;name, sizeof(contro=
l-&gt;name), &quot;AMDGPU SMU&quot;);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; res =3D i2c_add_adapter(control);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (res)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;Failed to register hw i2c, err: %d\n&quot;, res);<b=
r>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return res;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static void sienna_cichlid_i2c_control_fini(struct smu_context *s=
mu, struct i2c_adapter *control)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!sienna_cichlid_i2c_adapter_is_added=
(control))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; i2c_del_adapter(control);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static const struct pptable_funcs sienna_cichlid_ppt_funcs=
 =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tables_init =3D sienna_cich=
lid_tables_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .alloc_dpm_context =3D sienn=
a_cichlid_allocate_dpm_context,<br>
&gt; @@ -2500,6 &#43;2737,8 @@ static const struct pptable_funcs sienna_cic=
hlid_ppt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D s=
ienna_cichlid_set_default_dpm_table,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpm_set_vcn_enable =3D sien=
na_cichlid_dpm_set_vcn_enable,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpm_set_jpeg_enable =3D sie=
nna_cichlid_dpm_set_jpeg_enable,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .i2c_eeprom_init =3D sienna_cichlid_i2c_=
control_init,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .i2c_eeprom_fini =3D sienna_cichlid_i2c_=
control_fini,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clk_levels =3D sienna=
_cichlid_print_clk_levels,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clk_levels =3D sienna=
_cichlid_force_clk_levels,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_umd_state_clk =3D =
sienna_cichlid_populate_umd_state_clk,<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448833676E53ED61A56771C6F7780MN2PR12MB4488namp_--

--===============0613299609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0613299609==--
