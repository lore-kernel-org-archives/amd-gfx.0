From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GPU hang trying to run OpenCL kernels on x86_64
Date: Sat, 5 May 2018 00:15:41 +0100
Message-ID: <CAEzXK1rJbXSpLUm=XQTLvySM4HJ45G9fQ0WCTPhnvdPETwUaYA@mail.gmail.com>
References: <CAEzXK1p3SnOnduP0nL1D1pNWH1LTWwApEs7QnQPTFDdBBiHLXA@mail.gmail.com>
 <CY4PR12MB13045EA9BCBFAB20D698BA86FE860@CY4PR12MB1304.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000bc4929056b697fc9"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB13045EA9BCBFAB20D698BA86FE860-rpdhrqHFk05fmUFYn07qFQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--000000000000bc4929056b697fc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

The two x86_64 systems I tried are:
- System One
  Tyan S7025 with dual Xeon X5675 and 48GB registered ECC memory, with
a NVIDIA GTX 1050Ti 4GB(also used for display) and an AMD RX 550 4GB
  Running standard Ubuntu 16.04.4 with kernels
linux-image-4.13.0-38-generic and linux-image-4.4.0-122-generic,
mesa-17.2.8-0ubuntu0, libdrm-2.4.83-1
  and amdgpu-pro 17.50/amdgpu-pro 18.10
  lsb_release -a
  Description: Ubuntu 16.04.4 LTS

  BIOS configuration:
  ACPI enabled v3.0
  ACPI APIC support Enabled
  ACPI SRAT table Enabled
  SR-IOV Enabled
  Intel VT-d Disabled
  PCI MMIO 64 Bits support Disabled


- System Two
  Tyan S7002 with dual Xeon X5670 and 12GB registered ECC memory, with
an AMD RX 480
  Running Ubuntu 18.04 with kernels vanilla 4.16.7 and
linux-image-4.15.0-20-generic, mesa-18.0.0~rc5-1ubuntu1,
libdrm-2.4.91-2
  and mesa-opencl-icd, libclc-0.2.0+git20180312-1

  BIOS configuration:
  ACPI enabled v2.0
  ACPI APIC support Enabled
  ACPI SRAT table Enabled
  SR-IOV Enabled
  Intel VT-d Disabled
  PCI MMIO 64 Bits support Disabled

  amdgpu-pro-install --headless --opencl=3Dlegacy



When I try to run the attached openCL code (which computes a
cross-correlation between two square matrices directly by cross
correlation function definition), the GPU hangs, but there are also
other kernels where this also happens.

