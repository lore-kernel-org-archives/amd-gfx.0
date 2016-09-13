From: Sanford Rockowitz <rockowitz-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Subject: need guidance re amdgpu i2c
Date: Tue, 13 Sep 2016 06:47:01 -0400
Message-ID: <57D7D925.4050306@minsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0147355687=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0147355687==
Content-Type: multipart/alternative;
 boundary="------------000404070007020700050700"

This is a multi-part message in MIME format.
--------------000404070007020700050700
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

First, apologies in advance if this is not the most appropriate list for
my questions.  Redirection appreciated.

I am the author of ddctool <www.ddctool.com>, a utility to manipulate
monitor settings using DDC/CI over I2C.

My understanding is that amdgpu provides /dev/i2c-* devices in the usual
way, so that ddctool should just work without changes.  But of course
this needs to be tested.

In this regard I have a number of questions and a request.

Does the i2c interface depend in some way on whether one is running the
AMDGPU-PRO driver?

The most current AMD card that I own in a R9 280, which is a first
generation GCN device.   Phoronix suggests that first generation GCN
support is in the works.  Will this be soon?   If not, would the current
development code for amdgpu be sufficient for me to test the i2c
support?   If so, what would I have to do to build and install it?

Or should I just plunk down a few dollars for a relatively inexpensive
R7 260, which I understand is supported by the current amdgpu?

Alternatively, if someone running the amdgpu driver would be willing to
install and test ddctool on their system I'd be most appreciative.  The
git repository is here: https://github.com/rockowitz/ddctool, and
there's extensive documentation on the website, www.ddctool.com.

A couple of command line options of note:

  "--stats" reports extensive performance statistics, including counts
of i2c retries required
  "--ddc"  reports DDC protocol data errors

If ddctool installs but does not seem to be working, command "ddctool
environment" may provide some clues.

Finally, the "ddctool interrogate" command fully exercises ddctool and
probes the i2c environment.  Depending on permissions, running it as
root may provide additional detail.  If you can capture the output and
send it to me that would be most helpful.=20

Thanks in advance,
Sanford Rockowitz


--------------000404070007020700050700
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    First, apologies in advance if this is not the most appropriate list
    for my questions.  Redirection appreciated.<br>
    <br>
    I am the author of <a href="www.ddctool.com">ddctool</a>, a utility
    to manipulate monitor settings using DDC/CI over I2C. <br>
    <br>
    My understanding is that amdgpu provides /dev/i2c-* devices in the
    usual way, so that ddctool should just work without changes.  But of
    course this needs to be tested.<br>
    <br>
    In this regard I have a number of questions and a request.<br>
    <br>
    Does the i2c interface depend in some way on whether one is running
    the AMDGPU-PRO driver?<br>
    <br>
    The most current AMD card that I own in a R9 280, which is a first
    generation GCN device.   Phoronix suggests that first generation GCN
    support is in the works.  Will this be soon?   If not, would the
    current development code for amdgpu be sufficient for me to test the
    i2c support?   If so, what would I have to do to build and install
    it?<br>
    <br>
    Or should I just plunk down a few dollars for a relatively
    inexpensive R7 260, which I understand is supported by the current
    amdgpu?<br>
    <br>
    Alternatively, if someone running the amdgpu driver would be willing
    to install and test ddctool on their system I'd be most
    appreciative.  The git repository is here:
    <a class="moz-txt-link-freetext" href="https://github.com/rockowitz/ddctool">https://github.com/rockowitz/ddctool</a>, and there's extensive
    documentation on the website, <a class="moz-txt-link-abbreviated" href="http://www.ddctool.com">www.ddctool.com</a>. <br>
    <br>
    A couple of command line options of note: <br>
    <br>
      "--stats" reports extensive performance statistics, including
    counts of i2c retries required <br>
      "--ddc"  reports DDC protocol data errors <br>
    <br>
    If ddctool installs but does not seem to be working, command
    "ddctool environment" may provide some clues. <br>
    <br>
    Finally, the "ddctool interrogate" command fully exercises ddctool
    and probes the i2c environment.  Depending on permissions, running
    it as root may provide additional detail.  If you can capture the
    output and send it to me that would be most helpful.  <br>
    <br>
    Thanks in advance, <br>
    Sanford Rockowitz<br>
    <br>
  </body>
</html>

--------------000404070007020700050700--

--===============0147355687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0147355687==--