As soon as I try to run the kernel the system hangs at the first
kernel computation on all the two systems, and after a couple of
seconds dmesg shows:
[drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, last
signaled seq=3D2, last emitted seq=3D3
[drm] IP block:gmc_v8_0 is hung!
[drm] IP block:tonga_ih is hung!
[drm] IP block:gfx_v8_0 is hung!
[drm] IP block:sdma_v3_0 is hung!
[drm] IP block:uvd_v6_0 is hung!
[drm] IP block:vce_v3_0 is hung!
[drm] GPU recovery disabled.

- On another system with armhf 32 bits, 1GB ram, 512GB SSD, AMD RX 480
or AMD RX 550
  with Ubuntu 17.10, vanilla kernel 4.16.7, mesa-18.0.2,
libdrm-2.4.92-git, libclc-git at commit
3d994f2ff2cbb4531223fe2657144cb19f0c5328 (15/Nov/2017)

  The kernels work properly on the same AMD cards.

On Fri, May 4, 2018 at 7:18 PM, Abramov, Slava <Slava.Abramov-5C7GfCeVMHo@public.gmane.org> wrot=
e:
> Luis,
>
>
> Can you please provide more details on your system environment and steps =
on
> configuring the software and reproducing the issue?
>
>
>
> Slava A
>
> ________________________________
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Lu=C3=
=ADs
> Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Friday, May 4, 2018 12:27:47 PM
> To: amd-gfx list; Koenig, Christian; Michel D=C3=A4nzer
> Subject: GPU hang trying to run OpenCL kernels on x86_64
>
> Hi,
>
> I am a collaborator with Syncleus/aparapi project on github and I've
> been testing OpenCL on AMD and NVIDIA cards.
>
> Currently I have a set of kernels that hang the GPU (AMD RX 460 and
> AMD RX 550) across all compute units on x86_64 running vanilla kernel
> 4.16.7 on Ubuntu 18.04, also on Ubuntu 16.04.4 with AMDGPU PRO 17.50
> and 18.10 show the same problems, in fact, AMDGPU-PRO 18.10 is even
> worse.
>
> However the same set of kernels run happily on armhf with vanilla
> Linux 4.16.7 and mesa 18.0 (mesa-opencl-icd and libclc for amdgcn),
> Ubuntu 17.10, on an AMD RX460 and an AMD RX 550.
>
> Lu=C3=ADs Mendes
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--000000000000bc4929056b697fc9
Content-Type: text/plain; charset="US-ASCII"; name="kernel_xcorr.txt"
Content-Disposition: attachment; filename="kernel_xcorr.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jgsjloug0

TWF5IDA0LCAyMDE4IDEwOjM3OjQxIFBNIGNvbS5hcGFyYXBpLmludGVybmFsLmtlcm5lbC5LZXJu
ZWxSdW5uZXIgZXhlY3V0ZUludGVybmFsSW5uZXIKSU5GTzogdHlwZWRlZiBzdHJ1Y3QgVGhpc19z
ewogICBfX2dsb2JhbCBpbnQgKnRpbGVzR2VvbWV0cnk7CiAgIF9fZ2xvYmFsIGludCAqaW5wdXRH
ZW9tZXRyeTsKICAgX19nbG9iYWwgaW50ICp0aHJlYWRPdXRwdXRTdGFydDsKICAgX19nbG9iYWwg
aW50ICpvdXRwdXRHZW9tZXRyeTsKICAgX19nbG9iYWwgaW50ICp0aHJlYWRPZmZzZXRJOwogICBf
X2dsb2JhbCBpbnQgKnRocmVhZE9mZnNldEo7CiAgIF9fZ2xvYmFsIGZsb2F0ICptYXRyaXhJbkY7
CiAgIF9fZ2xvYmFsIGZsb2F0ICptYXRyaXhJbkc7CiAgIF9fZ2xvYmFsIGZsb2F0ICptYXRyaXhP
dXQ7CiAgIGludCBwYXNzaWQ7Cn1UaGlzOwppbnQgZ2V0X3Bhc3NfaWQoVGhpcyAqdGhpcyl7CiAg
IHJldHVybiB0aGlzLT5wYXNzaWQ7Cn0Kc2hvcnQgcHRfaXN0X2NlcmlzX3ZpcGl2aXN0X2pvYnNf
Q3Jvc3NDb3JyZWxhdGlvbktlcm5lbF9fc2lnblgoVGhpcyAqdGhpcywgc2hvcnQgeCl7CiAgIHNo
b3J0IHZhbHVlID0gKHNob3J0KSgoeCArIHgpICsgMSk7CiAgIHJldHVybigoc2hvcnQpKHZhbHVl
IC8gYWJzKHZhbHVlKSkpOwp9CnNob3J0IHB0X2lzdF9jZXJpc192aXBpdmlzdF9qb2JzX0Nyb3Nz
Q29ycmVsYXRpb25LZXJuZWxfX3JlbG9jYXRlWChUaGlzICp0aGlzLCBzaG9ydCB4LCBzaG9ydCBk
aW1YKXsKICAgc2hvcnQgcmVzdWx0ID0gKHNob3J0KSgoKHB0X2lzdF9jZXJpc192aXBpdmlzdF9q
b2JzX0Nyb3NzQ29ycmVsYXRpb25LZXJuZWxfX3NpZ25YKHRoaXMsIHgpICsgMSkgKiAoeCArIDEp
KSAvIDIpOwogICByZXN1bHQgPSAoc2hvcnQpKCgocHRfaXN0X2NlcmlzX3ZpcGl2aXN0X2pvYnNf
Q3Jvc3NDb3JyZWxhdGlvbktlcm5lbF9fc2lnblgodGhpcywgKHNob3J0KShkaW1YIC0gcmVzdWx0
KSkgKyAxKSAqIHJlc3VsdCkgLyAyKTsKICAgcmV0dXJuKHJlc3VsdCk7Cn0KX19rZXJuZWwgdm9p
ZCBydW4oCiAgIF9fZ2xvYmFsIGludCAqdGlsZXNHZW9tZXRyeSwgCiAgIF9fZ2xvYmFsIGludCAq
aW5wdXRHZW9tZXRyeSwgCiAgIF9fZ2xvYmFsIGludCAqdGhyZWFkT3V0cHV0U3RhcnQsIAogICBf
X2dsb2JhbCBpbnQgKm91dHB1dEdlb21ldHJ5LCAKICAgX19nbG9iYWwgaW50ICp0aHJlYWRPZmZz
ZXRJLCAKICAgX19nbG9iYWwgaW50ICp0aHJlYWRPZmZzZXRKLCAKICAgX19nbG9iYWwgZmxvYXQg
Km1hdHJpeEluRiwgCiAgIF9fZ2xvYmFsIGZsb2F0ICptYXRyaXhJbkcsIAogICBfX2dsb2JhbCBm
bG9hdCAqbWF0cml4T3V0LCAKICAgaW50IHBhc3NpZAopewogICBUaGlzIHRoaXNTdHJ1Y3Q7CiAg
IFRoaXMqIHRoaXM9JnRoaXNTdHJ1Y3Q7CiAgIHRoaXMtPnRpbGVzR2VvbWV0cnkgPSB0aWxlc0dl
b21ldHJ5OwogICB0aGlzLT5pbnB1dEdlb21ldHJ5ID0gaW5wdXRHZW9tZXRyeTsKICAgdGhpcy0+
dGhyZWFkT3V0cHV0U3RhcnQgPSB0aHJlYWRPdXRwdXRTdGFydDsKICAgdGhpcy0+b3V0cHV0R2Vv
bWV0cnkgPSBvdXRwdXRHZW9tZXRyeTsKICAgdGhpcy0+dGhyZWFkT2Zmc2V0SSA9IHRocmVhZE9m
ZnNldEk7CiAgIHRoaXMtPnRocmVhZE9mZnNldEogPSB0aHJlYWRPZmZzZXRKOwogICB0aGlzLT5t
YXRyaXhJbkYgPSBtYXRyaXhJbkY7CiAgIHRoaXMtPm1hdHJpeEluRyA9IG1hdHJpeEluRzsKICAg
dGhpcy0+bWF0cml4T3V0ID0gbWF0cml4T3V0OwogICB0aGlzLT5wYXNzaWQgPSBwYXNzaWQ7CiAg
IHsKICAgICAgaW50IHNpemVJID0gZ2V0X2dsb2JhbF9zaXplKDEpOwogICAgICBpbnQgc2l6ZUog
PSBnZXRfZ2xvYmFsX3NpemUoMCk7CiAgICAgIGludCBpID0gZ2V0X2dsb2JhbF9pZCgxKTsKICAg
ICAgaW50IGogPSBnZXRfZ2xvYmFsX2lkKDApOwogICAgICBpbnQgayA9IGdldF9nbG9iYWxfaWQo
Mik7CiAgICAgIGludCBpbCA9IGdldF9sb2NhbF9pZCgwKTsKICAgICAgaW50IGpsID0gZ2V0X2xv
Y2FsX2lkKDEpOwogICAgICBpbnQgbWF0cml4SW5wdXRTdGFydCA9ICgoKChrICogdGhpcy0+dGls
ZXNHZW9tZXRyeVswXSkgKiB0aGlzLT50aWxlc0dlb21ldHJ5WzFdKSAqICh0aGlzLT5pbnB1dEdl
b21ldHJ5WzFdICsgMSkpICogKHRoaXMtPmlucHV0R2VvbWV0cnlbMF0gKyAxKSkgKyAoKCh0aGlz
LT50aHJlYWRPdXRwdXRTdGFydFsoKGkgKiBzaXplSikgKyBqKV0gLyAodGhpcy0+b3V0cHV0R2Vv
bWV0cnlbMF0gKiB0aGlzLT5vdXRwdXRHZW9tZXRyeVsxXSkpICogKHRoaXMtPmlucHV0R2VvbWV0
cnlbMF0gKyAxKSkgKiAodGhpcy0+aW5wdXRHZW9tZXRyeVsxXSArIDEpKTsKICAgICAgaW50IG1h
dHJpeE91dHB1dFN0YXJ0ID0gKCgoKGsgKiB0aGlzLT50aWxlc0dlb21ldHJ5WzBdKSAqIHRoaXMt
PnRpbGVzR2VvbWV0cnlbMV0pICogdGhpcy0+b3V0cHV0R2VvbWV0cnlbMF0pICogdGhpcy0+b3V0
cHV0R2VvbWV0cnlbMV0pICsgdGhpcy0+dGhyZWFkT3V0cHV0U3RhcnRbKChpICogc2l6ZUopICsg
aildOwogICAgICBzaG9ydCBzdWJNYXRyaXhJID0gKHNob3J0KXRoaXMtPnRocmVhZE9mZnNldElb
aV07CiAgICAgIHNob3J0IHN1Yk1hdHJpeEogPSAoc2hvcnQpdGhpcy0+dGhyZWFkT2Zmc2V0Sltq
XTsKICAgICAgZmxvYXQgYWNjdW0gPSAwLjBmOwogICAgICBmb3IgKHNob3J0IGluZGV4TiA9IChz
aG9ydCkoLXRoaXMtPm91dHB1dEdlb21ldHJ5WzBdIC8gMik7IGluZGV4Tjw9KHRoaXMtPm91dHB1
dEdlb21ldHJ5WzBdIC8gMik7IGluZGV4TiA9IChzaG9ydCkoaW5kZXhOICsgMSkpewogICAgICAg
ICBmb3IgKHNob3J0IGluZGV4TSA9IChzaG9ydCkoLXRoaXMtPm91dHB1dEdlb21ldHJ5WzFdIC8g
Mik7IGluZGV4TTw9KHRoaXMtPm91dHB1dEdlb21ldHJ5WzFdIC8gMik7IGluZGV4TSA9IChzaG9y
dCkoaW5kZXhNICsgMSkpewogICAgICAgICAgICBzaG9ydCBmaSA9IHB0X2lzdF9jZXJpc192aXBp
dmlzdF9qb2JzX0Nyb3NzQ29ycmVsYXRpb25LZXJuZWxfX3JlbG9jYXRlWCh0aGlzLCBpbmRleE4s
IChzaG9ydCl0aGlzLT5pbnB1dEdlb21ldHJ5WzBdKTsKICAgICAgICAgICAgc2hvcnQgZmogPSBw
dF9pc3RfY2VyaXNfdmlwaXZpc3Rfam9ic19Dcm9zc0NvcnJlbGF0aW9uS2VybmVsX19yZWxvY2F0
ZVgodGhpcywgaW5kZXhNLCAoc2hvcnQpdGhpcy0+aW5wdXRHZW9tZXRyeVsxXSk7CiAgICAgICAg
ICAgIHNob3J0IGdpID0gcHRfaXN0X2NlcmlzX3ZpcGl2aXN0X2pvYnNfQ3Jvc3NDb3JyZWxhdGlv
bktlcm5lbF9fcmVsb2NhdGVYKHRoaXMsIChzaG9ydCkoc3ViTWF0cml4SSArIGluZGV4TiksIChz
aG9ydCl0aGlzLT5pbnB1dEdlb21ldHJ5WzBdKTsKICAgICAgICAgICAgc2hvcnQgZ2ogPSBwdF9p
c3RfY2VyaXNfdmlwaXZpc3Rfam9ic19Dcm9zc0NvcnJlbGF0aW9uS2VybmVsX19yZWxvY2F0ZVgo
dGhpcywgKHNob3J0KShzdWJNYXRyaXhKICsgaW5kZXhNKSwgKHNob3J0KXRoaXMtPmlucHV0R2Vv
bWV0cnlbMV0pOwogICAgICAgICAgICBhY2N1bSA9IGFjY3VtICsgKHRoaXMtPm1hdHJpeEluRlso
KG1hdHJpeElucHV0U3RhcnQgKyAoZmkgKiAodGhpcy0+aW5wdXRHZW9tZXRyeVsxXSArIDEpKSkg
KyBmaildICogdGhpcy0+bWF0cml4SW5HWygobWF0cml4SW5wdXRTdGFydCArIChnaSAqICh0aGlz
LT5pbnB1dEdlb21ldHJ5WzFdICsgMSkpKSArIGdqKV0pOwogICAgICAgICB9CiAgICAgIH0KICAg
ICAgaW50IG91dEluZGV4ID0gKG1hdHJpeE91dHB1dFN0YXJ0ICsgKChzdWJNYXRyaXhJICsgKHRo
aXMtPm91dHB1dEdlb21ldHJ5WzBdIC8gMikpICogdGhpcy0+b3V0cHV0R2VvbWV0cnlbMV0pKSAr
IChzdWJNYXRyaXhKICsgKHRoaXMtPm91dHB1dEdlb21ldHJ5WzFdIC8gMikpOwogICAgICB0aGlz
LT5tYXRyaXhPdXRbb3V0SW5kZXhdICA9IGFjY3VtOwogICAgICByZXR1cm47CiAgIH0KfQoK
--000000000000bc4929056b697fc9
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--000000000000bc4929056b697fc9--
